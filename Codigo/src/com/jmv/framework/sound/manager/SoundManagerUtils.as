package com.jmv.framework.sound.manager 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author MatiX
	 */
	public class SoundManagerUtils
	{
		private var sm:SoundManager;
		
		public function SoundManagerUtils(sm:SoundManager) 
		{
			this.sm = sm
		}
		
		public function bacthAddSounds(...sounds):void {
			for each (var sound:Object in sounds) {
				var key:String
				if (sound is String) {
					key = sound as String;
				}
				else if (sound is Class) {
					key = getQualifiedClassName(sound);
					key = key.substring(key.lastIndexOf(":") + 1, key.length - 1);
				}
				sm.addSound(key, sound);
			}
		}
		
		public function batchRemoveSounds(...sounds):void {
			for each (var sound:String in sounds) {
				sm.removeSound(sound);
			}
		}
	}

}