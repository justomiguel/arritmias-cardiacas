package com.jmv.framework.rsl {
	import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.events.RSLEvent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class RSLLoader extends SManager {
		
		private var _loader:Loader;
		private var _isSeparateContext:Boolean;
		
		private var _appDomain:ApplicationDomain;
		private var _rsl:RSL;
		
		private var _libraryID:String;
		
		public function RSLLoader(libraryID:String = null) {
			_libraryID = libraryID;
		}
		
		override public function initialize():void {
			super.initialize();
			
			_loader = new Loader();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		public function load(source:Object, domain:String):void {
			if (!isInState(SManager.STATE_READY)) throw new SError("TRIED TO LOAD RSL WHEN MANAGER IS NOT STATE_READY!!");
			
			var rslIsEmbeded:Boolean;
			var request:URLRequest;
			var bytes:ByteArray;
			
			// analize source
			if (source is String) {
				// if source is an url string
				rslIsEmbeded = false;
				request = new URLRequest(source as String);
			}
			else if (source is URLRequest) {
				// if source is an URLRequest
				rslIsEmbeded = false;
				request = source as URLRequest;
			}
			else if (source is ByteArray) {
				// if source is a byte array
				bytes = source as ByteArray;
				rslIsEmbeded = true;
			}
			else if (source is Class) {
				try {
					bytes = ByteArray(new (source)());
				}
				catch (e:Error) {
					throw new SError("class " + source + " is not an byte array");
				}
				rslIsEmbeded = true;
			}
			else {
				throw new SError("source type not supported: + " + source);
			}
			
			_isSeparateContext = false;
			
			// setup _loader context;
			var context:LoaderContext = new LoaderContext();
			
			if (domain == RSLDomain.DOMAIN_CURRENT_DOMAIN) {
				_appDomain = ApplicationDomain.currentDomain;
			}
			else if (domain == RSLDomain.DOMAIN_SEPARATE_DOMAIN) {
				_appDomain = new ApplicationDomain();
				_isSeparateContext  = true;
			}
			else if (domain == RSLDomain.DOMAIN_CHILD_DOMAIN) {
				_appDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			}
			else {
				throw new SError("domain type not supported + " + domain);
			}
			
			context.applicationDomain = _appDomain;
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			if (rslIsEmbeded) {
				_loader.loadBytes(bytes, context);
			}
			else {
				if (!SApplication.application || SApplication.application.loaderInfo.url.indexOf("file://") == -1) {
					context.securityDomain = SecurityDomain.currentDomain;
				}
				_loader.load(request, context);
			}
		}
		
		private function onError(e:IOErrorEvent):void {
			dispatchEvent(new RSLEvent(RSLEvent.LIBRARY_IOERROR_EVENT, this._libraryID));
		}
		
		public function get lastLoadedRSL():RSL {
			return _rsl;
		}
		
		public function get loadedContent():Object {
			return _loader.content;
		}
		
		private function onLoadComplete(e:Event):void {
			var rsle:RSLEvent = new RSLEvent(RSLEvent.LIBRARY_LOADED_EVENT, this._libraryID,this)
			if (_isSeparateContext) {
				_rsl = new RSL(_appDomain);
				rsle.rsl = _rsl;
			}
			dispatchEvent(rsle);
		}
		
	}
	
}