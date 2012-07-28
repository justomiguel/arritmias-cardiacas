package com.jmv.framework.math 
{
	/**
	 * ...
	 * @author MatiX
	 */
	public class SMath
	{
		
		public static function round(number:Number, presition:uint = 2):Number {
			return parseFloat(number.toFixed(presition));
		}
		
		public static function random(from:Number, to:Number,presition:uint=2):Number {
			var dx:Number = to - from;
			var result:Number = from + Math.random() * dx;
			result = round(result, presition);
			return result;
		}
		
		   public static function randrange(min:Number, max:Number) : Number
        {
            return Math.random() * (max - min) + min;
        }// end function

        public static function randint(min:int, max:int) : int
        {
            return Math.floor(Math.random() * (max - min + 1)) + min;
        }// end function

		
	}

}