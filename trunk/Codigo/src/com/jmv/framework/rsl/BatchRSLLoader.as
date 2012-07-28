package com.jmv.framework.rsl {
	import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.events.RSLEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class BatchRSLLoader extends SManager{
		
		private var loadList:Dictionary;
		private var rslLoader:RSLLoader;
		private var pendingLoads:int = -1;
		private var loaders:Array;
		
		private static var referenceHolder:Array = new Array();
		
		public static function freeAllLibraryReferences():void {
			referenceHolder = new Array();
		}
		
		public function BatchRSLLoader() {
		}
		
		override public function initialize():void {
			super.initialize();
			loadList = new Dictionary();
			loaders = [];
		}
		
		override public function dispose():void {
			super.dispose();
			loadList = null;
		}
		
		public function addLibrary(key:String, source:Object, domain:String = null):void {
			// check if initialized
			if (!isInState(SManager.STATE_READY)) throw new SError("TRIED TO ADD LIBRARY WHEN MANAGER IS NOT STATE_READY");
			// check if pending loads
			if (pendingLoads > 0) throw new SError("TRIED TO ADD LIBRARY TO BATCH WHEN THERE'S PENDING LIBRARIES TO LOAD");
			// check is key is unique
			if (loadList[key]) throw new SError("key: " + key + " already in use!!");
			
			// add to load list
			loadList[key] = {source:source, domain:domain};
		}
		
		public function start():void {
			if (!isInState(SManager.STATE_READY)) throw new SError("TRIED TO START BATCH WHEN MANAGER IS NOT STATE_READY");
			if (pendingLoads > 0) throw new SError("TRIED TO START BATCH WHEN THERE'S PENDING LIBRARIES TO LOAD");
			
			pendingLoads = 0;
			for (var key:String in loadList) {
				rslLoader = new RSLLoader(key);
				rslLoader.initialize();
				rslLoader.addEventListener(RSLEvent.LIBRARY_LOADED_EVENT, onLibraryLoaded);
				rslLoader.addEventListener(RSLEvent.LIBRARY_IOERROR_EVENT, onLibraryError);
				var domain:String = loadList[key].domain;
				if (!domain) domain = RSLDomain.DOMAIN_CURRENT_DOMAIN;
				rslLoader.load(loadList[key].source, domain);
				pendingLoads ++;
				loaders.push(rslLoader);
			}
		}
		
		private function onLibraryError(e:RSLEvent):void {
			dispatchEvent(e);
			loaders.splice(loaders.indexOf(e.loader), 1);
		}
		
		private function onLibraryLoaded(e:RSLEvent):void {
			referenceHolder.push(e.loader.loadedContent);
			dispatchEvent(e);
			pendingLoads --
			if (pendingLoads <= 0) {
				dispatchEvent(new RSLEvent(RSLEvent.BATCH_LOAD_FINISHED_EVENT));
			}
			loaders.splice(loaders.indexOf(e.loader), 1);
		}
		
	}
	
}