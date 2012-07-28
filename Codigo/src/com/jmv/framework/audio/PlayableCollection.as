

package com.jmv.framework.audio
{
	import flash.events.Event;
	
	public class PlayableCollection extends Playable
	{
		protected var tracks : Array;
		protected var activeIndex : uint;
		
		// ABSTRACT
		
		public function PlayableCollection( tracks:Array, id:String )
		{
			super(id);
			this.tracks = tracks;
			this.activeIndex = 0;
			
			for each( var track : IPlayable in tracks )
				track.addEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
		}
		
		/**
		 * The asset being played
		 */
		public function get active() : IPlayable
		{
			return at(activeIndex);
		}
		
		/**
		 * Retrieves an asset a certain index
		 */
		public function at( index:uint ) : IPlayable
		{
			return tracks[index];
		}
		
				/**
		 * The elapsed playback of the active asset 
		 */
		public override function get position() : Number
		{
			return active.position;
		}
		
		/**
		 * @private
		 */
		public override function set position( pos : Number ) : void
		{
			active.position = pos;
		}
		
		/**
		 * The generalized volume of the items in the playlist
		 */
		public override function get volume() : Number
		{
			return active.volume;
		}

		/**
		 * @private
		 */
		public override function set volume( vol : Number ) : void
		{
			super.volume = vol;
			active.volume = vol;		
		}
		
		/**
		 * Stops the playback
		 */
		public override function stop() : void
		{
			super.stop();
			active.stop();
		}
		
		/**
		 * Pauses the playback
		 */
		public override function pause() : void
		{
			super.pause();
			active.pause();
		}
		
		/**
		 * Resumes the playback
		 */
		public override function resume() : void
		{
			super.resume();
			active.resume();
		}
		
		
		/**
		 * Cleans and garbage collects the Audio Object
		 * After this call, the object can no longer be used.
		 */
		public function dispose() : void
		{
			stop();
			for each( var track : IPlayable in tracks ){
				track.dispose();
				track.removeEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
			}
			tracks.length = 0;
		}
		
		public function randomize() : void
		{
			this.tracks.sort( _random );
		}
		
		protected function _random( a:IPlayable, b:IPlayable ) : Number
		{
			return 0.5 - Math.random();
		}
		
	}
}