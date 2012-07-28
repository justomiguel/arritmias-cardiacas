
package com.jmv.framework.audio
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	/**
	 * Simple class that delays sound loading
	 * until the first playback
	 */
	public class LazySound extends Sound
	{
		protected var stream  : URLRequest;
		protected var context : SoundLoaderContext;
		protected var started : Boolean;
		
		public function LazySound( stream:URLRequest = null, context:SoundLoaderContext = null )
		{
			super( stream, context );
		}
		
		public override function load( stream : URLRequest, context : SoundLoaderContext = null ) : void
		{
			started = false;
			this.stream = stream;
			this.context = context;
		}
		
		public function forceLoad() : void
		{
			if( !started ){
				started = true;
				super.load( stream, context );
			}
		}
		
		public override function play( start:Number = 0, loops:int = 0, transf : SoundTransform=null ) : SoundChannel
		{
			forceLoad();
			return super.play( start, loops, transf );
		}
		
		// The stream's url is more accurate
		public override function get url() : String
		{
			return stream ? stream.url : super.url;
		}
		
	}
}
