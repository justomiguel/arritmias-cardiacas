package com.jmv.framework.core.state {

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public interface IStatefulObject {
		function get state():String;
		function set state(state:String):void;
		function isInState(state:String):Boolean;
		function setSubState(state:String, SubState:String):void
		function isSubState(state:String, SubState:String):Boolean
		function getAllStates():Array;
	}

}

