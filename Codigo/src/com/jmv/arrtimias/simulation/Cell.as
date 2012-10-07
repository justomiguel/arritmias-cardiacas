package com.jmv.arrtimias.simulation 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * @author matix
	 */
	public class Cell extends EventDispatcher
	{		
		static public const PROPAGATION_CHECK_TIME:Number = 100;
		
		private var p_propagationVectors:Array;
		private var p_phases:Vector.<Phase>;
		private var p_currentPhase:Phase;
		private var p_propagationPool:Array;
		private var p_propagationTimer:Timer;
		private var p_neighborhood:CellNeighborhood;
		
		public function Cell(phaseConfig:PhaseConfiguration, 
							 propagationVectors:Array = null,
							 neighborhood:CellNeighborhood = null) 
		{
			this.p_neighborhood = neighborhood;
			this.p_phases = new Vector.<Phase>();
			this.p_currentPhase = new Phase("Phase_01", phaseConfig.absolute, false, true);
			this.p_phases.push(p_currentPhase);
			this.p_phases.push(new Phase("Phase_2",  phaseConfig.relative[0]));
			this.p_phases.push(new Phase("Phase_3",  phaseConfig.relative[1] , true));
			this.p_phases.push(new Phase("Phase_4",  phaseConfig.relative[2]));
			
			for each (var phase:Phase in this.p_phases) {
				phase.addEventListener(SimulationEvent.PHASE_COMPLETED_EVENT, onPhaseCompleted);
			}
			
			this.p_propagationVectors = propagationVectors;
			
			this.p_propagationTimer = new Timer(PROPAGATION_CHECK_TIME);
			this.p_propagationTimer.addEventListener(TimerEvent.TIMER, onPropagationCheck);
			
			this.p_propagationPool = [];
		}
		
		private function onPropagationCheck(e:TimerEvent):void 
		{	
			for each (var propagation:Object in p_propagationPool) 
			{
				var now:int = getTimer();
				if ((now - propagation.started) >= propagation.delay) {
					var cell:Cell = propagation.cell as Cell;
					cell.startPropagation();
					p_propagationPool.splice(p_propagationPool.indexOf(propagation), 1);
				}
			}
		}
		
		private function onPhaseCompleted(e:SimulationEvent):void 
		{
			var phase:Phase = e.currentTarget as Phase;
			var next:uint = p_phases.indexOf(phase) + 1;
			if (next >= p_phases.length) {
				next = 0;
			}
		
			this.dispatchEvent(e);
			
			this.p_currentPhase = p_phases[next];
			if (p_currentPhase.propagates && p_neighborhood) {
				for each(var vector:Object in p_propagationVectors) {
					var propagation:Object = {
						cell: p_neighborhood.getCell(vector.direction),
						started: getTimer(),
						delay: vector.delay
					}
					
					p_propagationPool.push(propagation);
				}
			}
			
			this.p_currentPhase.start();
		}
		
		public function startPropagation():void {
			if(this.p_currentPhase.canBePropagated) {
				this.p_currentPhase.start();
				this.p_propagationTimer.start();
			}
		}
		
		public function stopPropagation():void {
			this.p_currentPhase.stop();
			this.p_propagationTimer.stop();
		}
		
		public function get currentPhase():Phase {
			return p_currentPhase;
		}
		
		public function get neighborhood():CellNeighborhood 
		{
			return p_neighborhood;
		}
		
		public function set neighborhood(value:CellNeighborhood):void 
		{
			p_neighborhood = value;
		}
		
		public function get propagationVectors():Array 
		{
			return p_propagationVectors;
		}
		
		public function set propagationVectors(value:Array):void 
		{
			p_propagationVectors = value;
		}
		
	}

}