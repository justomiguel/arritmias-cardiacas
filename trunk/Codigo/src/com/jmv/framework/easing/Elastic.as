

package com.jmv.framework.easing 
{	
	public class Elastic
	{
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, a:Number = 0, p:Number = .3):Number
		{
			if (time == 0) return start;  
			if ((time /= duration) == 1) return start + change;
			var s:Number;
			if (!a || a < Math.abs(change)) { 
				a = change; 
				s = p / 4; 
			} else {
				s = p / (2 * Math.PI) * Math.asin(change / a);	
			}
			return -(a * Math.pow(2, 10 * (time -= 1)) * Math.sin((time * duration - s) * (2 * Math.PI) / p)) + start;
		}
		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, a:Number = 0, p:Number = .3):Number
		{
			if (time == 0) return start;  
			if ((time /= duration) == 1) return start + change;  
			var s:Number;
			if (!a || a < Math.abs(change)) { 
				a = change; 
				s = p / 4; 
			} else {
				s = p / (2 * Math.PI) * Math.asin(change / a);
			}
			return (a * Math.pow(2, -10 * time) * Math.sin((time * duration - s) * (2 * Math.PI) / p) + change + start);
		}
		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, a:Number = 0, p:Number = .45):Number
		{
			if (time == 0) return start;
			if ((time /= duration / 2) == 2) return start + change;
			var s:Number;
			if (!a || a < Math.abs(change)) { 
				a = change; 
				s = p / 4; 
			} else {
				s = p / (2 * Math.PI) * Math.asin(change / a);
			}
			if (time < 1) return -.5 * (a * Math.pow(2, 10 * (time -= 1)) * Math.sin((time * duration - s) * (2 * Math.PI) / p)) + start;
			return a * Math.pow(2, -10 * (time -= 1)) * Math.sin((time * duration - s) * (2 * Math.PI) / p) * .5 + change + start;
		}
	}
}
