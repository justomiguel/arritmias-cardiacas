package com.jmv.framework.input.mouse {
	import com.jmv.framework.core.managers.base.SManager;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.describeType;
	
	/**
	 * Wraps Global mouse event handling by propagating a given Stage mouse events
	 * Should be used to catch global mouse events without a refence to the stage.
	 * 
	 * also improves performance using SManager.addEventListener weak referenced by default
	 * @author MatiX @ sismogames
	 */
	public class MouseManager extends SManager{
		
		private var _stage:Stage;
		
		public function MouseManager(stage:Stage) {
			this._stage = stage;
		}
		
		override public function initialize():void {
			super.initialize();
			for each (var event:XML in describeType(MouseEvent).constant)
			{
				_stage.addEventListener(MouseEvent[event.@name], globalHandler, false, 0, true);
			}
		}
		
		private function globalHandler(e:MouseEvent):void {
			this.dispatchEvent(e);
		}
		
		public function toggleMouseCursor(activate:Boolean):void {
			if (activate) {
				Mouse.show();
			}
			else {
				Mouse.hide();
			}
		}
		
		override public function dispose():void {
			super.dispose();
			for each (var event:XML in describeType(MouseEvent).constant)
			{
				_stage.removeEventListener(MouseEvent[event.@name], globalHandler);
			}
		}
	}
	
}