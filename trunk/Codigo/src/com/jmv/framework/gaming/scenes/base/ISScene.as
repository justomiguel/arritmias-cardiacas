package com.jmv.framework.gaming.scenes.base {
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.gaming.gameplay.pause.PauseManager;
	import flash.display.Bitmap;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public interface ISScene extends IEventDispatcher {
		function initialize():void
        function dispose():void
        function set state(state:String):void
        function get state():String
        function isInState(state:String):Boolean
        function getAllStates():Array
		function snapshot():Bitmap;
		function pause():void;
		function unpause():void;
		function get timeline():Timeline;
		function get pauseManager():PauseManager;
	}
	
}