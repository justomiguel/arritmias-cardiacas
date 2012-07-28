package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import flash.display.MovieClip;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	
	public class Quit extends MovieClip
	{
		private var asset:QuitAsset;
		
		public function Quit(autoStart:Boolean=true)
		{
			super();
			
			this.asset = new QuitAsset();
			this.addChild(asset);
			//this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			//TransitionClass.getInstance().takePicture(this, this);
			//TransitionClass.getInstance().doFade(getStarted);
			this.asset.gotoAndStop(this.asset.totalFrames);
			this.asset.stop();
			getStarted();
			Btn_Mute.getInstance().addBTNMute(this.asset);
		}
		
		private function getStarted():void
		{
			
			
			App.I().initButton(this.asset.btn_no, this.onBtnNo);
			App.I().initButton(this.asset.btn_yes, this.onBtnYes);
			App.I().initTextFields(this.asset);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (this.asset.currentFrame == this.asset.totalFrames)
			{
				this.asset.stop();
				//this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private function onBtnNo(ev:MouseEvent):void
		{

			//TransitionClass.getInstance().savePicture(this.asset);
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_NO);
			this.dispose(); 
		}
		
		private function onBtnYes(ev:MouseEvent):void
		{

			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickYes');
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_YES);
			//App.I().game.endMyLevel(); 
			
			this.dispose(); 
		}
		
		public function dispose():void
		{
			App.I().buttonmanager.removeButton(this.asset.btn_no);
			App.I().removeButton(this.asset.btn_no, this.onBtnNo);
			
			App.I().buttonmanager.removeButton(this.asset.btn_yes);
			App.I().removeButton(this.asset.btn_yes, this.onBtnYes);
			
			//this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			
			DisplayObjectUtil.dispose(this.asset);
			this.asset = null;
			
		}
	}
}