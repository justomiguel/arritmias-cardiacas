package com.jmv.framework.date 
{
	
	import com.jmv.framework.date.DateFunction;
	
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public final class SDate extends Object {
		
		private var _date:Date;
		
		
		public function SDate() 
		{
			_date = new Date();
			
		}
		
		/*
		 * 
		 * @return [String] returns the date in a string format like  day-month-year-hour-minutes-secons, for example: 23-2-2009-17-45-30
		 * 
		 * */
		
		public function toString():String {
			
			var strRet:String;
			
			strRet = String(_date.getUTCDate());
			strRet += "-" + String(_date.getUTCMonth());
			strRet += "-" + String(_date.getUTCFullYear());
			strRet += "-" + String(_date.getUTCHours());
			strRet += "-" + String(_date.getUTCMinutes());
			strRet += "-" + String(_date.getUTCSeconds());
			
			return strRet;
			
		}
		
		/*
		 * @time_stamp [String] the unit time to compute the difference "s", "m", "h"
		 * @return [Number] returns the difference between this date an another
		 * 
		 * */
		
		public function dateDiff(time_stamp:String, date_to_compare:Date):Number {
			
			var ret:Number;
			
			ret = DateFunction.dateDiff(time_stamp, date_to_compare, _date);
			
			return ret;
			
		}
		
		/*
		 * 
		 * Set date from a string with a format like day-month-year-hour-minutes-seconds, for example : 23-2-2009-17-45-30
		 * @value [String] date in a string format
		 * 
		 * 
		 * */
		
		
		public function setDateFromString(value:String):void {
			
			var str:String;
			var mYear, mMonth, mDay, mHour, mMin, mSec, mMs:String;
			
			var ind1, ind2:Number;
			
			str = value;
			
			ind1 = 0;
			
			ind1 = str.indexOf("-", 0);
			mDay = str.substr(0, ind1);
		
			str = str.substr(ind1 + 1, str.length);
			
			ind1 = str.indexOf("-", 0);
			mMonth = str.substr(0, ind1);
			
			str = str.substr(ind1 + 1, str.length);
			
			ind1 = str.indexOf("-", 0);
			mYear = str.substr(0, ind1);
			
			str = str.substr(ind1 + 1, str.length);
			
			ind1 = str.indexOf("-", 0);
			mHour = str.substr(0, ind1);
			
			str = str.substr(ind1 + 1, str.length);
			
			ind1 = str.indexOf("-", 0);
			mMin = str.substr(0, ind1);
		
			str = str.substr(ind1 + 1, str.length);
			
			
			ind1 = str.indexOf("-", 0);
			mSec = str.substr(0, str.length);
			
			str = str.substr(ind1 + 1, str.length);
			
			_date.setUTCFullYear(mYear);
			_date.setUTCMonth(mMonth);
			_date.setUTCDate(mDay);
			_date.setUTCHours(mHour);
			_date.setUTCMinutes(mMin);
			_date.setUTCSeconds(mSec);
			_date.setUTCMilliseconds(0);
			
		}
		
		public function get date():Date {
			return _date;
		}
		
		public function get seconds():Number {
			
			var ret:Number;
			ret = _date.getSeconds();
			return ret;
			
		}
	}
	
}