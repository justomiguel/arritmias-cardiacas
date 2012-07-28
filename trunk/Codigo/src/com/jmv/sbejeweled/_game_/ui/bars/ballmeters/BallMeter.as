package com.jmv.sbejeweled._game_.ui.bars.ballmeters 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	
	
	
	
	
	public class BallMeter extends MovieClip{
		
		
		
		public function BallMeter() {
			
			super();
			this.gotoAndStop(1);
		}
		
		public function glow():void {
			this.gotoAndPlay(2);
			this.addEventListener(Event.ENTER_FRAME, finishtween)
		}
		
		private function finishtween(e:Event):void{
			if (this.currentFrame == this.totalFrames) {
				this.gotoAndStop(1);
				this.removeEventListener(Event.ENTER_FRAME, finishtween);
			}
			
		}
		
		private function finishtween2():void
		{
			this.filters = new Array()
		}
	}

}