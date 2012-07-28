
 
package com.jmv.framework.audio
{
	import flash.events.Event;

	/**
	 * Plays a list of Audio object sequentially 
	 * 
	 * @see Audio
	 * @see IPlayable
	 */ 

	public class Playlist extends PlayableCollection implements IPlayable
	{
		/**
		 * Receives a list of IPlayables and plays them all.
		 * The SOUND_COMPLETE event is triggered after it
		 * loops over all the elements, the required amount of times.
		 */
		
		public function Playlist( tracks : Array, id : String = null, randomize:Boolean = false )
		{
			super( tracks, id );
			
			if( randomize )
				this.randomize();
		}
		
		protected override function _onPlayComplete( e:Event ) : void
		{
			this.next();
			
			if( !loops ) // last
				super._onPlayComplete( e );
		}
		
		/* Properties */
		
		/**
		 * Loops the WHOLE collection as many times (endless by default)
		 */
		public override function loop( times : int = int.MAX_VALUE ) : void
		{
			super.loop( times );
			active.play();
		}
		
		/**
		 * The overall length of the list of assets
		 */
		public function get length() : Number
		{
			var l : Number = 0;
			for each( var track:IPlayable in tracks )
				l += track.length;
			return l;
		}
		
		
		/**
		 * Starts playing the next asset
		 */
		public function next() : void
		{
			active.stop();

			activeIndex++;
			
			if( activeIndex >= tracks.length ){
				loops--;
				activeIndex = 0;
			}
			
			if( loops > 0 ){
				active.volume = lastVolume;
				active.play();
			}
		}
	}
}
