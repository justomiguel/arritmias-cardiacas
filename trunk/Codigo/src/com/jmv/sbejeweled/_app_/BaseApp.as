package com.jmv.sbejeweled._app_
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.tween.STween;
	import com.jmv.sbejeweled.screens.Loading;
	import com.jmv.sbejeweled.screens.TransitionClass;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	

	public class BaseApp extends SApplication
	{
		static public var BASE:String = null;		
		static public var BASE_LARGE_MEDIA:String = null;		
		
		public static const WIDTH:Number = 750;
		public static const HEIGHT:Number = 500;
		public const FRAMERATE:Number = 30;		
		public const DEBUG:Boolean = false;
		
		private var loading:Loading;
				
		
		public function BaseApp()
		{
			super();
			
		}
		
		
		public override function dispose():void
		{
			this.loading = null;
			super.dispose();
		}
		
		public function load():void
		{
			
			this.loadBaseURL();	
		}	
		
		private function loadBaseURL():void
		{
			
			var url:String = "data/abslouteURL.xml";
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest(url));
			xmlLoader.addEventListener(Event.COMPLETE, onLoadBaseURLComplete);
		}
		
		private function onLoadBaseURLComplete(e:Event):void
		{
			
			var data:XML = new XML(e.target.data);
			BASE = data.@media.toString();
			BASE_LARGE_MEDIA = data.@largeMedia.toString();
			
			onBaseComplete();
		}
		
		protected function onBaseComplete():void
		{
			
		}
		
		
		protected function loadLoading():void {
			 trace ("loadLoading : " + loadLoading );
			var loader:Loader = new Loader();
			loader.load(new URLRequest(BASE+"Loading.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadLoadingComplete);
				
			
		}
		
		private function onLoadLoadingComplete(e:Event):void {
			
			var loaderinfo:LoaderInfo = e.target as LoaderInfo;
			loaderinfo.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadLoadingComplete);
			this.loading = new Loading(loaderinfo.content as MovieClip);
			this.onLoaded();
		}		
		
		protected function onLoaded():void
		{

		}
		
		protected function getLoading():Loading
		{
			return this.loading;
		}
		
		protected function addLoading(visible:Boolean = true):void
		{
			
			this.loading.resetAnimations();
			
			this.addChild(this.loading);
			

		}
		
		protected function removeLoadingWithoutLoad(funct:Function):void{			
				this.loading.removeLoadingWithoutLoading(funct);
		}
		
		protected function removeLoading(funct:Function):void{			
				this.loading.removeLoading(funct);
		}
	}
}