package com.jmv.framework.ui 
{
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.events.UIEvent;
	/**
	 * ...
	 * @author 
	 */
	public class MutexGroup implements IDisposable
	{
		private var selectables:Array
		
		protected var _selectedItem:ISelectable;
		
		public function MutexGroup(selectables:Array = null) 
		{
			this.selectables = new Array();
			if (!selectables) return;
			for each (var selectable:ISelectable in selectables) 
			{
				addSelectable(selectable);
			}
		}
		
		public function addSelectable(s:ISelectable):void {
			s.addEventListener(UIEvent.ITEM_SELECTED_EVENT, onSelection);
			selectables.push(s);
		}
		
		public function removeSelectable(s:ISelectable):void {
			var i:int = selectables.indexOf(s);
			if (i != -1) {
				selectables.splice(i);
			}
		}
		
		protected function onSelection(e:UIEvent):void 
		{
			_selectedItem = ISelectable(e.currentTarget);
			for each (var selectable:ISelectable in selectables) 
			{
				if (selectable != _selectedItem) {
					if(selectable.enabled){
						selectable.selected = false;
					}
				}
			}
		}
		
		public function get selectedItem():ISelectable {
			return _selectedItem;
		}
		
		public function dispose():void {
			for each (var selectable:ISelectable in selectables) 
			{
				selectable.removeEventListener(UIEvent.ITEM_SELECTED_EVENT, onSelection);
			}
			selectables = null;
		}
		
	}

}