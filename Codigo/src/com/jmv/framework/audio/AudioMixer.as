

package com.jmv.framework.audio
{
	/**
	 * Allows easy manipulation of many Audio instances.
	 * @see Audio
	 */
	public class AudioMixer
	{
		protected var items : Object = { };
		protected var gains : Object = { };
		
		protected var master : Number = 1;
		
		public function AudioMixer()
		{
		}
		
		/**
		 * Adds a new IPlayable to the playlist.
		 * 
		 * @param asset An asset instance
		 * @throws Error The IPlayable instance must have an 'id'.
		 * @see IPlayable
		 */
		
		public function add( asset : IPlayable ) : AudioMixer
		{
			if( !asset.id )
				throw new Error('com.flashlib.audio.AudioMixer > Received an IPlayable with no "id".');

			items[ asset.id ] = asset;
			gains[ asset.id ] = asset.volume;
			
			_updateVolume( asset );

			return this;
		}		

		/* Private helpers */
		 
		protected function _forEach( id : String, fn : Function ) : AudioMixer
		{
			if( id ){
				// supports comma/space separated ids
				var ids : Array = id.split(/[\s,]+/);
				for each( id in ids ){
					if( items[id] )
						fn( items[id] );
					//else
						//trace('com.flashlib.audio.AudioMixer > Id "'+id+'" not found'); 
				}
			}else{
				for( id in items )
					fn( items[id] );
			}
			return this;
		}
		
		protected function _updateVolume( asset : IPlayable ) : void
		{
			if( gains[asset.id] )
				asset.volume = gains[asset.id] * master;
		}
		
		/* Batched methods */
		
		/**
		 * Starts playing the desired assets from the beginning.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @param loops The amount of times the playback should be repeated, 0 by default.
		 * 
		 * @see IPlayable#stop()
		 * @see IPlayable#play()
		 */
		
		public function play( id : String = null ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.play();
			});
		}
		
		/**
		 * Starts playing the desired assets from the beginning as many times as specified.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @param loops The amount of times the playback should be repeated, endless by default.
		 * 
		 * @see IPlayable#stop()
		 * @see IPlayable#loop()
		 */
		
		public function loop( id : String = null, times:int = int.MAX_VALUE ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.loop( times );
			});
		}
		
		/**
		 * Resumes the playback of the desired assets (only if previously paused).
		 * If the id is null, then the action is taken on all the registered (and paused) assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @see #pause()
		 * @see IPlayable#play()
		 * @see IPlayable#pause()
		 */
		
		public function resume( id : String = null ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.resume();
			});
		}
		
		/**
		 * Stops the playback of the desired assets.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @see IPlayable#stop()
		 */
		
		public function stop( id : String = null ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.stop();
			});
		}
		
		/**
		 * Pauses the playback of the desired assets.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @see #resume()
		 * @see IPlayable#pause()
		 */
		
		public function pause( id : String = null ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.pause();
			});
		}
		
		/**
		 * Mutes the desired assets.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @see #unmute
		 * @see IPlayable#mute()
		 */
		
		public function mute( id : String = null ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				asset.volume = 0;
			});
		}
		
		/**
		 * Unmutes the desired assets.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * 
		 * @see #mute()
		 * @see #masterVolume
		 * @see IPlayable#unmute()
		 */
		
		public function unmute( id : String = null ) : AudioMixer
		{
			return this._forEach( id, _updateVolume );
		}
		
		/**
		 * Returns whether the mixer has an element by that id.
		 * 
		 * @param id Asset's id.
		 */
		
		public function has( id : String ) : Boolean
		{
			return !!items[id];
		}
		
		/**
		 * Returns the IPlayable registered by that id
		 * 
		 * @param id Asset's id.
		 */
		 
		public function retrieve( id:String ) : IPlayable
		{
			return items[id];
		}
		
		/**
		 * Removes the given asset or assets.
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 */
		
		public function remove( id : String = null, dispose:Boolean = false ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				if( dispose )
					asset.dispose();
				delete items[asset.id];
				delete gains[asset.id];
			});
		}
		
		/**
		 * Modifies the internal stored gain for the desired assets.
		 * The gain is the asset's volume, in relation to the masterVolume. 
		 * If the id is null, then the action is taken on all the registered assets.
		 * 
		 * @param id Optional string with one or more (comma/space separated) ids.
		 * @param gain A number between 0-1 to be multiplied with the masterVolume.
		 * 
		 * @see #masterVolume
		 */
		public function gain( id : String, gain : Number ) : AudioMixer
		{
			return this._forEach( id, function( asset : IPlayable ) : void {
				gains[ asset.id ] = gain;
				_updateVolume( asset );
			});
		}
		
		/* Properties */
		
		/**
		 * Global volume multiplied by each IPlayable's gain.
		 * @see #gain()
		 */		
		public function get masterVolume() : Number
		{
			return master;
		}
		
		/**
		 * @private
		 */		 		 
		public function set masterVolume( num : Number ) : void
		{
			master = num;
			this._forEach( null, _updateVolume );
		}

	}
}
