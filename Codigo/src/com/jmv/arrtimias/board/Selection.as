package com.jmv.arrtimias.board 
{
	import com.jmv.arrtimias.events.PickerEvent;
	import com.jmv.arrtimias.menues.properties.VelocityAdjustView;
	import com.jmv.arrtimias.utilities.ColorPicker;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class Selection extends Sprite{
		
		private var my_menu:ContextMenu;
		
		private var _isSelectingCells:Boolean;
		private var caller:Sprite;
		
		private var setColor:ContextMenuItem;
		private var setVelocity:ContextMenuItem;
		
		private var colorPicker:ColorPicker;
		private var velocityAdjustView:VelocityAdjustView;
		
		public function Selection(caller:Sprite) {
			//buil the menu
			menu = new ContextMenu();
			//make the custom item
			setColor = new ContextMenuItem("Set Color");
			setVelocity = new ContextMenuItem("Set Velocity");
			
			my_menu.customItems.push(setColor);
			my_menu.customItems.push(setVelocity);
			
			//setting the listener to this menu
			setColor.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, setColorToCells);
			setVelocity.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, setVelocityToCells);
			
			//creating the color picker
			colorPicker = new ColorPicker();
			velocityAdjustView = new VelocityAdjustView();
			
			//make the other variables get value
			this.caller = caller;
			isSelectingCells = false;
			
		}
		
		private function setVelocityToCells(e:ContextMenuEvent):void 
		{
			velocityAdjustView.showColorPicker(this);
		}
		
		public function createListeners():void {
			caller.addEventListener(MouseEvent.MOUSE_DOWN, startSelectingOnBoard);
			caller.addEventListener(MouseEvent.MOUSE_UP, stopSelectingOnBoard);
			caller.addEventListener(MouseEvent.ROLL_OUT, stopSelectingOnBoardOnRollOut);
		}
		
		public function destroyListeners():void {
			if (caller.hasEventListener(MouseEvent.MOUSE_MOVE))
				caller.removeEventListener(MouseEvent.MOUSE_DOWN, startSelectingOnBoard);
			if (caller.hasEventListener(MouseEvent.MOUSE_UP))
				caller.removeEventListener(MouseEvent.MOUSE_UP, stopSelectingOnBoard);
			if (caller.hasEventListener(MouseEvent.ROLL_OUT))
				caller.removeEventListener(MouseEvent.ROLL_OUT, stopSelectingOnBoardOnRollOut);
		}
		
		private function stopSelectingOnBoard(e:MouseEvent):void {
			isSelectingCells = false;
		}
		
		public function removeSelection():void {
			//remove the previous selection
			if (this.parent != null) {
				caller.removeChild(this);
			}
		}
		private function startSelectingOnBoard(e:MouseEvent):void {
			
			removeSelection();
			
			//set the new selection values
			isSelectingCells = true;
			this.height = 0;
			this.width = 0;
			this.caller.addChild(this);
			
			//positioning on the new coords
			this.x = this.parent.mouseX;
			this.y = this.parent.mouseY;
			
			//getting the listeners to draw it
			caller.addEventListener(MouseEvent.MOUSE_MOVE, drawSelection);
			
			//set the menu
			contextMenu = my_menu;
			contextMenu.hideBuiltInItems();
		}
		
		private function setColorToCells(e:ContextMenuEvent):void {
			colorPicker.showColorPicker(this);
			colorPicker.addEventListener(PickerEvent.EVENT_TYPE, getColorChosed);
		}
		
		private function getColorChosed(e:PickerEvent):void {
			trace("vino color " + e.color);
			this.dispatchEvent(new PickerEvent(e.color));
			colorPicker.removeEventListener(PickerEvent.EVENT_TYPE, getColorChosed);
			removeSelection();
			//stopSelectingOnBoard(null);
		}
		
		private function drawSelection(e:MouseEvent):void {
			if (_isSelectingCells) {
				var localX:Number = this.caller.mouseX;
				var localY:Number = this.caller.mouseY;
				this.width = localX - this.x;
				this.height = localY - this.y;
			}
		}
		
		private function stopSelectingOnBoardOnRollOut(e:MouseEvent):void {
			if (isSelectingCells) {
				isSelectingCells = false;
			}
		}
		public function get menu():ContextMenu {
			return my_menu;
		}
		
		public function set menu(value:ContextMenu):void {
			my_menu = value;
		}
		
		public function get isSelectingCells():Boolean 
		{
			return _isSelectingCells;
		}
		
		public function set isSelectingCells(value:Boolean):void 
		{
			_isSelectingCells = value;
			if (!value) {
				if (caller.hasEventListener(MouseEvent.MOUSE_MOVE)) {
					caller.removeEventListener(MouseEvent.MOUSE_MOVE, drawSelection);
				}
			}
		}
	}

}