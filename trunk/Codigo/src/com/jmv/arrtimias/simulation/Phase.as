package com.jmv.arrtimias.simulation 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author matix
	 */
	[Event(name="phaseCompleted", type="com.jmv.arrtimias.simulation.SimulationEvent")]
	public class Phase extends EventDispatcher 
	{
		private var p_name:String;
		private var p_timer:Timer;
		private var p_propagates:Boolean;
		private var p_canBePropagated:Boolean;
		
		public function Phase(name:String, duration:Number, propagates:Boolean = false, canBePropagated:Boolean = false) 
		{
			this.p_canBePropagated = canBePropagated;
			this.p_propagates = propagates;
			this.p_timer = new Timer(duration, 1);
			this.p_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onPhaseComplete);
			this.p_name = name;
		}
		
		private function onPhaseComplete(e:TimerEvent):void 
		{
			this.dispatchEvent(new SimulationEvent(SimulationEvent.PHASE_COMPLETED_EVENT));
		}
		
		public function get name():String 
		{
			return p_name;
		}
		
		public function get propagates():Boolean 
		{
			return p_propagates;
		}
		
		public function get canBePropagated():Boolean 
		{
			return p_canBePropagated;
		}
		
		public function start():void {
			this.p_timer.start();
		}
		
		public function stop():void {
			this.p_timer.stop();
		}
		
	}

}