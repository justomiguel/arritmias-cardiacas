package com.jmv.framework.date 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class STimer extends EventDispatcher {
		
		private var start_time:Date;
		private var seconds_limit:Number;
		private var _incremental:Boolean;
	
		private var _text_field:TextField;
		
		static const STATE_INITIATED:Number = 0;
		static const STATE_FINISHED:Number = 1;
		public static const EVENT_TIMER_FINISHED:String = "EVENT_TIMER_FINISHED";
		private var _state:Number;
		
		public function STimer(text_field:TextField, incremental:Boolean) {
			
			_text_field = text_field;
			_incremental = incremental;
			
			_text_field.text = "HOLA";
			
			
		}
	
		public function initiate(minutes:Number, seconds:Number):void {
			

			seconds_limit = minutes * 60 + seconds;
			start_time = new Date();
			_text_field.text = String(minutes) + ":" + String(seconds);
			this.setState(STATE_INITIATED);
			
		}
	
	
		private function setState(state:Number):void {
			
			if (state == STATE_INITIATED) {
				
				_state = state;	
				
			}else if (state == STATE_FINISHED) {
				
				dispatchEvent( new Event(EVENT_TIMER_FINISHED));
				
				_state = state;
				
			}
			
			
		}
	
		public function update():void {
			
			if (_state == STATE_INITIATED) {
				if (_incremental) {
					updateIncremental();
				}else {
					updateDecremental();
				}
			}
			
		}
	
		private function updateIncremental():void {
			var current_time:Date = new Date();		
			
			var seconds_passed:Number;
			var seconds_left:Number;
			var minutes_left:Number;
			var minutes_passed:Number;
			
			
			seconds_passed = DateFunction.dateDiff("s", current_time, start_time);		
			minutes_passed =  Math.round(seconds_passed / 60);
			
			
			if (minutes_passed < 1) {
				minutes_passed = 0;
			}
			
			seconds_left = seconds_passed % 60;	
			
			_text_field.text = String(minutes_passed) + ":" + String(seconds_left);
		}
	
		private function updateDecremental():void {
			
			var current_time:Date = new Date();		
			
			var seconds_passed:Number;
			var seconds_left:Number;
			var minutes_left:Number;
			var minutes_passed:Number;
			
			
			seconds_passed = DateFunction.dateDiff("s", current_time, start_time);		
			seconds_left = seconds_limit - seconds_passed;	
			minutes_left = Math.floor(seconds_left / 60);
			
			_text_field.text = String(minutes_left) + ":" + String(seconds_left % 60);
			
			if (seconds_left <= 0) {
				this.setState(STATE_FINISHED);
			}
			
		}
		
		
		public function get secondsLeft():Number {
			
			var current_time:Date = new Date();		
			var seconds_passed:Number;
			var seconds_left:Number;
			
			seconds_passed = DateFunction.dateDiff("s", current_time, start_time);		
			seconds_left = seconds_limit - seconds_passed;	
		
			return seconds_left;	
		}
		
	}
	
}