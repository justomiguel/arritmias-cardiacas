

package com.jmv.framework.audio
{
	import com.jmv.framework.math.SMath;

	public class RandomAudio extends PlayableCollection implements IPlayable
	{
		/**
		 * Receives a list of IPlayables and plays one at random.
		 * The SOUND_COMPLETE event is triggered right after the
		 * aforementioned IPlayable finishes all its loops.
		 */
		
		public function RandomAudio(tracks:Array, id:String = null )
		{
			super(tracks, id);
		}
		
		/**
		 * Loops a random IPlayable as many times as requested (endless by default)
		 */
		public override function loop( times : int = int.MAX_VALUE ) : void
		{
			super.loop( 1 );
			
			activeIndex = SMath.randint( 0, tracks.length - 1 );			
			active.loop( times );
			
		}
		
		public function get length() : Number
		{
			return active.length;
		}
	}
}