package com.jmv.arrtimias.menues.properties 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class VelocityAdjustView extends Sprite 
	{
		
		public var fase1:Sprite;
		public var fase2:Sprite;
		public var fase3:Sprite;
		
		public var selector1:Sprite;
		public var selector2:Sprite;
		public var selector3:Sprite;
		
		public var close:Sprite;
		
		public var selectorDragging:Sprite;
		
		public function VelocityAdjustView() 
		{
			super();
			
		}
		
		public function showColorPicker(myParent:Sprite):void {
			myParent.stage.addChild(this);
			this.x = this.stage.width / 2 - this.width / 2;
			this.y = this.stage.height / 2 - this.height / 2;
			
			// add listeners to the buttons
			close.addEventListener(MouseEvent.CLICK, removeFromStage);
			
			selector1.addEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
			selector1.addEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
			
			selector2.addEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
			selector2.addEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
			
			selector3.addEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
			selector3.addEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
		}
		
		private function dragSelector(e:MouseEvent):void 
		{
			if (selectorDragging != null) {
				var localX:Number = this.parent.mouseX;
				this.selectorDragging.x = mouseX;
				
				//update all sliders
				for (var i:int = 1; i < 4; i++) {
					var fase:Sprite = this["fase" + i] as Sprite;
					var slider:Sprite = this["selector" + i] as Sprite;
					
					var posOfFase:uint = (i == 1)? fase.x :  this["selector" + (i - 1)].x;
					fase.x = posOfFase;
					fase.width = slider.x - posOfFase; 
				}
				
			}
		}
		
		private function stopDraggingSelector(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, dragSelector);
			selectorDragging = null;
		}
		
		private function startDraggingSelector(e:MouseEvent):void {
			selectorDragging = e.target as Sprite;
			this.addEventListener(MouseEvent.MOUSE_MOVE, dragSelector);
		}
		
		private function removeFromStage(e:Event = null):void 
		{	
			if (parent != null) {
				selector1.removeEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
				selector1.removeEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
			
				selector2.removeEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
				selector2.removeEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
			
				selector3.removeEventListener(MouseEvent.MOUSE_DOWN, startDraggingSelector);
				selector3.removeEventListener(MouseEvent.MOUSE_UP, stopDraggingSelector);
				
				this.parent.removeChild(this);
			}
		}
		
	}

}