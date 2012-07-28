package com.jmv.framework.sound.base {
	import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.core.state.StatefulObjectImplementation;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.gaming.gameplay.pause.IPausable;
	import com.jmv.framework.tween.STween;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import com.jmv.framework.core.framework_internal;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SSound extends Sound implements IStatefulObject, IPausable{
		
		public static const STATE_UNLOADED:String = "STATE_UNLOADED";
		public static const STATE_PLAYING:String = "STATE_PLAYING";
		public static const STATE_STOPPED:String = "STATE_STOPPED";
		
		private var soundChannel:SoundChannel;
		
		protected var baseSound:Sound;
		protected var _loops:int = 0;
		protected var _position:int = 0;
		
		use namespace framework_internal;
		
		protected var _state:StatefulObjectImplementation = new StatefulObjectImplementation(STATE_UNLOADED);
		
		public function SSound(stream:URLRequest = null, context:SoundLoaderContext = null) {
			addEventListener(Event.OPEN, onSoundLoad, false, 0, true);
			super(stream, context);
			baseSound = this;
		}
		
		private function onSoundLoad(e:Event):void {
			this._state.forceSetState(STATE_STOPPED);
		}
		
		public function playSound(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):void {
			if (soundChannel) {
				soundChannel.stop();
			}
			try {
				if (baseSound == this) {
					this.soundChannel = super.play(startTime, loops, sndTransform);
				}
				else {
					this.soundChannel = baseSound.play(startTime, loops, sndTransform);
				}
			}
			catch (e:ArgumentError){
				return;
			}
			_loops = loops;
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, dispatchEvent, false, 0, true);
			this.soundChannel.addEventListener(Event.SOUND_COMPLETE, onComplete, false, 0, true);
			this._state.forceSetState(STATE_PLAYING);
		}
		
		private function onComplete(e:Event):void 
		{
			this._state.forceSetState(STATE_STOPPED);
		}
		
		override public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			throw new SError("SSound.play is DEPRECATED, use SSound.playSound instead...")
			return null;
		}
		
		public function stop():void {
			if(soundChannel){
				this.soundChannel.stop();
				this._state.forceSetState(STATE_STOPPED);
				this.soundChannel = null;
			}
		}
		
		// SoundChannel Wrapper getters
		
		public function get currentPosition():Number {
			if (soundChannel) return soundChannel.position;
			else return 0;
		}
		
		public function get leftPeak():Number {
			if (soundChannel) return soundChannel.leftPeak
			else return 0;
		}
		
		public function get rightPeak():Number {
			if (soundChannel) return soundChannel.rightPeak
			else return 0;
		}
		
		public function get soundTransform():SoundTransform {
			if (soundChannel) return this.soundChannel.soundTransform
			else return null;
		}
		
		public function set soundTransform(s:SoundTransform):void {
			if (soundChannel) this.soundChannel.soundTransform = s;
		}
		
		/* INTERFACE com.jmv.framework.core.state.IStatefulObject */
		
		public function get state():String{
			return _state.state;
		}
		
		public function set state(state:String):void{
			throw new SError("SSound.state is READ-ONLY");
		}
		
		public function isInState(state:String):Boolean{
			return _state.isInState(state);
		}
		
		public function getAllStates():Array{
			return [STATE_PLAYING,STATE_STOPPED,STATE_UNLOADED];
		}
		
		public function setSubState(state:String, SubState:String):void
		{
			_state.setSubState(state, SubState);
		}
		
		public function isSubState(state:String, SubState:String):Boolean
		{
			return _state.isSubState(state, SubState);
		}
		
		public function fadeIn(duration:int):void {
			if (soundTransform) {
				var sndT:SoundTransform = soundTransform;
				sndT.volume = 0;
				soundTransform = sndT;
				STween.to(sndT, duration, {  volume:1, 
												onUpdate:function():void {
													soundTransform = sndT;
												}
										} );
			}
		}
		
		public function fadeOut(duration:int, stopAtEnd:Boolean = true):void {
			if (soundTransform) {
				var sndT:SoundTransform = soundTransform;
				STween.to(sndT, duration, {  	volume:0, 
												onUpdate:function():void {
													soundTransform = sndT;
												},
												onComplete:function():void {
													if(stopAtEnd) stop();
												}
										} );
			}
		}
		
		public function transform(volume:Number, pan:Number = 0, LtoR:Number = 0, LtoL:Number = 1, RtoR:Number = 1, RtoL:Number = 0):SSound {
			var st:SoundTransform = this.soundTransform;
			if(st){
				st.volume = volume;
				st.pan= pan;
				st.leftToLeft =LtoL;
				st.leftToRight = LtoR;
				st.rightToLeft = RtoL;
				st.rightToRight= RtoR;
				this.soundTransform = st;
			}
			return this;
		}
		
		/* INTERFACE com.jmv.framework.gaming.gameplay.pause.IPausable */
		
		public function pause():void
		{
			if (!isInState(STATE_PLAYING)) return;
			_position = currentPosition;
			stop();
		}
		
		public function unpause():void
		{
			if (!isInState(STATE_STOPPED)) return;
			playSound(_position, _loops, soundTransform);
		}
		
	}
	
}