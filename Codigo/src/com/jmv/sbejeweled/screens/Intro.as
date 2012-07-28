package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	import com.jmv.sbejeweled.settings;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	
	
	public class Intro extends MovieClip
	{
		private var asset:IntroAsset;
		
		public function Intro(autoStart:Boolean=true)
		{
			super();
			
			this.asset = new IntroAsset();
			this.addChild(asset);
			
			//TransitionClass.getInstance().takePicture(this.asset, this);
			//TransitionClass.getInstance().doFade();
			
			Btn_Mute.getInstance().addBTNMute(this.asset);
			
			
			init();
		}
		
		private function updateButtons(e:MouseEvent):void {
			if (this.asset.btn_skip.currentFrame == 2) {
				onClickSkip(e);
			} else if  (this.asset.btn_back.currentFrame == 2) {
				onClickBack(e);
			} else if  (this.asset.btn_next.currentFrame == 2) {
				onClickNext(e);
			}
			
		}
		
		public function init(autoStart:Boolean=true):void {
			
			App.I().initButton(this.asset.btn_skip, this.onClickSkip);
			App.I().initButton(this.asset.btn_back, this.onClickBack);
			App.I().initButton(this.asset.btn_next, this.onClickNext);
			
			
			App.I().initTextFields(this.asset);
			

			
		}
		
		private function onClickBack(e:MouseEvent):void {
	
				//TransitionClass.getInstance().savePicture(this.asset);
				//App.I().hub.dispatch('onClickBack');
				SApplication.application.scenes.switchScene("MainMenuScene");
				this.dispose();
		}
		
		private function onClickNext(e:MouseEvent):void {
		
				//TransitionClass.getInstance().savePicture(this.asset);
				//App.I().hub.dispatch('onClickNext');
				SApplication.application.scenes.switchScene("InstructionsScene");
				
				this.dispose();

		}
		
		
		private function onClickSkip(e:MouseEvent):void
		{
			
		
				App.I().selectUser(AbstractPlayer.FAIRY);
				
				//TransitionClass.getInstance().savePicture(this.asset);
				SApplication.application.scenes.switchScene("GameScene");
				//App.I().hub.dispatch('onClickSkip');
				

				this.dispose();
		}
		
		
		
		public function dispose():void
		{
			try {
				App.I().removeButton(this.asset.btn_skip, this.onClickSkip);
				App.I().buttonmanager.removeButton(this.asset.btn_skip);
				
				App.I().removeButton(this.asset.btn_next, this.onClickNext);
				App.I().buttonmanager.removeButton(this.asset.btn_next);
				
				App.I().removeButton(this.asset.btn_back, this.onClickBack);
				App.I().buttonmanager.removeButton(this.asset.btn_back);
				
				//com.jmv.framework.utils.DisplayObjectUtil.dispose(this.asset);
				this.asset.parent.removeChild(this.asset);
				this.asset = null;
				super.dispose();
			} catch (err:Error)
			{
				
			}
		}		
	}
}