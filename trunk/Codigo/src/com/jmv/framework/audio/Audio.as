
package com.jmv.framework.audio
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.System;


	public class Audio extends Playable implements IPlayable
	{
		protected var sound : Sound;
		protected var channel : SoundChannel;
		protected var transform : SoundTransform;
		
		public function Audio( sound : Sound, id : String = null )
		{
			super( id );
			
			this.sound = sound;
			this.transform = new SoundTransform();
		}
		
		public function get length() : Number
		{
			return sound.length;
		}
			
		public override function get position() : Number
		{
			return this.channel ? this.channel.position : 0;
		}
		
		public override function get volume() : Number
		{
			return this.transform.volume;
		}
			
		public override function set volume( vol : Number ) : void
		{
			super.volume = vol;
			if( !this.muted )
				this.transform.volume = vol;
				
			if( this.channel )
				this.channel.soundTransform = this.transform;		
		}
		
		public override function loop( loops : int = int.MAX_VALUE ) : void
		{
			super.loop( loops );
			
			if( this.channel ){
				this.channel.removeEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
				this.channel = null;
			}

			this.channel = this.sound.play( this.lastPos, loops, this.transform );
			this.channel.addEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
		}
		
		/**
		 * Stops and resets the playback of this Audio.
		 */		
		public override function stop() : void
		{
			super.stop();
			if( this.channel )
				this.channel.stop();
		}
		
		/**
		 * Pauses the playback of this Audio.
		 */	
		public override function pause() : void
		{
			super.pause();
			if( this.channel )
				this.channel.stop();			
		}
		
		/**
		 * Cleans and garbage collects the Audio Object
		 * After this call, the object can no longer be used.
		 */
		public function dispose() : void
		{
			this.stop();
			
			if( this.channel )
				this.channel.removeEventListener( Event.SOUND_COMPLETE, _onPlayComplete );

			this.sound = null;
			this.transform = null;
			this.channel = null;
			System.gc();
		}
	}
}
