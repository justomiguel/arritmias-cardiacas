package com.jmv.framework.core.managers.base {
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.core.IInitializable;
	import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.core.state.StatefulObjectImplementation;
	import com.jmv.framework.errors.SError;
	import flash.events.EventDispatcher;
	import com.jmv.framework.core.framework_internal;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SManager extends EventDispatcher implements IManager, IInitializable, IDisposable, IStatefulObject {

		protected var _state:StatefulObjectImplementation;
		
		use namespace framework_internal;
		
		public function SManager() {
			_state = new StatefulObjectImplementation(STATE_UNITIALIZED,false);
		}

		/// Initizalizes manager - OVERRITEN BY CHILDREN
		public function initialize():void {
			_state.forceSetState(STATE_READY);
		}

		/// Cleans up manager - OVERRITEN BY CHILDREN
		public function dispose():void {
			if (isInState(STATE_UNITIALIZED)) throw new SError("TRIED TO DISPOSE MANAGER WHEN NOT PREVIOUSLY IN INITIALIZED");
			_state.forceSetState(STATE_UNITIALIZED);
		}
		
		// IStatefulObject implementations //////////////////////////
		
		public static const STATE_UNITIALIZED:String = "STATE_UNITIALIZED";
		public static const STATE_READY:String = "STATE_READY";

		public function get state():String {
			return _state.state
		}

		public function set state(state:String):void {
			_state.state = state;
		}

		public function isInState(state:String):Boolean {
			return _state.isInState(state);
		}

		public function getAllStates():Array {
			return [STATE_UNITIALIZED, STATE_READY];
		}
		
		public function setSubState(state:String, SubState:String):void
		{
			_state.setSubState(state, SubState);
		}
		
		public function isSubState(state:String, SubState:String):Boolean
		{
			return _state.isSubState(state, SubState);
		}
		
		// PERFORMANCE TWEAK: Make addEventListener create weak references by default
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
	}

}

