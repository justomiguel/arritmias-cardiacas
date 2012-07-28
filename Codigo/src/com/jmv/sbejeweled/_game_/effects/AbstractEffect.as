package com.jmv.sbejeweled._game_.effects
{
	import com.jmv.framework.utils.DisplayObjectUtil;
	import flash.display.MovieClip;
	import flash.events.Event;

	
	
	
	public class AbstractEffect extends MovieClip
	{
		private var dispose_when_finished:Boolean;
		
		public function AbstractEffect(dispose_when_finished:Boolean = true)
		{
			this.dispose_when_finished = dispose_when_finished;
			this.addEventListener(Event.ENTER_FRAME, this.loop, false, 0, true);
		}
		
		private function loop(e:Event):void
		{
			if (this.currentFrame == this.totalFrames)
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
				
				if (this.dispose_when_finished)
				{
					this.dispose();
				}
				if (this.hasEventListener(Event.ENTER_FRAME))
					this.removeEventListener(Event.ENTER_FRAME, this.loop);
			}
		}
		
		public function dispose():void
		{
			this.stop();
			
			if (this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME, this.loop);
			
			if (this.parent)
				this.parent.removeChild(this);
			
			DisplayObjectUtil.dispose(this);
		}
	}
}