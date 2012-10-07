package com.jmv.arrtimias.simulation 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author matix
	 */
	public class SimulationEvent extends Event 
	{
		public static const PHASE_COMPLETED_EVENT:String = "phaseCompleted";
		
		public function SimulationEvent(type:String) 
		{
			super(type, bubbles, cancelable);
			
		}

		override public function clone():flash.events.Event 
		{
			return new SimulationEvent(type);
		}
	}

}