package com.jmv.framework.gaming.scenes.base
{
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.core.IInitializable;
    import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.core.state.StatefulObjectImplementation;
    import com.jmv.framework.errors.SError;
	import com.jmv.framework.gaming.gameplay.pause.IPausable;
	import com.jmv.framework.gaming.gameplay.pause.PauseManager;
	import com.jmv.framework.utils.SnapshotUtil;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
    import flash.events.Event;
	import com.jmv.framework.core.framework_internal;
	import flash.utils.Dictionary;

    /**
     * ...
     * @author MatiX @ sismogames
     */
    public class SScene extends Sprite implements ISScene,IStatefulObject, IInitializable, IDisposable, IPausable
    {

        public static const STATE_UNINITIALIZED:String = "STATE_UNINITIALIZED";
        public static const STATE_ACTIVE:String = "STATE_ACTIVE";
        public static const STATE_PAUSED:String = "STATE_PAUSED";
		
		private var _timeline:Timeline
		
		private var _state:StatefulObjectImplementation = new StatefulObjectImplementation(STATE_UNINITIALIZED);
		
		use namespace framework_internal;
		
		private var _pauseManager:PauseManager;
		
        public function SScene()
        {
			super();
			
			if (this is MovieClip) {
				_timeline = new Timeline(this as MovieClip);
			}
			
			// disable ugly yellow focus rect
			this.focusRect = false;
        }

        /// OVERWRITTEN BY CHILDS: initializes the current Scene before its addition to the stage
        public function initialize():void
        {
            _state.setSubState(STATE_ACTIVE, STATE_PAUSED);
			_state.forceSetState(STATE_ACTIVE);
            // INIT CODE
        }

        /// OVERWRITTEN BY CHILDS: removes and cleans before deallocating the scene
        public function dispose():void
        {
            _state.forceSetState(STATE_UNINITIALIZED);
			if(_pauseManager){
				_pauseManager.dispose();
				_pauseManager = null;
			}
            // CLEANUP CODE
        }

        // IStatefulObject Implementations

        public function set state(state:String):void
        {
            _state.state = state;		
        }

        public function get state():String
        {
            return _state.state;
        }

        public function isInState(state:String):Boolean
        {
            return _state.isInState(state);
        }

        public function getAllStates():Array
        {
            return [ STATE_ACTIVE, STATE_UNINITIALIZED,STATE_PAUSED ];
        }
		
		/* INTERFACE com.jmv.framework.gaming.scenes.base.ISScene */
		
		public function snapshot():Bitmap{
			return SnapshotUtil.takeSnapshot(this);
		}
		
		/* INTERFACE com.jmv.framework.gaming.scenes.base.ISScene */
		
		public function pause():void
		{
			_state.forceSetState(STATE_PAUSED);
		}
		
		public function unpause():void
		{
			_state.forceSetState(STATE_ACTIVE);
		}
		
		/* INTERFACE com.jmv.framework.core.state.IStatefulObject */
		
		public function setSubState(state:String, SubState:String):void
		{
			_state.setSubState(state, SubState);
		}
		
		public function isSubState(state:String, SubState:String):Boolean
		{
			return _state.isSubState(state, SubState);
		}
		
		public function get timeline():Timeline {
			if (!_timeline) throw new SError("TRIED TO ACCESS SCENE TIMELINE WHEN SCENE IS NOT A MOVIECLIP");
			return _timeline;
		}
		
		protected function set stateIsReadOnly(value:Boolean):void {
			var substates:Dictionary = _state.getSubstates();
			_state = new StatefulObjectImplementation(_state.state, value);
			_state.setSubstates(substates);
		}
		
		public function get pauseManager():PauseManager { 
			if (!_pauseManager) {
				_pauseManager = new PauseManager();
				_pauseManager.initialize();
			}
			return _pauseManager; 
		}
    }

}

