package com.jmv.arrtimias.events 
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class PickerEvent extends Event 
	{
		public static const EVENT_TYPE:String = "ColorChossed";
		
		private var _color:ColorTransform;
		public function PickerEvent(colorChossed:ColorTransform) 
		{
			super(EVENT_TYPE);
			this.color = colorChossed;
		}
		
		public function get color():ColorTransform 
		{
			return _color;
		}
		
		public function set color(value:ColorTransform):void 
		{
			_color = value;
		}
		
	}

}