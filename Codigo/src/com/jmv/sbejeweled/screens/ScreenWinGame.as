package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	import com.jmv.sbejeweled.screens.endingscreens.AnimalScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.GardenScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.LigthScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.TinkerScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.WaterScreenWinGameAsset;
	import com.jmv.sbejeweled.settings;
	
	import flash.display.MovieClip;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	
	public class ScreenWinGame extends MovieClip
	{
		private var asset:ScreenWinGameAsset;
		private var game:Game;
		private var winnerFortune:String;
		public function ScreenWinGame(autoStart:Boolean=true)
		{
			super();
			
			game = App.I().game;
			
			
			var scores:Array = new Array()
			scores = game.user.getOrderedScores(game); 
			
			
			winnerFortune = null;
			
						
			winnerFortune = "Animal";
			
			this.asset = new AnimalScreenWinGameAsset();
			
			this.addChild(asset);
			
			
			//TransitionClass.getInstance().takeEndingPicture(this.asset, this);
			//TransitionClass.getInstance().doLastFade();
			

			App.I().initButton(this.asset.btn_submitscore, this.onClickOk);
			App.I().initButton(this.asset.btn_playagain, this.onClickPlayAgain);
			App.I().initButton(this.asset.btn_link, this.onClickLink);
			
			App.I().initTextFields(this.asset);
			
			//this.asset.totalscore_num.label.text = game.user.score.totalScore;			
			this.asset.totalscore_num.label.text = game.user.score.totScore;			

			

			
			var fraseAMostrar:int;
			
			if (game.user.score.totalScore <= 1650) {
				fraseAMostrar = 1;
			}else if (game.user.score.totalScore <= 3300) {
				fraseAMostrar = 2;
			}else if (game.user.score.totalScore <= 4950) {
				fraseAMostrar = 3;
			}else if (game.user.score.totalScore <= 6600) {
				fraseAMostrar = 4;
			}else if (game.user.score.totalScore <= 8250) {
				fraseAMostrar = 5;
			}else if (game.user.score.totalScore <= 9900) {
				fraseAMostrar = 6;
			}else if (game.user.score.totalScore <= 11550) {
				fraseAMostrar = 7;
			}else {
				fraseAMostrar = 8;
			}
			
			
			this.asset.finalScoreText.label.text = settings.getFinalScoreText(fraseAMostrar.toString()) ;
			
			this.asset.link_description.label.text = settings.getLinkDescription(winnerFortune);
			
			this.asset.text_link.text = settings.getFinalLinkText(winnerFortune);
				
			var fortuneNumber:Number; 
			fortuneNumber = Math.round(Math.random() * settings.getCantTotalFortunes(winnerFortune)); 
			this.asset.comment2.fortuneTeller.text = settings.getFortuneText(winnerFortune + (fortuneNumber as String)); //Facu;
			if ((this.asset.comment2.fortuneTeller.text.length < 15)) {
				this.asset.comment2.fortuneTeller.text = settings.getFortuneText(winnerFortune + "1");
			}
				
			
			this.asset.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			
			Btn_Mute.getInstance().addBTNMute(this.asset);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			
			if (this.asset.currentFrame == this.asset.totalFrames)
			{
				this.asset.stop();
			}
		}
				
		private function onClickOk(e:MouseEvent):void
		{
			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickOk');
			SApplication.application.scenes.switchScene("MainMenuScene");
			this.dispose();
		}		
		
		private function onClickLink(e:MouseEvent):void{
			//TransitionClass.getInstance().savePicture(this.asset);
			navigateToURL(new URLRequest(settings.getFinalLinkURL(winnerFortune)));
			
		}	
		
		private function onClickPlayAgain(e:MouseEvent):void{
			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickPlayAgain');
			SApplication.application.scenes.switchScene("GameScene");
			this.dispose();
			
		}	
		public function dispose():void
		{
			App.I().buttonmanager.removeButton(this.asset.btn_submitscore);
			App.I().removeButton(this.asset.btn_submitscore, this.onClickOk);
			
			App.I().buttonmanager.removeButton(this.asset.btn_playagain);
			App.I().removeButton(this.asset.btn_playagain, this.onClickPlayAgain);
			
			App.I().buttonmanager.removeButton(this.asset.btn_link);
			App.I().removeButton(this.asset.btn_link, this.onClickLink);
			
			this.asset.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			DisplayObjectUtil.dispose(this.asset);
			this.asset = null;
		}
	}
}