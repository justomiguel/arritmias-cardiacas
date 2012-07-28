package dg 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class Log
	{
		public static var DEBUG:Boolean = true;
		public static var strTrace:String;
		public static var timer:Timer;
		
		
		
		public static function init(stage:Stage):void {
		
			
		
			strTrace = "";
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void {
				if (e.keyCode == Keyboard.SPACE) {
					DEBUG = ! DEBUG;
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
		
			strTrace += " <TRACES \n" + strTrace + "\n TRACES>"; 
			////tracestrTrace);
			MonsterDebugger.//traceevent.currentTarget, strTrace);
			strTrace = "";
			
		}
		
	}

}