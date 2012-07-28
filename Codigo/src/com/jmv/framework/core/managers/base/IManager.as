package com.jmv.framework.core.managers.base {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public interface IManager {
		function initialize():void
		function dispose():void
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void
		function dispatchEvent(event:Event):Boolean
		function hasEventListener(type:String):Boolean
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		function willTrigger(type:String):Boolean
		function get state():String
		function set state(state:String):void
		function isInState(state:String):Boolean
		function getAllStates():Array
	}
	
}