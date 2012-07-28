package com.jmv.framework.sound.manager {
	import com.jmv.framework.collections.SSoundCollection;
	import com.jmv.framework.core.IDisposable;
	import com.jmv.framework.core.IInitializable;
	import com.jmv.framework.core.managers.base.IManager;
	import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.core.state.IStatefulObject;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.gaming.gameplay.pause.IPausable;
	import com.jmv.framework.sound.base.SSound;
	import com.jmv.framework.sound.base.SSoundWrapper;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.Proxy;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SoundManager extends  SManager implements IPausable {
		
		public static const STATE_DISABLED:String = "STATE_DISABLED";
		
		private var soundList:Dictionary;
		
		override public function initialize():void {
			super.initialize();
			this.soundList = new Dictionary();
		}
		
		public function addSound(key:String, sound:Object):SSound {
			if (!soundList[key]) {
				var soundSRC:SSound
				var SNDCLS:Class
				if (sound is SSound) {
					soundSRC = sound as SSound;
				}
				else if (sound is Sound) {
					soundSRC = new SSoundWrapper(sound as Sound);
				}
				else if (sound is Class) {
					SNDCLS = sound as Class
					addSound(key, new SNDCLS() as Sound);
					return getSound(key);
				}
				else if (sound is String) {
					SNDCLS = getDefinitionByName(sound as String) as Class;
					addSound(key, new SNDCLS() as Sound);
					return getSound(key);
				}
				else {
					throw new SError("Sound Type not recognized: " + sound);
				}
				soundList[key] = soundSRC;
				
				return soundSRC;
			}
			else {
				throw new SError("Key:" + key + "already in use!");
				return null;
			}
		}
		
		public function playSound(key:String, startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SSound {
			var snd:SSound = getSound(key);
			if (snd && !isInState(STATE_DISABLED)) snd.playSound(startTime, loops, sndTransform);
			return snd;
		}
		
		public function stopSound(key:String):void {
			var snd:SSound = getSound(key);
			if(snd){
				snd.stop();
			}
		}
		
		public function hasSound(key:String):Boolean {
			return soundList[key] != null;
		}
		
		public function soundIsPlaying(key:String):Boolean {
			return hasSound(key) && SSound(soundList[key]).isInState(SSound.STATE_PLAYING); 
		}
		
		public function getSound(key:String):SSound {
			return soundList[key];
		}
		
		public function enable():void {
			if (isInState(STATE_DISABLED)) this.state = STATE_READY;
		}
		
		public function disable():void {
			this.state = STATE_DISABLED;
			getAllSounds().stopAll();
		}
		
		public function removeSound(key:String):void {
			if (soundList[key]) {
				SSound(soundList[key]).stop();
				soundList[key] = null;
			}
		}
		
		public function getAllSounds():SSoundCollection {
			var allSounds:Array = new Array();
			for (var name:String in soundList) {
				allSounds.push(soundList[name]);
			}
			return new SSoundCollection(allSounds);
		}
		
		private var _utils:SoundManagerUtils;
		public function get utils():SoundManagerUtils {
			if (!_utils) {
				_utils = new SoundManagerUtils(this);
			}
			return _utils;
		}
		
		override public function dispose():void {
			super.dispose();
			getAllSounds().stopAll();
			this.soundList = null;
		}
		
		/* INTERFACE com.jmv.framework.gaming.gameplay.pause.IPausable */
		
		private var _resumable:Array;
		
		public function pause():void
		{
			if (!isInState(STATE_READY)) return;
			_resumable = new Array();
			for each (var sound:SSound in soundList) 
			{
				if (sound.isInState(SSound.STATE_PLAYING)) {
					sound.pause();
					_resumable.push(sound);
				}
			}
			disable();
		}
		
		public function unpause():void
		{
			if (!isInState(STATE_READY)) return;
			enable();
			for each (var sound:SSound in _resumable) {
				sound.unpause();
			}
			_resumable = null;
		}
		
	}
	
}