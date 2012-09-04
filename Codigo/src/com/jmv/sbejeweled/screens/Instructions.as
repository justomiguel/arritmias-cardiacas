package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
		
	
	
	public class Instructions extends MovieClip
	{
		public var clip1:MovieClip;
		public var clip2:MovieClip;
		private var asset:MovieClip;
		private var nextPage:uint;
		
		public function Instructions(autoStart:Boolean=true)
		{

			super();
			
			this.clip1.visible = false;
			this.clip2.visible = false;
			
			nextPage = 0;
			
			if (App.I().state() != App.ON_MENU) {
				this.clip1.visible = true;
				this.clip2 = null;
				this.asset = new InstrucctionsAsset(clip1);
			} else {
				this.clip2.visible = true;
				this.clip1 = null;
				this.asset = new InstrucctionAsset2(clip2);
			}
			
			
			this.asset.container.gotoAndStop(1);			
			//TransitionClass.getInstance().takePicture(this.asset, this);
			//TransitionClass.getInstance().doFade();
			
			init();
			
			Btn_Mute.getInstance().addBTNMute(this);

		}
		
		private function updateButtons(e:MouseEvent):void {
			if (this.asset.btn_backtomenu.currentFrame == 2) {
				onBackToMenu(e);
			}
			if (App.I().state() != App.ON_MENU) {
				if  (this.asset.btn_resume.currentFrame == 2) {
					onClickResume(e);
				}
			} else {
				if  (this.asset.btn_skip.currentFrame == 2) {
					onClickResume(e);
				}
			}
			
			if  (this.asset.btn_next.currentFrame == 2) {
				onClickNextInner(e);
			}
		
		}
		
		private function init():void {
			//App.I().initButton( this.asset.btn_backtomenu, this.onBackToMenu);
			
			if (App.I().state() != App.ON_MENU) {
				App.I().initButton( this.asset.btn_resume, this.onClickResume);
			} else {
				App.I().initButton( this.asset.btn_skip, this.onClickResume);
			}
			
			//App.I().initButton( this.asset.btn_next, this.onClickNextInner);
			
			App.I().initButton( this.asset.btn_next, this.onClickNextPage);
			App.I().initButton( this.asset.btn_back, this.onBackToMenu);
			
			if (App.I().state() == App.ON_MENU){
				App.I().initButton( this.asset.btn_play, this.onClickNextInner);
			}
			
			//(this.asset.transitionInst as MovieClip).addFrameScript(Math.floor(this.asset.transitionInst.totalFrames / 2), this.onTransitionAtMiddle);
			
			this.asset.addEventListener(Event.ENTER_FRAME, updateTextfields);
		}
		
		public function onTransitionAtMiddle():void{
			this.asset.container.gotoAndStop(nextPage);
		}
		
		private function updateTextfields(e:Event):void 
		{
			App.I().initTextFields(this.asset.container);
		}
	
		private function onClickNextPage(ev:MouseEvent):void {
			
			if (this.asset.container.currentFrame < this.asset.container.totalFrames) {
				nextPage += 10;
				this.asset.container.gotoAndStop(nextPage);					
			} else if ( this.asset.container.currentFrame== this.asset.container.totalFrames) {
				if (App.I().state() == App.ON_MENU) {
					//TransitionClass.getInstance().savePicture(this);
					App.I().selectUser(AbstractPlayer.FAIRY);
					SApplication.application.scenes.switchScene("GameScene");
					//App.I().hub.dispatch('onFirstPlay');
				} else {
					//TransitionClass.getInstance().savePicture(this);
					App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_BACK);
				}
				this.dispose();
			}
			
			
		}
		
		private function onClickNextInner(ev:MouseEvent):void {
			
			if (nextPage < this.asset.container.totalFrames) {
				nextPage++;
				this.asset.transitionInst.gotoAndPlay(2);
				
			} else if (nextPage == this.asset.container.totalFrames) {
				if (App.I().state() == App.ON_MENU) {
					//TransitionClass.getInstance().savePicture(this);
					App.I().selectUser(AbstractPlayer.FAIRY);
					SApplication.application.scenes.switchScene("GameScene");
					//App.I().hub.dispatch('onFirstPlay');
				} else {
					//TransitionClass.getInstance().savePicture(this);
					App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_BACK);
				}
				this.dispose();
			}
			
			
		}
		
		private function onBackToMenu(ev:MouseEvent):void
		{
			if (nextPage > 0) {
				nextPage-= 10;
				this.asset.container.gotoAndStop(nextPage);					
			} else if (nextPage == 0) {
				if (App.I().state() == App.ON_MENU) {
					SApplication.application.scenes.switchScene("IntroScene");
				} else {
					App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_BACK);
				}
				this.dispose();
			}
		}
		
			private function onClickResume(ev:MouseEvent):void
		{		
			if (App.I().state() == App.ON_MENU) {
				App.I().selectUser(AbstractPlayer.FAIRY);
				SApplication.application.scenes.switchScene("GameScene");
			} else {
				App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_BACK);
			}
			this.dispose();
		}
		
		public function dispose():void
		{
			
			
			if (this.asset.btn_backtomenu) {
				App.I().removeButton(this.asset.btn_backtomenu, this.onBackToMenu);
				App.I().buttonmanager.removeButton( this.asset.btn_backtomenu);
			}
			
			if (this.asset.btn_resume) {
				App.I().removeButton(this.asset.btn_resume, this.onClickResume);
				App.I().buttonmanager.removeButton( this.asset.btn_resume);
			}
			
			if ( this.asset.btn_next) {
				App.I().removeButton( this.asset.btn_next, this.onClickNextInner);
				App.I().buttonmanager.removeButton( this.asset.btn_next);
			}
			
			if (this.asset.btn_skip) {
				App.I().removeButton( this.asset.btn_skip, this.onClickResume);
				App.I().buttonmanager.removeButton(this.asset.btn_skip);
			}
			
			if (clip1) {
				DisplayObjectUtil.dispose(this.clip1);
				this.clip1 = null;
			}
			
			if (clip2) {
				DisplayObjectUtil.dispose(this.clip2);
				this.clip2 = null;
			}
			
			this.asset.removeEventListener(Event.ENTER_FRAME, updateTextfields);
			
			DisplayObjectUtil.dispose(this.asset);
			this.asset = null;
			
		}		
	}
}