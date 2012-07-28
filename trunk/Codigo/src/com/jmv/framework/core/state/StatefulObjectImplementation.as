package com.jmv.framework.core.state 
{
	import com.jmv.framework.errors.SError;
	import flash.utils.Dictionary;
	import com.jmv.framework.core.framework_internal;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public class StatefulObjectImplementation implements IStatefulObject
	{
		private var _state:String = "";
		private var _subStates:Dictionary;
		
		use namespace framework_internal;
		
		protected var stateIsReadOnly:Boolean;
		 
		
		public function StatefulObjectImplementation(initialState:String = null, stateIsReadOnly:Boolean = true) 
		{
			this._subStates = new Dictionary();
			this.state = initialState;
			this.stateIsReadOnly = stateIsReadOnly;
		}
		
		/* INTERFACE com.jmv.framework.core.state.IStatefulObject */
		
		public function get state():String
		{
			return _state
		}
		
		public function set state(state:String):void
		{
			if (stateIsReadOnly) {
				throw new SError("SatatefulObject.state is READ_ONLY");
				return
			}
			_state = state;
		}
		
		public function isInState(state:String):Boolean
		{
			return _state == state || isSubState(state, _state);
		}
		
		public function setSubState(state:String, SubState:String):void
		{
			_subStates[SubState] = state;
		}

		public function isSubState(state:String, SubState:String):Boolean
		{
			return _subStates[SubState] == state;
		}
		
		public function getAllStates():Array
		{
			// to override in childs
			return [];
		}
		
		framework_internal function forceSetState(state:String):void {
			this._state = state;
		}
		
		framework_internal function getSubstates():Dictionary {
			return _subStates;
		}
		
		framework_internal function setSubstates(substates:Dictionary):void {
			_subStates = substates;
		}
	}

}