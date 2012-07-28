

package com.jmv.framework.easing 
{	
	public class Sine
	{
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return -change * Math.cos(time/duration * (Math.PI/2)) + change + start;
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change * Math.sin(time/duration * (Math.PI/2)) + start;
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return -change/2 * (Math.cos(Math.PI*time/duration) - 1) + start;
		}
	}
}
