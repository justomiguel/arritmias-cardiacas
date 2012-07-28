package com.jmv.framework.input.keyboard {
    import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.errors.SError;
	import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.EventDispatcher;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	import flash.utils.Dictionary;

    /**
     * KEYBOARD MANAGER
     *
     * Manages keyboard input both as an KEY STATE pattern and as an EventDsipatcher Pattern
     *
     * usage:
     *
     * keyboardManagerInstance.SHORTCUT == true|false -> to check if an SHORTCUT key is pressed
     * SHORTCUT TO COMMON USED KEYS registered are: UP,DOWN,LEFT,RIGHT,SPACE keys
     *
     * keyboardManagerInstance.keyIsPressed(keycode) == true|false -> to check if a key given by the keycode is pressed
     * keycodes can be found at flash.ui.Keyboard as class constants
     *
     * keyboardManagerInstance.addEventListener(KeyboardEvent.EVENT_NAME,listener)
     * can be used to listen keyboard events without a reference to the stage
     *
     * @author MatiX @ sismogames
     */
    public class KeyboardManager extends SManager{

        private var stage:DisplayObject;
        private var pressedKeys:Array;

		private var _enabled:Boolean = true;
		
		private var hotkeyCallabacks:Dictionary;
		
        /**
         *CONSTRUCTOR
         * receives the Stage of the application in witch the KEYBOARD EVENTS will be registered and listened
         *
         *@param stage:Stage, application Stage
         */
        public function KeyboardManager(stage:DisplayObject) {
            this.stage = stage;
        }

        /// UTIL: SHORCUT TO CHECK IF COMMON KEYS ARE PRESSED
        public var UP:Boolean = false;
        public var DOWN:Boolean = false;
        public var LEFT:Boolean = false;
        public var RIGHT:Boolean = false;
        public var SPACE:Boolean = false;

        override public function initialize():void {
            // Register keyboard events in the stage
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

            // init pressed keys collection
            pressedKeys = new Array();
			
			hotkeyCallabacks = new Dictionary();
        }

        override public function dispose():void {
            stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            pressedKeys = null
            stage = null
        }

        /**
         * checks if a key given by the keycode is pressed
         *
         *@param keyCode:int, the keycode of the key to be checked
         * keycodes can be found at flash.ui.Keyboard as class constants
         *
         *@return true if key is pressed, false otherwise
         */
        public function keyIsPresed(keyCode:int):Boolean {
            return pressedKeys.indexOf(keyCode) != -1;
        }

        private function onKeyDown(e:KeyboardEvent):void {
			e.stopImmediatePropagation();
            if (!enabled) return;
			// UPDATE SHORTCUTS
            switch(e.keyCode) {
                case Keyboard.UP: UP = true;break;
                case Keyboard.DOWN: DOWN = true; break;
                case Keyboard.LEFT: LEFT = true; break;
                case Keyboard.RIGHT: RIGHT = true; break;
                case Keyboard.SPACE: SPACE = true; break;
            }

			// UPDATE PRESSED KEY COLLECTIONS
            pressedKeys.push(e.keyCode);
			
			// check and dispatch hotkeys
			var callback:Function = hotkeyCallabacks[e.keyCode] as Function;
			if (callback != null) callback.call();
			
            // DISPATCH EVENT
            dispatchEvent(e);
        }

        private function onKeyUp(e:KeyboardEvent):void {
			e.stopImmediatePropagation();
			if (!enabled) return;
            // UPDATE SHORTCUTS
            switch(e.keyCode) {
                case Keyboard.UP: UP = false; break;
                case Keyboard.DOWN: DOWN = false; break;
                case Keyboard.LEFT: LEFT = false; break;
                case Keyboard.RIGHT: RIGHT = false; break;
                case Keyboard.SPACE: SPACE = false; break;	
            }

            // UPDATE PRESSED KEY COLLECTIONS
            if (keyIsPresed(e.keyCode)) {
                pressedKeys.splice(pressedKeys.indexOf(e.keyCode));
            }

            // DISPATCH EVENT
            dispatchEvent(e);
        }
		
		public function hotKey(key:Object, callback:Function):void {
			var idx:int;
			if (key is int) {
				idx = key as int;
			}
			else if (key is String) {
				if (key.length != 1) throw new SError("key parameter should be a single-character string");
				idx = key.toString().charCodeAt(0)-32;
			}
			else {
				throw new SError("key parameter should be a single-character string or an integer unicode value representing a keyboard key value");
			}
			hotkeyCallabacks[idx] = callback;
		}
		
		public function killHotkey(key:Object):void {
			var idx:int;
			if (key is int) {
				idx = key as int;
			}
			else if (key is String) {
				if (key.length != 1) throw new SError("key parameter should be a single-character string");
				idx = key.toString().charCodeAt(0)-32;
			}
			else {
				throw new SError("key parameter should be a single-character string or an integer unicode value representing a keyboard key value");
			}
			
			hotkeyCallabacks[idx] = null;
		}
		
		public function get enabled():Boolean { return _enabled; }
		
		public function set enabled(value:Boolean):void 
		{
			UP = DOWN = LEFT = RIGHT = SPACE = false;
			_enabled = value;
		}

    }

}

