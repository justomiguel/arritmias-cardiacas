package com.jmv.sbejeweled.screens 
{
	import flash.display.MovieClip;
	
	
	
	public class InstrucctionAsset2 extends MovieClip
	{
		
		private var _container:MovieClip;
		
		public function InstrucctionAsset2(container:MovieClip) {
			super();
			_container = container;
		}
		
		public function get transitionInst():MovieClip { return _container.transitionInst; }
		
		public function get btn_resume():MovieClip { return null; } 
		
		public function get btn_play():MovieClip { return _container.btn_play; }
		
		public function set btn_play(value:MovieClip):void 
		{
			_container.btn_play = value;
		}
		
		
		public function get btn_next():MovieClip {return _container.btn_next; }
		
		public function set btn_next(value:MovieClip):void 
		{
			_container.btn_next = value;
		}
		
		public function get btn_back():MovieClip {return _container.btn_back; }
		
		public function set btn_back(value:MovieClip):void 
		{
			_container.btn_back = value;
		}
		
		public function get btn_skip():MovieClip { return _container.btn_skip; }
		
		public function set btn_skip(value:MovieClip):void 
		{
			_container.btn_skip = value;
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