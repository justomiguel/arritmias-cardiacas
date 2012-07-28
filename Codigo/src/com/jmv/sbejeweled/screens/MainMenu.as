package com.jmv.sbejeweled.screens
{
	
	
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	
	import flash.display.DisplayObject;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	
	
	public class MainMenu extends MovieClip
	{

		public var myGrowAnimation:MovieClip;
		public var btn_play:MovieClip;
		public var grow:MovieClip;
	
		
		
		private var firsTime:int;
	
		
		public function MainMenu() {
			//trace( "MainMenu : " + MainMenu );
			
			//TransitionClass.getInstance().takePicture(this, this)
			//TransitionClass.getInstance().doFade();
				
			getStarted();
			
			
		}
		
		public function getStarted():void {

			this.play();
			this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0 ,true);
			
			this.btn_play.notGrowUp = true;		
			
		
			this.btn_play.mctext.label.alpha = 0; 
	
			

			App.I().initButton( this.btn_play, this.onPlay);
			
			this.btn_play.alpha = 0;
			
			this.grow.stop();
			App.I().initTextFields(this);
			
			Btn_Mute.getInstance().addBTNMute(this);
		}
		
		private function appearTextfield(e:Event):void {
			
			if (myGrowAnimation.currentFrame >= myGrowAnimation.totalFrames - 2) {

				this.btn_play.notGrowUp = null;
				
				
				this.btn_play.alpha = 1;
				try {
					STween.to(this.btn_play.mctext.label, 1, { alpha:1 } );		
				} catch (err:Error)
				{
					
				}
						
				
				myGrowAnimation.removeEventListener(Event.ENTER_FRAME, appearTextfield);
				
			}
			
		}
		
		
		
		private function onEnterFrame(ev:Event):void {
			
			if (this.currentFrame == this.totalFrames) {
				
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame );
				
				this.stop();
				
				myGrowAnimation = this.grow;
				myGrowAnimation.gotoAndPlay(1);
				myGrowAnimation.addEventListener(Event.ENTER_FRAME, appearTextfield);
			}
			
		}
		

		
		private function onPlay(ev:MouseEvent):void
		{
			
			if (!this.btn_play.notGrowUp) {
				firsTime++;
				if (this.hasEventListener(Event.ENTER_FRAME))
					this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame );
				
			
				//TransitionClass.getInstance().savePicture(this);
				
				this.btn_play.gotoAndStop(3);

				
				//App.I().hub.dispatch('onClickPlay');
				SApplication.application.scenes.switchScene("IntroScene");
				
				this.dispose();
			}
			
			
			
		}
		
	
	
		
		public function dispose():void
		{
			App.I().buttonmanager.removeButton( this.btn_play);
			App.I().removeButton(this.btn_play, this.onPlay);
			DisplayObjectUtil.remove(this.btn_play);
			DisplayObjectUtil.remove(this.myGrowAnimation);
			DisplayObjectUtil.dispose(this);
		}		
	}
}