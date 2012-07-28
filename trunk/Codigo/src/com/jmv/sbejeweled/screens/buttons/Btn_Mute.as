package com.jmv.sbejeweled.screens.buttons 
{
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	
	
	public class Btn_Mute extends MovieClip{
	
		public var btnMuteOn:MovieClip;
		public var btnMuteOff:MovieClip;
		
		public var _visible:Boolean;
		
		public static var instance:Btn_Mute;
		
		public static function getInstance():Btn_Mute {
			if (!instance) {
				instance = new Btn_Mute();
			}
			return instance;
		}
		
		public function addBTNMute(container:Sprite):void {
			
			this.btnMuteOn = new Btn_MuteON();
			this.btnMuteOff = new Btn_MuteOFF();
			App.I().buttonmanager.addButton( this.btnMuteOn, this.onClickMuteOn);
			App.I().buttonmanager.addButton( this.btnMuteOff, this.onClickMuteOff);
			this.btnMuteOn.stop();
			this.btnMuteOff.stop();
			container.addChild(btnMuteOn);
			container.addChild(btnMuteOff);
			this.btnMuteOn.visible = _visible;
			this.btnMuteOff.visible = !_visible;
			btnMuteOn.x = 25;
			btnMuteOff.x = 25;
			btnMuteOn.y = 450;
			btnMuteOff.y = 450;
		}
		
		public function Btn_Mute() {
			super();
			_visible = true;
			
		}
		
		
		private function showMuteBtn(on:Boolean):void
		{
			_visible = on;
			this.btnMuteOn.visible = _visible;
			this.btnMuteOff.visible = !_visible;
		}
		
		private function onClickMuteOn(ev:MouseEvent):void
		{
			ev.stopPropagation();
			App.I().mute(true);
			this.showMuteBtn(false);
		}
		
		private function onClickMuteOff(ev:MouseEvent):void{
			
			ev.stopPropagation();
			App.I().mute(false);
			this.showMuteBtn(true);
			
		}
		
		public function dispose():void {
			if (btnMuteOff.parent) {
				btnMuteOff.parent.removeChild(btnMuteOff)
			}
			if (btnMuteOn.parent) {
				btnMuteOn.parent.removeChild(btnMuteOn)
			}
			
			App.I().buttonmanager.removeButton( this.btnMuteOn);
			App.I().removeButton(this.btnMuteOn, this.onClickMuteOn);
			
			App.I().buttonmanager.removeButton( this.btnMuteOff);
			App.I().removeButton(this.btnMuteOff, this.onClickMuteOff);
			
			DisplayObjectUtil.dispose(this.btnMuteOff);
			DisplayObjectUtil.dispose(this.btnMuteOn);
		}
	}

}