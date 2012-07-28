package com.jmv.framework.gaming.scenes.transitions {
	import com.jmv.framework.tween.STween;
	import flash.display.DisplayObjectContainer;
	import com.jmv.framework.gaming.scenes.transitions.base.STransition;
	import flash.display.Bitmap;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SCrossFadeTransition extends STransition {

		protected var before:Bitmap;
		protected var after:Bitmap;
		protected var stage:DisplayObjectContainer;
		
		public static var defaultDuration:Number = 1;
		
		protected var args:Object;
		
		public function SCrossFadeTransition() {

		}
		
		override public function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void {
			if (args) this.args = args
			else this.args = new Object();
			
			this.before = stage.addChild(beforeSnapshot) as Bitmap;
			this.after = stage.addChild(afterSnapshot) as Bitmap;
			this.after.alpha = 0;
			this.stage = stage;
		}
		
		override public function start():void {
			var duration:Number = (args.duration)? args.duration : defaultDuration;

			STween.to(before, duration, { alpha:0 } );
			STween.to(after, duration, { alpha:1 , onComplete:onFinishedTransition} );
		}
		
		private function onFinishedTransition():void{
			stage.removeChild(before);
			stage.removeChild(after);
		}

	}

}

