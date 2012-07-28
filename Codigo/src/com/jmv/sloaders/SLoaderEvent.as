package com.jmv.sloaders{
	import flash.events.Event;


	public class SLoaderEvent extends Event
	{
		public static const COMPLETE:String = "onLoadComplete";		
		public static const PROGRESS:String = "onLoadProgress";		
		public static const FILE_COMPLETE:String = "onFileLoadComplete";
		
		
		public var sloader:SLoader;
				
		public function SLoaderEvent(type:String, sloader:SLoader, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.sloader = sloader;
		}
		
	}
}