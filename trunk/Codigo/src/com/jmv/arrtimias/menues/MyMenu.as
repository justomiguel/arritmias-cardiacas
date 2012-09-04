package com.jmv.arrtimias.menues 
{
	import com.jmv.arrtimias.events.GeneralArritmiaEvent;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import fl.controls.ComboBox;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class MyMenu extends Sprite
	{
		public var archiveTab:Sprite;
		public var archiveCombo:ComboBox; 
		public var activarModelo:Button; 
		public var desactivarModelo:Button; 
		
		private var newModelPopUp:NewModelPopUp;
		
		public function MyMenu() {
			setupComboBox();
			setupButtons();
			newModelPopUp = new NewModelPopUp();
		}
		
		private function setupButtons():void 
		{
			activarModelo.label = "Activar Modelo";
			activarModelo.addEventListener(MouseEvent.CLICK, activarModelof);
			
			desactivarModelo.label = "Desactivar Modelo";
			desactivarModelo.addEventListener(MouseEvent.CLICK, desactivarModelof);
		}
		
		private function desactivarModelof(e:MouseEvent):void {
			this.dispatchEvent(new GeneralArritmiaEvent(GeneralArritmiaEvent.DEACTIVE_MODEL_EVENT));
		}
		
		private function activarModelof(e:MouseEvent):void {
			this.dispatchEvent(new GeneralArritmiaEvent(GeneralArritmiaEvent.ACTIVE_MODEL_EVENT));
		}
		
		private function setupComboBox():void {
            archiveCombo.prompt = "Archive";
			archiveTab.mouseEnabled = false;
			archiveTab.mouseChildren = false;
			archiveCombo.addItem( { label: "Nuevo Modelo...", procedure:createNewModel } );
            archiveCombo.addEventListener(Event.CHANGE, cardSelected);            
        }
		
		private function createNewModel():void {
			newModelPopUp.showNewModelPopUp(this);
			newModelPopUp.addEventListener(GeneralArritmiaEvent.NEW_MODEL_EVENT, dispatchNewModelEvent)
		}
		
		private function dispatchNewModelEvent(e:GeneralArritmiaEvent):void {
			var event:GeneralArritmiaEvent = new GeneralArritmiaEvent(e.type, e.data);
			this.dispatchEvent(event);
			newModelPopUp.removeEventListener(GeneralArritmiaEvent.NEW_MODEL_EVENT, dispatchNewModelEvent);
		}

        private function cardSelected(e:Event):void {
            //tf.text = "You have selected: "
            archiveCombo.selectedItem.procedure.apply(this);
			archiveCombo.selectedItem = 0;
			
        }
		
	}

}