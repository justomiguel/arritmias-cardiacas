package com.jmv.arrtimias.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class GeneralArritmiaEvent extends Event 
	{
		public static const NEW_MODEL_EVENT:String = "New_Model";
		public static const ACTIVE_MODEL_EVENT:String = "ACTIVE_EVENT";
		public static const DEACTIVE_MODEL_EVENT:String = "DEACTIVE_EVENT";
		
		public var data:*;
		
		public function GeneralArritmiaEvent(type:String, data:* = null) 
		{
			super(type);
			this.data = data;
		}
		
	}

}