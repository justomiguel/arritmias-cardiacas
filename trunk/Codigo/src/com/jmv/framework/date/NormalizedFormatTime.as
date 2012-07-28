package com.jmv.framework.date {
	import com.jmv.framework.utils.StringUtil;
	
	/**
	 * COOL CLASS TO FORMAT TIME in HH:MM:SS:MS format and other stuff 
	 * @author MatiX @ sismogames
	 */
	public class  NormalizedFormatTime{
	private var hours:uint;
	private var minutes:uint;
	private var seconds:uint;
	private var milliseconds:uint
	
	public static var MSECS_RADIX:Number = 1000;
	
	public function NormalizedFormatTime (hs:Number,min:Number,secs:Number,msecs:Number){
		hours = 0;
		minutes = 0;
		seconds = 0;
		milliseconds = 0;
		
		MilliSeconds = msecs;
		Seconds = secs;
		Minutes = min;
		Hours = hs;
	}
	
	public function get Hours():Number {
		return hours;
	}
	public function get Minutes():Number {
		return minutes;
	}
	public function get Seconds():Number{
		return seconds;
	}
	public function get MilliSeconds():Number {
		return milliseconds;
	}
	
	public function set Hours(hs:Number):void {
		if ( hs > 0) {
			var intHs:Number = Math.floor(hs);
			var decHs:Number = hs - intHs;
			
			this.hours = intHs;
			Minutes += decHs * 60;
		}
	}
	
	public function set Minutes(min:Number):void {
		if (min > 0) {
			var intMin:Number = Math.floor(min);
			var decMin:Number = min - intMin;
			
			if ( intMin >= 60) {
				this.Hours += Math.floor(intMin / 60);
				this.minutes = intMin % 60;
			}
			else {
				this.minutes = intMin;
			}
			
			Seconds += decMin * 60;
		}
	}
	
	public function set Seconds (secs:Number):void {
		if (secs > 0) {
			var intSecs:Number = Math.floor(secs);
			var decSecs:Number = secs - intSecs;
			
			if ( intSecs >= 60) {
				this.Minutes += Math.floor(intSecs / 60);
				this.seconds = Math.floor(intSecs % 60);
			}
			else {
				this.seconds = intSecs;
			}
			
			MilliSeconds += decSecs * 1000;			
		}
	}
	
	public function set MilliSeconds(msecs:Number):void {
		if (msecs > 0) {
			var intMsecs:Number = Math.floor(msecs);
			
			if ( intMsecs >= 1000) {
				this.Seconds += Math.floor(intMsecs / 1000);
				this.milliseconds = intMsecs % 1000;
			}
			else {
				this.milliseconds = intMsecs;
			}			
		}
	}
	
	public function toMilliSeconds():Number {
		var toMinutes:Number = hours * 60 + minutes;
		var toSeconds:Number = toMinutes * 60 + seconds;
		var toMilliseconds:Number = toSeconds * 1000 + milliseconds;
		return toMilliseconds;
	}
	
	public function toSeconds():Number {
		var toMinutes:Number = hours * 60 + minutes;
		var toSeconds:Number = toMinutes * 60 + seconds;
		var milisecsToSecs:Number = milliseconds / 1000;
		toSeconds += milisecsToSecs;
		return toSeconds;
	}
	
	public function toString(format:String = null):String {
		var result:String = "";
		if (format) {
			result = format;
		}
		else {
			result = "H : M : S : MS";
		}
		
		result.replace("H", StringUtil.addPrefixZeros(hours, 2));
		result.replace("M", StringUtil.addPrefixZeros(minutes, 2));
		result.replace("S", StringUtil.addPrefixZeros(seconds, 2));
		result.replace("MS", StringUtil.addPrefixZeros(milliseconds, 2));
		
		return result;
	}
	}
}