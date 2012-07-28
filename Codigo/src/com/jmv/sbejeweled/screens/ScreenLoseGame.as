package com.jmv.sbejeweled.screens
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled.screens.endingscreens.AnimalScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.GardenScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.LigthScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.TinkerScreenWinGameAsset;
	import com.jmv.sbejeweled.screens.endingscreens.WaterScreenWinGameAsset;
	
	import flash.display.MovieClip;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import com.jmv.sbejeweled.settings;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	
	public class ScreenLoseGame extends MovieClip
	{
		private var asset:MovieClip;
		private var game:Game;
		private var scores:Array;
		private var winnerFortune:String;
		
		public function ScreenLoseGame(autoStart:Boolean=true)
		{
			super();
			
			game = App.I().game;
			
			scores = new Array()
			scores = game.user.getOrderedScores(game); 
			
			this.asset = new AnimalScreenWinGameAsset();
			
			this.addChild(asset);
			
			
			App.I().initButton(this.asset.btn_submitscore, this.onClickOk);
			App.I().initButton(this.asset.btn_playagain, this.onClickPlayAgain);
			App.I().initButton(this.asset.btn_link, this.onClickLink);
			
			App.I().initTextFields(this.asset);
			
			//this.asset.totalscore_num.label.text = game.user.score.totalScore;	
			this.asset.totalscore_num.label.text = game.user.score.totScore;	
			
			var fraseAMostrar:int = Math.round((game.user.score.tokens) * settings.getCantTotalScoreText() / settings.getGoalTokens().tokens) + 1;
			
			if (fraseAMostrar > settings.getCantTotalScoreText()) {
				fraseAMostrar = settings.getCantTotalScoreText();
			}
			
			this.asset.finalScoreText.label.text = settings.getFinalScoreText(fraseAMostrar.toString()) ;
			
			this.asset.text_link.text = settings.getFinalLinkText(winnerFortune);
				
			var fortuneNumber:Number; 
			fortuneNumber = Math.round(Math.random() * settings.getCantTotalFortunes(winnerFortune)); //Facu
			this.asset.comment2.fortuneTeller.text = settings.getFortuneText(winnerFortune + (fortuneNumber as String)); //Facu;
			if ((this.asset.comment2.fortuneTeller.text.length < 15)) {
				this.asset.comment2.fortuneTeller.text = settings.getFortuneText(winnerFortune + "1");
			}
				
			this.asset.play();
			
			this.asset.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		
		}
		
		private function onClickPlayAgain(e:MouseEvent):void{
			//TransitionClass.getInstance().savePicture(this.asset);
			//App.I().hub.dispatch('onClickPlayAgain');
			SApplication.application.scenes.switchScene("GameScene");
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
		}		
		
		private function onClickLink(e:MouseEvent):void{
			//TransitionClass.getInstance().savePicture(this.asset);
			navigateToURL(new URLRequest(settings.getFinalLinkURL(winnerFortune)));
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
			super.dispose();
		}
	}
}