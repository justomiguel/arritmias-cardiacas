package com.jmv.sbejeweled.screens 
{
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	public class ScreenEndGame extends MovieClip	{
		
		private var callback:Function;
		
		public function ScreenEndGame() {
			
			super();
			
		}
		
		public function init(callback:Function):void {

			this.callback = callback;
			
			STween.to(this, 0.1, {onComplete:dispose} );
			
		}
		
		
		
		public function dispose():void {
			
			this.callback.apply(this);
			DisplayObjectUtil.dispose(this);
		}
		
	}

}