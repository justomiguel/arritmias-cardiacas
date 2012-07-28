
package com.jmv.framework.easing 
{
	public class Cubic 
	{
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change*(time/=duration)*time*time + start;
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change*((time=time/duration-1)*time*time + 1) + start;
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if ((time/=duration/2) < 1) return change/2*time*time*time + start;
			return change/2*((time-=2)*time*time + 2) + start;
		}
	}
}
