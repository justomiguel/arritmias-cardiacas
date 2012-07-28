package com.jmv.framework.events {
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class StateEvent extends SEvent{
		
		public static const STATE_CHANGED_EVENT:String = "STATE_CHANGED_EVENT";
		
		public var previusState:String="";
		public var currentState:String="";
		
		public function StateEvent(type:String,previusState:String, currentState:String) {
			super(type);
			this.previusState = previusState;
			this.currentState = currentState;
		}
		
	}
	
}