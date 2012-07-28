package com.jmv.framework.gaming.display {
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.core.IInitializable;
	import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.events.StateEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class StatefulMovieClip extends MovieClip implements IStatefulObject, IDisposable, IInitializable {
		
		public var canSetSameState:Boolean = false;
		
		public function StatefulMovieClip() {
			super();
		}
		
		/* INTERFACE com.jmv.framework.core.IInitializable */
		public function initialize():void {
			this.addEventListener(Event.ENTER_FRAME, updateState, false, 0, true);
			this.gotoAndStop(1);
		}
		
		/* INTERFACE com.jmv.framework.core.IDisposable */
		public function dispose():void {
			this.removeEventListener(Event.ENTER_FRAME, updateState);
		}
		
		private function updateState(e:Event = null):void {
			if (this.currentLabel && (this.currentLabel != this._state)){
				var prevState:String = this._state;
				this._state = this.currentLabel;
				dispatchEvent(new StateEvent(StateEvent.STATE_CHANGED_EVENT, prevState, this._state));
			}
		}
		
		// IStatefulObject Implementations
		private var _state:String = ""
		
		public function get state():String {
			return this._state;
		}
		
		public function set state(value:String):void {
			if(!canSetSameState && (value != this._state)){
				this.gotoAndPlay(value);
			}
		}
		
		public function isInState(state:String):Boolean {
			return this._state == state;
		}
		
		public function getAllStates():Array {
			return [];
		}
		
	}
	
}