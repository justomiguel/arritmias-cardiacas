
package com.jmv.framework.audio
{
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	public class PlayableFactory
	{
		protected var base : String;
		protected var extension : String;
		
		public function PlayableFactory( base : String = '', extension: String = '' )
		{
			this.base = base;
			this.extension = extension;
		}
		
		public function create( asset:*, options:Object = null ) : IPlayable
		{
			options = options || {};
			if( asset is String ){
				var uri : String = base + asset;
				if( extension )
					uri += '.' + extension;
				asset = new LazySound(new URLRequest(uri));
				asset.addEventListener( IOErrorEvent.IO_ERROR, options.onSoundNotFound || soundNotFound );
				if( !options.lazy )
					asset.forceLoad();
				//asset = new Sound(new URLRequest(uri));
			}
			if( asset is Sound ){
				// MultiChanneledAudio is likely to simply replace Audio
				//if( options.channels )
					asset = new MultiChanneledAudio( asset, options.channels || uint.MAX_VALUE );
				//else
				//	asset = new Audio( asset );
			}
			if( asset is Array ){
				var tracks : Array = collection(asset as Array);
				// TODO: Multitrack
				/*if( options.multitrack )
					asset = new Multitrack( tracks );
				else*/
					asset = new Playlist( tracks );	
			}
			if( asset is IPlayable )
				return asset;

			throw new Error('PlayableFactory > create > Could not create an IPlayable from "'+asset+'".');
		}
		
		protected function soundNotFound( e:IOErrorEvent ) : void
		{
			throw new IOError('flashlib > audio.PlayableFactory > File not found:"'+ e.target.url +'".');
		}
		
		public function collection( tracks:Array, options:Object = null ) : Array
		{
			for( var i:uint = 0; i < tracks.length; i++ )
				tracks[i] = create( tracks[i], options );
			return tracks;
		}
	}
}
