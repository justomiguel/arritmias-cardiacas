

package com.jmv.framework.easing 
{	
	public class Expo
	{
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return (time==0) ? start : change * Math.pow(2, 10 * (time/duration - 1)) + start;
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return (time==duration) ? start + change : change * (-Math.pow(2, -10 * time/duration) + 1) + start;
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if (time==0) return start;
			if (time==duration) return start + change;
			if ((time/=duration/2) < 1) return change / 2 * Math.pow(2, 10 * (time - 1)) + start;
			return change/2 * (-Math.pow(2, -10 * --time) + 2) + start;
		}
	}
}
