package com.jmv.framework.gaming.scenes.transitions 
{
	import com.jmv.framework.tween.STween;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import com.jmv.framework.gaming.scenes.transitions.base.STransition;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public class SBlindsTransition extends STransition
	{
		
		private var befores:Array;
		private var after:Bitmap;
		private var stage:DisplayObjectContainer;
		
		
		
		public function SBlindsTransition() 
		{
			super();
		}
		
		override public function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void 
		{
			this.befores = breakApart(beforeSnapshot);
			this.after = afterSnapshot
			this.stage = stage;
			
			stage.addChild(after);
			for (var i:int = 0; i < befores.length; i++) 
			{
				var before:Bitmap = befores[i] as Bitmap;
				stage.addChild(before);
			}
		}
		
		private function breakApart(bmp:Bitmap):Array {
			var bd:BitmapData = bmp.bitmapData;
			var imax:int = Math.round(bd.width / 30);
			var result:Array = new Array();
			
			for (var i:int = 0; i < imax; i++) 
			{
				var bdi:BitmapData = new BitmapData(bd.width, 30);
				bdi.copyPixels(bd, new Rectangle(0, i * 30, bd.width, 30),new Point(0,0));
				var bitmap:Bitmap = new Bitmap(bdi);
				bitmap.y = i * 30;
				result.push(bitmap);
			}
			
			return result;
		}
		
		override public function start():void 
		{
			for (var i:int = 0; i < befores.length; i++) 
			{
				if (i == befores.length - 1)
					STween.to(befores[i], 2, { scaleY:0, alpha:0, delay:i * 50, onComplete:onFinishedAnim } );
				else
					STween.to(befores[i], 2, { scaleY:0, alpha:0, delay:i * 50 } );
			}
		}
		
		private function onFinishedAnim():void
		{
			stage.removeChild(after);
			for (var i:int = 0; i < befores.length; i++) 
			{
				stage.removeChild(befores[i] as DisplayObject);
			}
			
			befores = null;
			after = null;
			stage = null;
		}
	}

}