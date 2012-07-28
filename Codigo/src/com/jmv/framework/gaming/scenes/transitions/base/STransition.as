package com.jmv.framework.gaming.scenes.transitions.base {
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class STransition extends EventDispatcher implements ISTransition{
		public function STransition() {
		}
		public function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void {
		}
		public function start():void {
		}
	}

}

