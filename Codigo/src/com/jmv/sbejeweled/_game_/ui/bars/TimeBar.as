package com.jmv.sbejeweled._game_.ui.bars 
{
	import com.jmv.sbejeweled._game_.effects.Glow;
	import com.jmv.sbejeweled._game_.ui.fxbars.FillTalentFX;
	import com.jmv.sbejeweled._game_.ui.fxbars.TimePassFx;
	import com.jmv.sbejeweled._game_.ui.ProgressBar;
	import com.jmv.sbejeweled.screens.TransitionFx;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	
	
	
	public class TimeBar extends ProgressBar{
		
		private var band:Boolean;
		
		public var mySpecialFX:TransitionFx;
		private var contador:Number;
		
		public function TimeBar() {
			super();
			band = true;
			contador =0;
			this.masc.height = this.defaultHeight;
			this.timeOverFX.visible = false;
	
		}
		
		public function updateTimer(ratio:Number, mode:String = null):void 
		{
			var future:Number = this.defaultHeight * (ratio);
			_statusBar = ratio;
			
			if (future < 1) future = 1;
			if (ratio == 0) {
				this.removeTimeOverFX();
			}
			

			if (future < defaultHeight / 2) {
				if (band) {
					band = false;
					gotoAndPlay(1);
				}
			}
			
			
			
			
			this.masc.height = future;
			
			if (timeOverFX.visible) {
				this.timeOverFX.y = -future;
			}
			
		}
		
			public function addTimeOverFX(container:MovieClip, x:int, y:int):void {
				timeOverFX.visible = true;

			
		}
		
		public function removeTimeOverFX():void {
		
				this.timeOverFX.visible = false;
		}
		

		
	
	}

}