package com.jmv.framework.gaming.scenes.transitions 
{
	import com.jmv.framework.tween.STween;
	import flash.display.DisplayObjectContainer;
	import com.jmv.framework.gaming.scenes.transitions.SCrossFadeTransition;
	import flash.display.Bitmap;
	import flash.filters.BlurFilter;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public class SCrossBlurTransition extends SCrossFadeTransition
	{
		
		private var blurTo:Number = 20;
		private var blurFX:BlurFilter;
		
		public function SCrossBlurTransition() 
		{
			super();
		}
		
		override public function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void 
		{
			super.inititalize(beforeSnapshot, afterSnapshot, stage, args);
			blurFX = new BlurFilter(0, 0);
		}
		
		override public function start():void 
		{
			super.start();
			STween.to(blurFX, 2, { blurX:blurTo, blurY:blurTo, onUpdate:updateBlur } );
		}
		
		private function updateBlur():void
		{
			before.filters = [blurFX];
		}
	}

}