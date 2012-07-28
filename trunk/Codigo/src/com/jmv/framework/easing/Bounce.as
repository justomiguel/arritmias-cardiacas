

package com.jmv.framework.easing 
{	
	public class Bounce
	{		
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if ((time /= duration) < (1 / 2.75)) {
				return change * (7.5625 * time * time) + start;
			} else if (time < (2 / 2.75)) {
				return change * (7.5625 * (time -= (1.5 / 2.75)) * time + .75) + start;
			} else if (time < (2.5 / 2.75)) {
				return change * (7.5625 * (time -= (2.25 / 2.75)) * time + .9375) + start;
			} else {
				return change * (7.5625 * (time -= (2.625 / 2.75)) * time + .984375) + start;
			}
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			return change - com.jmv.framework.easing.Bounce.easeIn(duration - time, 0, change, duration) + start;
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1):Number
		{
			if (time < (duration / 2)) {
				return com.jmv.framework.easing.Bounce.easeIn((time * 2), 0, change, duration) * .5 + start;
			} else {
				return com.jmv.framework.easing.Bounce.easeOut((time * 2) - duration, 0, change, duration) * .5 + change*.5 + start;
			}
		}
	}
}
