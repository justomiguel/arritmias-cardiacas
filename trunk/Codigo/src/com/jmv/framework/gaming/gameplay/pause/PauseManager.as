package com.jmv.framework.gaming.gameplay.pause 
{
	import com.jmv.framework.core.managers.base.SManager;
	/**
	 * ...
	 * @author MatiX
	 */
	public class PauseManager extends SManager implements IPausable
	{
		
		private var _pausables:Array;
		
		public function PauseManager() 
		{
		}
		
		override public function initialize():void 
		{
			super.initialize();
			_pausables = new Array();
		}
		
		override public function dispose():void 
		{
			super.dispose();
			_pausables = null
		}
		
		public function add(pausable:IPausable):void {
			if (_pausables.indexOf(pausable) < 0) {
				_pausables.push(pausable);
			}
		}
		
		public function remove(pausable:IPausable):void {
			var idx:int = _pausables.indexOf(pausable);
			if (idx >= 0) {
				_pausables.splice(idx, 1);
			}
		}
		
		/* INTERFACE com.jmv.framework.gaming.gameplay.pause.IPausable */
		
		public function pause():void
		{
			for each(var pausable:IPausable in _pausables) {
				pausable.pause();
			}
		}
		
		public function unpause():void
		{
			for each(var pausable:IPausable in _pausables) {
				pausable.unpause();
			}
		}
		
	}

}