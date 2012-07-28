package com.jmv.sbejeweled.screens 
{
	import flash.display.MovieClip;
	
	
	
	public class InstrucctionsAsset extends MovieClip
	{
		
		private var _container:MovieClip;
		
		public function InstrucctionsAsset(container:MovieClip) {
			super();
			_container = container;
		}
		public function get transitionInst():MovieClip { return _container.transitionInst; }
		
		public function get btn_skip():MovieClip { return _container.btn_skip; } 
		public function set btn_skip(value:MovieClip):void 
		{
			_container.btn_skip = value;
		}
		
		public function get btn_resume():MovieClip { return _container.btn_resume; }
				
		public function set btn_resume(value:MovieClip):void 
		{
			_container.btn_resume = value;
		}
		
		public function get btn_next():MovieClip { return _container.btn_next; }
		
		public function set btn_next(value:MovieClip):void 
		{
			_container.btn_next = value;
		}
		
		public function get btn_backtomenu():MovieClip { return _container.btn_backtomenu; }
		
		public function set btn_backtomenu(value:MovieClip):void 
		{
			_container.btn_backtomenu = value;
		}
		
		public function get container():MovieClip { return _container; }
		
		public function set container(value:MovieClip):void 
		{
			_container = value;
		}
		
		
	}

}