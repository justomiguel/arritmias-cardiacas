package 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.net.LocalConnection;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class Log
	{
		public static var DEBUG:Boolean = false;
		public static var strTrace:String;
		public static var timer:Timer;
		private static var conn:LocalConnection;
			
		
		
		public static function init(stage:Stage):void {		
			
			conn = new LocalConnection();
			strTrace = "";
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void {
				if (e.keyCode == Keyboard.SPACE) {
					DEBUG = ! DEBUG;
					//trace( "DEBUG : " + DEBUG );
					if (DEBUG) {
						timer = new Timer(500, 0);
						timer.addEventListener(TimerEvent.TIMER, timer_Timer);
						timer.start();
					}else {
						if (timer != null) {
							timer.removeEventListener(TimerEvent.TIMER, timer_Timer);
							timer = null;
						}
						
					}
				}
			});
			
			
		}
		
		private static function timer_Timer(event:TimerEvent):void {
			//trace( "timer_Timer : " + timer_Timer );
		
			if (strTrace.length != 0) {
				//strTrace += " <TRACES \n" + strTrace + "\n TRACES>"; 
				sendMessage(strTrace);
				strTrace = "";
			}
			
			
		}
		
		
		
		
		
		
		public static function sendMessage(value:String):void {
			//trace( "sendMessage : " + sendMessage );
			var conn:LocalConnection;
			conn = new LocalConnection	();
			try 
			{
				conn.send("_monitor_server", "onReceivedData", value);	
	
			}catch (err:Error)
			{
				//trace(err.message);
				
			}
			
		}
		
		
		
		
		
		
	}

}