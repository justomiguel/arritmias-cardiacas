package com.jmv.sbejeweled._game_.ui
{
	import com.jmv.framework.tween.STween;
	import com.jmv.sbejeweled._game_.ui.fxbars.FillFX;
	import com.jmv.sbejeweled._game_.ui.fxbars.FillTalentFX;
	import flash.events.Event;
	
	import flash.display.MovieClip;
	
	
	
	public class ProgressBar extends MovieClip
	{
		
		public var masc:MovieClip;
		public  var bar:MovieClip;
		public var fillFx:FillFX;
		public var fillTalentFx: FillTalentFX;
		public var _statusBar:Number;
		public var defaultHeight:Number;
		private var contador:int;
		public var timeOverFX:MovieClip
		
		public function ProgressBar()
		{
			super();
			
			this.defaultHeight = masc.height;
			this.masc.height = 1;
			
			
		}
		
		public function update(ratio:Number, mode:String=null):void
		{
			
			var future:Number = this.bar.height * (ratio);
			_statusBar = ratio;
			
			if (future < 1) future = 1;
			
			//return new Tween(this.masc, 1, {height:future}, {transition:'easeout'});
			this.masc.height = future;
		}
		
	
		
		public function showFillAnimation(container:MovieClip, x:int, y:int):void {
			
			if (_statusBar > 0.97) {
				if (!fillFx) {
					fillFx = new FillFX(x, y);
					container.addChild(fillFx);
					container.addEventListener(Event.ENTER_FRAME, removeFillFX);
				}
			} 
					}
		
		private function removeFillFX(e:Event):void {
			if (fillFx.currentFrame == fillFx.totalFrames) {
				
			
				fillFx.parent.removeEventListener(Event.ENTER_FRAME, removeFillFX);
				if (fillFx.parent) {
					fillFx.parent.removeChild(fillFx);
					this.fillFx = null;
	
				}
			}
		}
		
		public function showFillTalentAnimation(container:MovieClip, x:int, y:int):void {
			if (!fillTalentFx) {
				fillTalentFx = new FillTalentFX(x + this.bar.width /2, y);
				container.addChild(fillTalentFx);
				container.addEventListener(Event.ENTER_FRAME, removeFillTalentFX);
			} else {
				fillTalentFx.gotoAndPlay(1);
			}
		}
		
		private function removeFillTalentFX(e:Event):void {
			if (fillTalentFx){
				if (fillTalentFx.currentFrame == fillTalentFx.totalFrames) {
					if (fillTalentFx.parent){
						fillTalentFx.parent.removeEventListener(Event.ENTER_FRAME, removeFillTalentFX);
						fillTalentFx.parent.removeChild(fillTalentFx);
						this.fillTalentFx = null;
		
					}
				}
			}
		}
		
		public function get statusBar():Number { return _statusBar; }
	
	
		
	}
}