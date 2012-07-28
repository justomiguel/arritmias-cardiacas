package com.jmv.framework.gaming.ai.state_machines.interfases 
{
	
	/**
	 * ...
	 * @author 
	 */
	 
	public interface SMStateObject {
		
		function get state():String;
		function isInState(state:String):Boolean;
		function getAllStates():Array;
		
	}
	
	
	
	
}