

package com.jmv.framework.audio
{
	import flash.media.Sound;

	public class AudioLoop extends Audio
	{
		protected var times:uint;
		
		public function AudioLoop( sound:Sound, times:uint, id:String = null )
		{
			this.times = times;
			super( sound, id );
		}
		
		public override function play() : void
		{
			super.loop( times );
		}

	}
}
