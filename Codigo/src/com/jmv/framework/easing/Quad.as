

package com.jmv.framework.easing 
{	
	public class Quad
	{
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change * (time /= duration) * time + start;
		}
		
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return -change * (time /= duration) * (time - 2) + start;
		}
		
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if ((time /= duration / 2) < 1)
				return change / 2 * time * time + start;
			return -change / 2 * ((--time) * (time - 2) - 1) + start;
		}
	}
}
