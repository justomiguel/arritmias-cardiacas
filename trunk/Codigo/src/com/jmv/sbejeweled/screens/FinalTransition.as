package com.jmv.sbejeweled.screens 
{
	
	import flash.display.MovieClip;
	
	
	
	public class FinalTransition extends MovieClip
	{
		
		public var _maskara:MovieClip;
		
		public function FinalTransition() {
			
		}
		
		public function dispose():void {
			com.jmv.framework.utils.DisplayObjectUtil.dispose(this);
			
		}
		
		public function get maskara():MovieClip { return _maskara; }
		
		public function set maskara(value:MovieClip):void 
		{
			_maskara = value;
		}
		
	
	}

}