package com.jmv.framework.log 
{
	import com.jmv.framework.date.NormalizedFormatTime;
	import com.jmv.framework.log.Alert;
	import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.framework.utils.StringUtil;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author 
	 */
	public class LogManager extends SManager
	{
		
		private var _stage:DisplayObjectContainer;
		
		private var alertLayer:Sprite;
		
		private var logRecord:XML;
		
		private var logDisplay:TextField;
		
		public function LogManager(stage:DisplayObjectContainer) 
		{
			this._stage = stage
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			alertLayer = new Sprite();
			_stage.addChild(alertLayer);
			alertLayer.addEventListener(Event.ENTER_FRAME, alertLayerAlwaysOnTop);
			
			logRecord = <record></record>
		}
		
		private function alertLayerAlwaysOnTop(e:Event):void 
		{
			DisplayObjectUtil.bringToFront(alertLayer);
		}
		
		public function log(message:String, source:Object = null):void {
			var timestamp:uint = getTimer();
			var sourceObj:Object = source
			if (source && source.hasOwnProperty("id")) {
				sourceObj = source.id;
			}
			logRecord.appendChild( <log time={timestamp} message={message} source={sourceObj}/> );
		}
		
		public function alert(message:String, source:Object = null, title:String = null, duration:int = -1):Alert {
			log(message, source);
			var last_log:XML = logRecord.log[logRecord.log.length() - 1];
			var formattedTime:NormalizedFormatTime = new NormalizedFormatTime(0, 0, 0, last_log.@time);
			var min:String = StringUtil.addPrefixZeros(formattedTime.Minutes);
			var sec:String = StringUtil.addPrefixZeros(formattedTime.Seconds);
			var displayMSG:String = "[" + min +":" + sec + "], [" + ((last_log.@source != null)? last_log.@source:"unknown") + "] -> " + last_log.@message;
			var alert:Alert = new Alert(displayMSG, title, duration);
			alert.x = _stage.stage.stageWidth / 2 - alert.width / 2 + Alert.offsetX;
			alert.y = _stage.stage.stageHeight / 2 - alert.height / 2 + Alert.offsetY;
			Alert.offsetX += Alert.OFFSET_DISTANCE;
			Alert.offsetY += Alert.OFFSET_DISTANCE;
			return alertLayer.addChild(alert) as Alert;
		}
		
		override public function dispose():void 
		{
			super.dispose();
			alertLayer.removeEventListener(Event.ENTER_FRAME, alertLayerAlwaysOnTop);
		}
		
	}

}