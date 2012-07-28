package com.jmv.framework.events {
	import flash.events.Event;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SEvent extends Event {
		
		public static const APPLICATION_READY_EVENT:String = "APPLICATION_READY_EVENT";
		public static const ENTER:String = "ENTER";
		public static const EXIT:String = "EXIT";
		protected var _data:*;
		
		public function SEvent(type:String, data:* = null) {
			super(type);
			this._data = data
		}
		
		override public function clone():Event {
			return new SEvent(this.type,_data);
		}
		
		public function get data():* { return _data; }
		
	}

}

