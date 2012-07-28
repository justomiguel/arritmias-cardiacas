package com.jmv.framework.gaming.display {
	import com.jmv.framework.utils.MovieClipUtil;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Util: removes itself from its parent after it reaches the last frame...
	 * @author MatiX @ sismogames
	 */
	public class SelfDisposableMovieClip extends MovieClip {
		
		private static const LAST_FRAME_REACHED_EVENT:String = "LAST_FRAME_REACHED";
		private var selfDisposalIsActive:Boolean = false;
		
		public function SelfDisposableMovieClip() {
			super();
			this.gotoAndStop(1);
		}
		
		private function activateSelfDisposal():void {
			if (this.parent) {
				if(!selfDisposalIsActive){
					MovieClipUtil.dispatchEventOnFrame(this, this.totalFrames, new Event(LAST_FRAME_REACHED_EVENT), true);
					this.addEventListener(LAST_FRAME_REACHED_EVENT, onLastFrame, false, 0, true);
					selfDisposalIsActive = true;
				}
			}
		}
		
		override public function play():void {
			activateSelfDisposal();
			super.play();
		}
		
		override public function gotoAndPlay(frame:Object, scene:String = null):void {
			activateSelfDisposal();
			super.gotoAndPlay(frame, scene);
		}
		
		protected function onLastFrame(e:Event):void {
			if (this.parent) {
				this.removeEventListener(LAST_FRAME_REACHED_EVENT, onLastFrame);
				this.parent.removeChild(this);
			}
		}
		
	}
	
}