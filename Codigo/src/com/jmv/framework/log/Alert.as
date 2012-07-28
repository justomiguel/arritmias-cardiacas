package com.jmv.framework.log
{
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	[Embed (source="/./com/jmv/framework/_assets/core_assets.swf", symbol="framework.assets.Alert")]
	public class Alert extends Sprite
	{
		
		public static var OFFSET_DISTANCE:Number = 10;
		
		public static var offsetX:Number = 0;
		public static var offsetY:Number = 0;
		
		public var msg_txt:TextField;
		public var title_txt:TextField;
		
		private var timer:Timer
		
		public function Alert(message:String, title:String=null , duration:Number = -1) 
		{
			msg_txt.text = message;
			if (title) title_txt.text = title;
			addEventListener(MouseEvent.CLICK, onCLick, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			if (duration > 0) {
				timer = new Timer(duration, 1);
				timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
				timer.start();
			}
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			timer = null
			onCLick();
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.alpha = 0;
			this.x -= 10
			this.y -= 10
			STween.to(this, 4, { alpha:1, x:this.x + 10, y:this.y + 10 } );
		}
				
		private function onCLick(e:MouseEvent = null):void 
		{
			STween.to(this, 3, { alpha:0, onComplete:dispose } );
		}
		
		private function dispose():void {
			if (parent) {
				var idx:int = parent.getChildIndex(this);
				for (var i:int = idx; i < parent.numChildren; i++) 
				{
					var a:Alert = parent.getChildAt(i) as Alert;
					STween.to(a, 2, { x:a.x - OFFSET_DISTANCE } );
					STween.to(a, 2, { y:a.y - OFFSET_DISTANCE } );
				}
				offsetX -= OFFSET_DISTANCE;
				offsetY -= OFFSET_DISTANCE;
				parent.removeChild(this);
			}
		}
		
	}

}