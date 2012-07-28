package com.jmv.framework.gaming.ai.state_machines.base 
{
	/**
	 * ...
	 * @author Facu
	 */
	public class SMState
	{
		
		private var _name:String;
		private var _transitions:Array;
		private var _action:Function;
		private var _enterAction:Function;
		private var _exitAction:Function;
		
		
		public function SMState(name:String, action:Function = null, enterAction:Function = null, exitAction:Function = null) 
		{
			_name = name;
			_action = action;
			_enterAction = enterAction;
			_exitAction = exitAction;
			_transitions = new Array();
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get transitions():Array { return _transitions; }
		
		public function set transitions(value:Array):void 
		{
			_transitions = value;
		}
		
		public function get action():Function { return _action; }
		
		public function set action(value:Function):void 
		{
			_action = value;
		}
		
		public function get enterAction():Function { return _enterAction; }
		
		public function get exitAction():Function { return _exitAction; }
		
		
		
	}

}