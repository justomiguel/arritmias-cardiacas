

package com.jmv.framework.easing 
{	
	public class Circ
	{		
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return -change * (Math.sqrt(1 - (time/=duration)*time) - 1) + start;
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change * Math.sqrt(1 - (time=time/duration-1)*time) + start;
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if ((time/=duration/2) < 1) return -change/2 * (Math.sqrt(1 - time*time) - 1) + start;
			return change/2 * (Math.sqrt(1 - (time-=2)*time) + 1) + start;
		}
	}
}
