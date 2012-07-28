package com.jmv.framework.events {
	import com.jmv.framework.rsl.RSL;
	import com.jmv.framework.rsl.RSLLoader;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class RSLEvent extends SEvent{
		
		public static const LIBRARY_LOADED_EVENT:String = "LIBRARY_LOADED_EVENT";
		public static const LIBRARY_IOERROR_EVENT:String = "LIBRARY_IOERROR_EVENT";
		public static const BATCH_LOAD_FINISHED_EVENT:String = "BATCH_LOAD_FINISHED_EVENT";
		
		public var libraryID:String = null;
		public var rsl:RSL;
		public var loader:RSLLoader;
		
		public function RSLEvent(type:String, libraryID:String = null, loader:RSLLoader = null) {
			super(type);
			this.libraryID = libraryID;
			this.loader = loader;
		}
		
		override public function clone():Event {
			return new RSLEvent(this.type, this.libraryID, this.loader);
		}
	}
	
}