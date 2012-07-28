package com.jmv.framework.audio {
	
	import com.jmv.framework.utils.ArrayUtil;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.System;

	public class MultiChanneledAudio extends Playable implements IPlayable
	{
		protected var channels : Array;
		protected var transform : SoundTransform;
		protected var sound : Sound;
		protected var maxChannels : uint;
		protected var lastVol:Number;		
		
		/**
		 * Provides a simple API for the multiple operations perfomed on sounds.
		 * 
		 * @see flash.media.Sound
		 * @see flash.media.SoundChannel
		 * @see flash.media.SoundTransform
		 */		
		public function MultiChanneledAudio( sound:Sound, maxChannels:uint = uint.MAX_VALUE, id:String = null )
		{
			super(id);
			
			this.sound = sound;
			this.maxChannels = maxChannels;
			this.transform = new SoundTransform();
			this.channels = new Array();
		}
		
		protected override function _onPlayComplete( e:Event ) : void
		{
			super._onPlayComplete( e );
			ArrayUtil.removeElement( channels, e.target );
			e.target.removeEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
			
			if( !channels.length )
				stop();
		}
		
		protected function _forEach( fn:Function ) : void
		{
			channels.forEach(function( channel:SoundChannel, i:uint, a:Array ) : void {
				fn( channel, i );
			});
		}
		
		/**
		 * The playback length.
		 */	
		public function get length():Number
		{
			return sound.length;
		}

		/**
		 * The playback position of this Audio.
		 */	
		public override function get position():Number
		{
			return channels.length ? channels[0].position : 0;
		}
		
		/**
		 * The volume of this Audio.
		 */
		public override function get volume():Number
		{
			return transform.volume;
		}

		/**
		 * @private
		 */			
		public override function set volume(vol:Number):void
		{
			super.volume = vol;
			transform.volume = vol;
			_forEach( function( channel:SoundChannel, i:uint ) : void {
				channel.soundTransform = transform;
			});
		}
		
		public override function get playing():Boolean
		{
			return !!channels.length;
		}

		protected function playChannel(pos:uint = 0):SoundChannel
		{
			var channel:SoundChannel = sound.play(pos, loops, transform);
			if( !channel ) // Flash provides a limited amount of channels
				return null;
				
			channel.addEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
			return channel;
		}

		protected function stopChannel(channel:SoundChannel, i:uint):void
		{
			pauseChannel(channel, i);
			ArrayUtil.removeElement(channels, channel);
		}

		protected function pauseChannel(channel:SoundChannel, i:uint):void
		{
			if (!channel)
				return
			channel.stop();
			if (channel.hasEventListener(Event.SOUND_COMPLETE))
				channel.removeEventListener( Event.SOUND_COMPLETE, _onPlayComplete );
		}

		protected function resumeChannel(channel:SoundChannel, i:uint):void
		{
			pauseChannel(channel, i);
			var channel:SoundChannel = playChannel(channel.position);
			if (channel)
				channels[i] = channel;
		}

		/**
		 * Pauses the playback of all the available channels.
		 */			
		public override function pause():void
		{
			super.pause();
			_forEach(pauseChannel);
		}
		
		/**
		 * Resumes the playback of all the available channels.
		 */			
		public override function resume():void
		{
			super.resume();
			_forEach(resumeChannel);
		}

		/**
		 * Stops and resets the playback of this Audio.
		 */		
		public override function stop():void
		{
			super.stop();
			_forEach(stopChannel);
		}
		
		public override function loop( times:int=int.MAX_VALUE ):void
		{
			super.loop( times );

			if( channels.length == maxChannels )
				stopChannel(channels[0], 0);
			var channel:SoundChannel = playChannel();
			if (channel)
				channels.push(channel);
		}

		/**
		 * Cleans and garbage collects the Audio Object
		 * After this call, the object can no longer be used.
		 */		
		public function dispose():void
		{
			stop();
			sound = null;
			transform = null;
			System.gc();
		}
	}
}
