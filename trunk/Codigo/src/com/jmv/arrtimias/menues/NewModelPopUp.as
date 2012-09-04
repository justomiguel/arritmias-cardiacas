package com.jmv.arrtimias.menues 
{
	import com.jmv.arrtimias.events.GeneralArritmiaEvent;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class NewModelPopUp extends Sprite 
	{
		
		public var filas:TextField;
		public var columnas:TextField;
		
		public var btnCrear:SimpleButton;
		
		public var background:Sprite;
		
		public function NewModelPopUp() {
			super();
			filas.restrict = "0-9";
			columnas.restrict = "0-9";
		}
		
		public function showNewModelPopUp(caller:Sprite):void {
			caller.stage.addChild(this);
			this.x = this.stage.width/2 - this.width/2
			this.y = this.stage.height / 2 - this.height / 2
			btnCrear.addEventListener(MouseEvent.CLICK, crearModelo);
			this.background["close"].addEventListener(MouseEvent.CLICK, removeFromStage);
		}
		private function crearModelo(e:MouseEvent):void {
			
			var newFilas:uint = uint(filas.text);
			var newCol:uint = uint(columnas.text);
			
			if (newCol != 0 && newFilas != 0) {
				var event:GeneralArritmiaEvent = new GeneralArritmiaEvent(GeneralArritmiaEvent.NEW_MODEL_EVENT, { filas:newFilas, columnas:newCol } ); 
				this.dispatchEvent(event);
			}
			
			this.filas.text = "0";
			this.columnas.text = "0";
			removeFromStage();	
		}
		
		private function removeFromStage(e:Event = null):void 
		{
			if (btnCrear.hasEventListener(MouseEvent.CLICK)) {
				this.background["close"].addEventListener(MouseEvent.CLICK, removeFromStage);
			}
			
			if (btnCrear.hasEventListener(MouseEvent.CLICK)) {
				btnCrear.removeEventListener(MouseEvent.CLICK, crearModelo);
			}
			if (parent != null) {
				parent.removeChild(this);
			}
		}
	}

}