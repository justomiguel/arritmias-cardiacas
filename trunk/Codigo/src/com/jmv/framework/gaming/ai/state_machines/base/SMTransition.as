package com.jmv.framework.gaming.ai.state_machines.base 
{
	/**
	 * ...
	 * @author Facu
	 */
	public class SMTransition
	{
		
		private var _nextState:SMState;
		private var _previousState:SMState;
		private var _event:String;
		private var _description:String;
		private var _condition:Function;
		private var _action:Function;
		
		
		public function SMTransition(previousState:SMState, nextState:SMState, event:String, condition:Function = null, action:Function = null):void {
			_previousState = previousState;
			_nextState = nextState;
			_condition = condition;
			_action = action;
			_event = event;
		}
		
		public function get nextState():SMState { return _nextState; }
		
		public function set nextState(value:SMState):void 
		{
			_nextState = value;
		}
		
		public function get previousState():SMState { return _previousState; }
		
		public function set previousState(value:SMState):void 
		{
			_previousState = value;
		}
		
		public function get event():String { return _event; }
	
		//public function set event(value:SMEvent):void {
			//_event = value;
		//}
		
		public function get description():String { return _description; }
		
		public function set description(value:String):void 
		{
			_description = value;
		}
		
		public function get condition():Function { return _condition; }
		
		public function set condition(value:Function):void 
		{
			_condition = value;
		}
		
		public function get action():Function { return _action; }
		
		public function set action(value:Function):void 
		{
			_action = value;
		}
		
	}

}