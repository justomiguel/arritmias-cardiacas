package com.jmv.framework.profiling 
{
	import com.jmv.framework.utils.DisplayObjectUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author MatiX
	 */
	[Embed(source="/./com/sismogames/framework/_assets/core_assets.swf",symbol="framework.assets.FPSMeter")]
	public class FpsMeter extends Sprite
	{
		
		private var framesPassed:int = 0;
		
		public var txt:TextField
		
		private var fps:Number = 0;
		private var lastTime:Number = 0;
		
		private var update:Number = 0;
		
		public function FpsMeter() 
		{
			super();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(e:Event):void 
		{
			var time:Number = getTimer()/1000;
			var dt:Number= time - lastTime;
			lastTime = time;			
			
			fps = Math.round(1 / dt);
			
			update += dt;
			
			if (update >= .5) {
				txt.text = fps + "fps";
				update = 0;
			}
			
			DisplayObjectUtil.bringToFront(this);
		}
		
	}

}