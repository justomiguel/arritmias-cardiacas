package com.jmv.sbejeweled 
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled.screens.buttons.Btn_MuteOFF;
	import com.jmv.sbejeweled.screens.buttons.Btn_MuteON;
	import com.jmv.sbejeweled.screens.FPSCounter;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.display.Sprite;
	
	
	
	public class SBejeweled extends Sprite {
		
		
		public var app:App;
		
		public function SBejeweled() {
			this.init();
		}
		
		public function init():void {
			
			this.app = new App();
			this.addChild(app);
			app.load();
					
		}
		
		
		public function dispose():void {			
			this.app.dispose();
			this.app = null;
			
		}
	}
}
