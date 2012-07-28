package com.jmv.framework.events 
{
	import com.jmv.framework.events.SEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class UIEvent extends SEvent
	{
		
		public static const ITEM_SELECTED_EVENT:String = "ITEM_SELECTED_EVENT";
		public static const ITEM_UNSELECTED_EVENT:String = "ITEM_UNSELECTED_EVENT";
		
		public function UIEvent(type:String) 
		{
			super(type);
		}
		
		override public function clone():Event 
		{
			return new UIEvent(type);
		}
		
	}

}