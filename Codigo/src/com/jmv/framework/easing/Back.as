
 
package com.jmv.framework.easing 
{	
	public class Back
	{		
		public static function easeIn(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, s:Number = 1.70158):Number
		{
			return change*(time/=duration)*time*((s+1)*time - s) + start;
		}

		public static function easeOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, s:Number = 1.70158):Number
		{
			return change*((time=time/duration-1)*time*((s+1)*time + s) + 1) + start;
		}

		public static function easeInOut(time:Number, start:Number = 0, change:Number = 1, duration:Number = 1, s:Number = 1.70158):Number
		{
			if ((time/=duration/2) < 1) return change/2*(time*time*(((s*=(1.525))+1)*time - s)) + start;
			return change/2*((time-=2)*time*(((s*=(1.525))+1)*time + s) + 2) + start;
		}
	}
}
