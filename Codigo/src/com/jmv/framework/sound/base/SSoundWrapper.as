package com.jmv.framework.sound.base 
{
	import com.jmv.framework.sound.base.SSound;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.media.SoundLoaderContext;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public class SSoundWrapper extends SSound
	{
		
		private var sound:Sound;
		
		public function SSoundWrapper(sound:Sound) 
		{
			super();
			this.baseSound = sound;
		}
		
	}

}