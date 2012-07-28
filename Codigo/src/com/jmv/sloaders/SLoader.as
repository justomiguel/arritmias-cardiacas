package com.jmv.sloaders
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	
	public class SLoader extends EventDispatcher
	{
		private var _id:String;
		
		private var filesURL:Object;
		public var filesContent:Object;		
		private var filesPercent:Object;		
		
		private var loaders:Object;		

		private var filesLength:uint;
		private var filesComplete:uint;
		
		private var totalPercent:Number;
		private var ldrContext:LoaderContext;
		
		
		
		public function SLoader(id:String)
		{
			this._id = id;			
			this.initAll();
		}
		
		private function initAll():void
		{
			this.filesURL = {};			
			this.filesContent = {};
			this.filesPercent = {};
			this.loaders = {};
			this.filesLength = 0;
			this.filesComplete = 0;
		}
		
		private function init(id:String):void
		{
			this.filesURL[id] = null;			
			this.filesContent[id] = null;
			this.filesPercent[id] = null;
			this.loaders[id] = null;
		}
				
		public function add(url:String, id:String):void
		{
			this.init(id);
			this.filesURL[id] = url;			
			this.filesLength++;			
		}
		
		public function unloadAll():void
		{
			var id:String;
			for (id in this.filesURL)
			{
				var url:String = this.filesURL[id];
				var filetype:String = this.getFileType(url); 
				if ( filetype != "mp3" && filetype != "xml" )
				{
					LoaderInfo(this.loaders[id]).loader.unload();
				}
								
			}
			for (id in this.filesURL)
			{
				this.init(id);
			}
			this.initAll();
		}
		
		public function cleanup():void
		{
			this.unloadAll();
			this.filesURL = null;			
			this.filesContent = null;
			this.filesPercent = null;
			this.loaders = null;
			this._id = null;
		}
		
		public function loadAll():void
		{
			for (var id:String in this.filesURL)
			{							
				var url:String = this.filesURL[id];
				
				switch(this.getFileType(url))
				{
					case "mp3":
						var sound:Sound = new Sound();
						sound.load(new URLRequest(url));
						sound.addEventListener(ProgressEvent.PROGRESS, onFileLoadingProgress, false, 0, true);
						sound.addEventListener(Event.COMPLETE, onFileLoadingComplete, false, 0, true);
						this.loaders[id] = sound;
					break;
					
					case "xml":
						var xmlLoader:URLLoader = new URLLoader();
						xmlLoader.load(new URLRequest(url));
						xmlLoader.addEventListener(ProgressEvent.PROGRESS, onFileLoadingProgress, false, 0, true);
						xmlLoader.addEventListener(Event.COMPLETE, onFileLoadingComplete, false, 0, true);
						this.loaders[id] = xmlLoader;
					break;
					
					default:
						var loader:Loader = new Loader();
						ldrContext = new LoaderContext(false, ApplicationDomain.currentDomain); 
						loader.load(new URLRequest(url), ldrContext);
						loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onFileLoadingProgress, false, 0, true);
						loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFileLoadingComplete, false, 0, true);
						this.loaders[id] = loader.contentLoaderInfo;
					break;
				}
			}	
		}
		
		
		private function onFileLoadingProgress(e:ProgressEvent):void
		{
			var id:String = this.getFileId(e.target);
			this.filesPercent[id] = e.bytesLoaded / e.bytesTotal;
			this.totalPercent = 0;
			for (var __id:String in this.filesPercent)
				this.totalPercent += this.filesPercent[__id];
			this.totalPercent /= this.filesLength;	
						
			this.dispatchEvent( new SLoaderEvent(SLoaderEvent.PROGRESS, this) );			
		}
		
		private function onFileLoadingComplete(e:Event):void
		{
			var url:String = this.getFileURL(e.target);
			var id:String = this.getFileId(e.target);
			
			switch(this.getFileType(url))
			{
				case "mp3":
					this.filesContent[id] = Sound(e.target);
				break;
				
				case "xml":
					this.filesContent[id] = XML(e.target.data);
					this.filesContent[id].ignoreWhitespace = true;
				break;
				
				default:
					this.filesContent[id] = LoaderInfo(e.target).content;
				break;
			}

			this.filesComplete++;
			this.dispatchEvent( new SLoaderEvent(SLoaderEvent.FILE_COMPLETE, this) );
			
			if (this.filesComplete == this.filesLength)
			{
				this.dispatchEvent( new SLoaderEvent(SLoaderEvent.COMPLETE, this) );
			}
		}
		
		public function getPercentLoaded():Number
		{
			return this.totalPercent;
		}
		
		public function getContent(id:String):*
		{
			var content:* = this.filesContent[id];
			return content;
		}
		
		private function getFileURL(loader:*):String
		{
			for (var id:String in this.loaders)
			{
				if (loader == this.loaders[id])
					return this.filesURL[id];
			}
			return null;
		}
		
		private function getFileId(loader:*):String
		{
			for (var id:String in this.loaders)
			{
				if (loader == this.loaders[id])
					return id;
			}
			return null;
		}
		
		private function getFileIdByURL(url:*):String
		{
			for (var id:String in this.filesURL)
			{
				if (url == this.filesURL[id])
					return id;
			}
			return null;
		}
		
		private function getFileType(url:String):String
		{
			var arr:Array = url.split("/");
			return String(arr[arr.length-1]).split(".")[1];
		}
		
		public function getId():String
		{
			return this._id;			
		} 

	}
}
