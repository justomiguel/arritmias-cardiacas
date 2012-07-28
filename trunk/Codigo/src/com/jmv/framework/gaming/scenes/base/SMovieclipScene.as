package com.jmv.framework.gaming.scenes.base {
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.core.IInitializable;
	import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.utils.SnapshotUtil;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SMovieclipScene extends MovieClip implements ISScene, IStatefulObject, IInitializable, IDisposable {
		
		private var _timeline:Timeline
		
		public function SMovieclipScene(args:Array = null) {
			this.args = args;
			// disable ugly yellow focus rect
			this.focusRect = false;
			
			_timeline = new Timeline(this);
		}
		
		public static const STATE_UNINITIALIZED:String = "STATE_UNINITIALIZED";
        public static const STATE_ACTIVE:String = "STATE_ACTIVE";
		
		protected var args:Array;
		
        /// OVERWRITTEN BY CHILDS: initializes the current Scene before its addition to the stage
        public function initialize():void
        {
            this._state = STATE_ACTIVE;
            // INIT CODE
        }
		
        /// OVERWRITTEN BY CHILDS: removes and cleans before deallocating the scene
        public function dispose():void
        {
            this._state = STATE_UNINITIALIZED;
            // CLEANUP CODE
        }
		
        // IStatefulObject Implementations
		
        protected var _state:String = STATE_UNINITIALIZED;
		
        public function set state(state:String):void
        {
            throw new SError("SScene.state is READ_ONLY");
        }
		
        public function get state():String
        {
            return this._state;
        }
		
        public function isInState(state:String):Boolean
        {
            return this._state == state;
        }
		
        public function getAllStates():Array
        {
            return [ STATE_ACTIVE, STATE_UNINITIALIZED ];
        }
		
		/* INTERFACE com.jmv.framework.gaming.scenes.base.ISScene */
		
		public function snapshot():Bitmap{
			return SnapshotUtil.takeSnapshot(this);
		}
		
		public function get timeline():Timeline {
			return _timeline;
		}
		
	}
	
}