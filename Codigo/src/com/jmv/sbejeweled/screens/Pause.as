package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import flash.display.MovieClip;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	
	public class Pause extends MovieClip
	{
		private var asset:PauseAsset;
		
		public function Pause(autoStart:Boolean=true)
		{
			super();
			
			this.asset = new PauseAsset();
			this.addChild(asset);
			this.asset.gotoAndStop(this.asset.totalFrames);
			this.asset.stop();
			//this.asset.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);

			//TransitionClass.getInstance().takePicture(this, this);
			//TransitionClass.getInstance().doFade(getStarted);
			App.I().initButton(this.asset.btn_resume, this.onClickResume);
			App.I().initButton(this.asset.btn_quit, this.onClickQuit);
			App.I().initTextFields(this.asset.pause_text);
			
			Btn_Mute.getInstance().addBTNMute(this.asset);
		}
		
		//private function getStarted():void
		//{
		//
			//
		//
		//}
		//
		//private function onEnterFrame(e:Event):void
		//{
			//if (this.asset.currentFrame == this.asset.totalFrames)
			//{
				//this.asset.stop();
				//
				//this.asset.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//
			//}
		//}
		
		private function onClickResume(ev:MouseEvent):void
		{
			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickResume', "pausa");
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_RESUME);
			this.dispose(); 
		}
		
		private function onClickQuit(ev:MouseEvent):void
		{
			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickQuit');
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_QUIT);
			this.dispose(); 
		}
		
		public function dispose():void
		{
			App.I().buttonmanager.removeButton(this.asset.btn_resume);
			App.I().removeButton(this.asset.btn_resume, this.onClickResume);
			
			App.I().buttonmanager.removeButton(this.asset.btn_quit);
			App.I().removeButton(this.asset.btn_quit, this.onClickQuit);
			
			//this.asset.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			
			DisplayObjectUtil.dispose(this.asset);
			this.asset = null;
			
		}
	}
}