
 
package com.jmv.framework.audio {
	
	import com.jmv.framework.utils.AbstractMethodError;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * Base class of Audio assets (implementing IPlayable) 
	 * 
	 * @see IPlayable
	 * @see Audio
	 * @see Playlist
	 */ 

	public class Playable extends EventDispatcher
	{
		protected var lastPos : Number = 0;
		protected var lastVolume : Number = 1;
		protected var loops : int = 1;
		
		protected var _id : String;
		protected var _playing : Boolean = false;
		protected var _paused : Boolean = false;
		protected var _muted : Boolean = false;

		// ABSTRACT
		
		public function Playable( id : String )
		{
			super( this );
			this._id = id;
		}
		
		// The Event.SOUND_COMPLETE event is propagated
		protected function _onPlayComplete( e : Event ) : void
		{
			this.dispatchEvent( e.clone() );
		}

		public function get id() : String
		{
			return _id;
		}
		
		public function set id( id : String ) : void
		{
			_id = id;
		}
		
		public function get paused() : Boolean
		{
			return _paused;
		}
		
		public function get playing() : Boolean
		{
			return _playing;
		}
		
		public function get muted() : Boolean
		{
			return _muted;
		}
		
		/**
		 * @return The playback position (elapsed)
		 */
		public function get position() : Number
		{
			throw new AbstractMethodError('Playable','get position'); 
		}
		
		/**
		 * @private
		 */
		public function set position( pos : Number ) : void
		{
			this.lastPos = pos;
			this.loop( loops );
		}
		
		/**
		 * @return The volume of this asset (between 0-1)
		 */
		public function get volume() : Number
		{	
			throw new AbstractMethodError('Playable','get volume'); 
		}
		
		/**
		 * @private
		 */
		public function set volume( vol : Number ) : void
		{
			if( this._muted )
				this.lastVolume = vol;
		}
		
		/* Public methods */
		
		/**
		 * Starts/resumes the audio playback
		 */
		public function play() : void
		{
			this.loop( 1 );
		}
		
		/**
		 * Plays the audio many times (endless by default)
		 */
		public function loop( times : int = int.MAX_VALUE ) : void
		{
			if( !this.playing ){
				this._playing = true;
				this._paused = false;
				this.loops = times;
			}
		}
		
		/**
		 * Stops the audio playback
		 */
		public function stop() : void
		{
			this._playing = false;
			this._paused = false;
			this.lastPos = 0;
		}
		
		/**
		 * Resumes the audio playback
		 */
		public function resume() : void
		{
			this._playing = true;
			this._paused = false;			
		}
		
		/**
		 * Pauses the audio playback
		 */
		public function pause() : void
		{
			this._playing = false;
			this._paused = true;			
			this.lastPos = this.position;			
		}
		
		/**
		 * Mutes the audio
		 * @see #unmute()
		 */
		public function mute() : void
		{
			// I set to false so 2 calls to mute don't lose the original volume
			this._muted = false;

			this.lastVolume = this.volume;
			this.volume = 0;
			this._muted = true;
		}
		
		/**
		 * Reverts a call to mute
		 * @see #mute()
		 */
		public function unmute() : void
		{
			this._muted = false;
			this.volume = this.lastVolume;
		}
	}
}
