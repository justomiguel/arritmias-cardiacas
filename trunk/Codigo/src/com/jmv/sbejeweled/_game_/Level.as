package com.jmv.sbejeweled._game_
{
	import com.jmv.framework.core.SSprite;
	import com.jmv.framework.events.SEvent;
	import com.jmv.sbejeweled._game_._board_.Tile;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.BallMeter;
	import com.jmv.sbejeweled._game_.ui.fxbars.TimePassFx;
	import com.jmv.sbejeweled._game_.ui.ProgressBar;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_.effects.PopUpText;
	import com.jmv.sbejeweled._game_.players.*;
	import com.jmv.sbejeweled._game_.ui.Background;
	import com.jmv.sbejeweled._game_.ui.LevelUI;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import com.jmv.sbejeweled.screens.TransitionClass;
	import com.jmv.sbejeweled.settings;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;

	
	
		
	public class Level extends SSprite
	{
	
		public static const WINGAME:String = "wingame";
		
		private var _num:int;
		private var levelUI:LevelUI;
		
		public var userBoard:Board;
		//private var oponentBoard:Board;
		private var game:Game;
		
		public var goal:Object;
		public var goalTicker:Timer;
		public var secondTimer:Timer;
		private var increasePerPowerUPMatch:uint;
		private var increasePerMatch:uint;
		private var goalTokens:Object;
		private var levelTokens:int;
		public var bg:Background;
		
		public var animalTalents:int;
		private var scoreByTokens:int;
		public var tickCount:Number;
		public var secondtickCount:Number;
		private var tiempoActual:Date;
		private var tiempoInicio:Date;
		private var tiempoFin:Date;
		private var tiempoTemp:Date;
		private var hasLoose:Boolean;

		
		public function Level(_game:Game, num:int)
		{
			super();
			this._num = num;
			this.addLayer('bg');
			this.addLayer('ui');
			this.addLayer('boards');
			var layer:Sprite = this.addLayer('popups');
			layer.mouseChildren = false;
			layer.mouseEnabled = false;
			this.game = _game;
			
		}
		
		public function initSettings(numLevel:int):void {

			this.goalTokens = settings.getGoalTokens();

			levelTokens += settings.getGoal(numLevel).tokens;
			this._num = numLevel;
		
			this.increasePerMatch = settings.getMaxSettingsPerLevel(numLevel).tokenTalentGeneralValue;
			this.increasePerPowerUPMatch = settings.getMaxSettingsPerLevel(numLevel).poweruptokenTalentGeneralValue;
			this.scoreByTokens = settings.getMaxSettingsPerLevel(numLevel).scorebytoken;
			var userData:Object = settings.getPlayerData(this.game.user.id, numLevel);
			this.userBoard.gamePowerups = userData.powerups;
			this.userBoard.gameColorodds = userData.colorodds;
			
			
			
			this.levelUI.updateBackGround();
		}
		
		public function init():void
		{
			
			this.goal = settings.getGoalTokens();
			this.goalTokens = settings.getGoalTokens();
		
			levelTokens = settings.getGoal(this._num).tokens;
			
			animalTalents = 0;
			
			this.increasePerMatch = settings.getMaxSettingsPerLevel(this._num).tokenTalentGeneralValue;
			
			
			this.increasePerPowerUPMatch = settings.getMaxSettingsPerLevel(this._num).poweruptokenTalentGeneralValue;
			
			this.scoreByTokens = settings.getMaxSettingsPerLevel(this._num).scorebytoken;
			
			var userData:Object = settings.getPlayerData(this.game.user.id, this._num);
			
			
			bg = new Background();
			bg.tiempo.visible = false;
			
			this.addNamedChildAtPath('bg','background', bg );

			App.I().initTextFields(this.bg);
			
			Btn_Mute.getInstance().addBTNMute(this.bg);
			
			this.userBoard = new Board(null, userData.colorodds, userData.powerups);
			this.userBoard.addEventListener(Board.REMOVE_TOKENS, this.onChipsAdded, false, 0, true );
			this.userBoard.addEventListener(Board.SHOW_POPUP, this.showPopup, false, 0 ,true);
			this.userBoard.addEventListener(Board.PLAY_SFX, this.onPlaySFX, false, 0 , true);
			this.userBoard.addEventListener(Board.MATCH_DONE, this.onMatchDone, false, 0, true); 
			this.userBoard.addEventListener(Board.POWERUP_MATCH, this.onPowerUpMatchDone, false, 0, true);
			
			this.userBoard.x = bg.anchorBoard1.x;
			this.userBoard.y = bg.anchorBoard1.y;			
			
			this.addChildAtPath('boards', this.userBoard);
			
			this.game.user.setBoard(this.userBoard);
			
			var vectorBalls:Array;
			vectorBalls = [];
			vectorBalls.push(bg.animalBallMeter);
			
			this.levelUI = new LevelUI(game, bg.timerBar, bg.timerFX, bg.meterAnimal, vectorBalls, bg.tiempo);
			this.addChildAtPath('ui', this.levelUI);
			this.levelUI.init();
			
			if (this.goal.seconds) {
				//fairies
				//this.goalTicker = new Ticker(10, this.onGoalTick);
				//this.tasks.add(this.goalTicker);
				this.goalTicker = new Timer(1000);
				goalTicker.addEventListener(TimerEvent.TIMER,  this.onGoalTick);
				tickCount = 0;
				goalTicker.start();
				
				//this.game.tasks = this.goalTicker;
			}
			
			//yerman paranoico
			hasLoose = false;
			tiempoInicio = new Date();
			tiempoActual = tiempoInicio
			this.doSecondTimer();
		}
		
		private function onPowerUpMatchDone(ev:SEvent):void {
			var list:Array = ev.data as Array;
			decrementGoalTicker(list.length);
		}
		
		
		
		
		
		public function initBoardsIntros():void
		{
			if (!App.I().muted) App.I().audio.retrieve('sfx/level_start').volume = 0.2;
			
			this.playSfx('level_start');
			var mission:String;

			mission = settings.getIngameText('seconds');
			
			(this.bg.multi.animal as TextField).text = "0";
			
			this.userBoard.getIntro().init(mission);

		}
		
		public override function dispose():void
		{
			//Log.sendMessage( "dispose : " + dispose );
			this.userBoard.removeEventListener(Board.REMOVE_TOKENS, this.onChipsAdded);
			this.userBoard.removeEventListener(Board.POWERUP_MATCH, this.onMatchDone);
			this.userBoard.removeEventListener(Board.MATCH_DONE, this.onMatchDone);
			this.userBoard.removeEventListener(Board.SHOW_POPUP, this.showPopup);
			this.userBoard.removeEventListener(Board.PLAY_SFX, this.onPlaySFX);

			
			this.game.user.endLevel();
			
			this.userBoard.dispose();
			this.userBoard = null;
			
			this.bg = null;
		
			
			this.levelUI.dispose();
			
			
			
			if (this.goalTicker)
			{
				this.goalTicker.stop();
				this.goalTicker.removeEventListener(TimerEvent.TIMER, onGoalTick);
				//this.tasks.remove(this.goalTicker);
				this.goalTicker = null;
			}
			
			
			if (this.secondTimer)
			{
				this.secondTimer.stop();
				this.secondTimer.removeEventListener(TimerEvent.TIMER, this.onSecondTimer);
				this.secondTimer = null;
			}
			
			this.game = null;
			//Hotkey.reset();
			
			this.levelUI = null;
			
			super.dispose();
		}
		
		private function onChipsAdded(ev:SEvent):void
		{
			var player:AbstractPlayer = this.game.user;

			player.score.tokens += ev.data.ammount as int;

			
			this.levelUI.updateScore(this.goalTokens);

			this.checkGoalTokens();
		}
		
		private function showPopup(ev:SEvent):void
		{
			
			if ((this.getChildByPath('popups') as Sprite).numChildren == 0) {
				var g:DisplayObject = new PopUpText(ev.data);
				g.x -= 98;
				g.y += 18;
				this.addChildAtPath('popups', g);
			}
			
			
		}
		

		private function onGoalTick(e:TimerEvent):void
		{
			tickCount++;
			var seconds:Number;
				seconds = this.goal.seconds - this.tickCount ;
			
			if (seconds <= 0) {
				if (!hasLoose) {
					looseGame();
				}	
			}else {
			
				this.levelUI.updateSeconds(seconds);	
			}
			
			this.levelUI.getTimeBar("time").showFillAnimation(this.levelUI, this.levelUI.getTimeBar("time").x, this.levelUI.getTimeBar("time").y)
		}
		
		private function looseGame():void {			
			hasLoose = true;
			var winner:AbstractPlayer = this.game.user;
			this.game.endGameFunction(winner, "winner");
			
			this.goalTicker.stop();
			this.secondTimer.stop();
			
			tiempoFin = new Date();

			//trace( "tiempoFin.time : " + tiempoFin.time );
			//trace( "tiempoFin.time - tiempoInicio.time : " + ((tiempoFin.time - tiempoInicio.time) / 1000).toString() );
			
			//trace( "secondtickCount : " + secondtickCount );
			//trace( "secondtickCount / 353 : " + secondtickCount / 353 );
			//trace( "secondtickCount / 353 * 2 : " + (secondtickCount / 353) * 2 );
		}
		
		
		private function doSecondTimer():void {
			this.secondTimer = new Timer(2000);
			secondTimer.addEventListener(TimerEvent.TIMER,  this.onSecondTimer);
			secondtickCount = 0;
			secondTimer.start();		
		}
		
		private function onSecondTimer(e:TimerEvent):void {
			secondtickCount += 353;
			tiempoTemp = tiempoActual;
			tiempoActual = new Date();
			
			if (tiempoActual.time <= tiempoTemp.time)	{
				//SE DEBERIA GUARDAR EN LA BASE DE DATOS
				trace("Hack de windows se cambio: " + (tiempoActual.time - tiempoTemp.time) );
				App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_HACK);
				
				
			}else {
				var desfasaje:Number = (tiempoActual.time - tiempoInicio.time) / 1000;
				//trace( "desfasaje  resta de tiempos: " + desfasaje );
				
				desfasaje =(desfasaje - tickCount);
				//trace( "desfasaje - tickcount " + desfasaje );
				
				if ( Math.abs(desfasaje) > 1 ) {
					
					//trace("DESFASAJE MAYOR a 1");
					
					tickCount += Math.floor(desfasaje);
					//trace( "NUEVO tickCount : " + tickCount );
										
				}
			}
			
			//otra comparacion por las dudas
			if ( (secondtickCount / 353 * 2) >= this.goal.seconds && !hasLoose) {
				trace( "this.goal.seconds : " + this.goal.seconds );
				trace( "ssssssssssssssssssssssecondtickCount : " + (secondtickCount / 353 * 2) );
				looseGame();
			}
			//trace( "tiempoActual.time en segundos: " + tiempoActual.time / 1000);	
			
		}
		
		private function checkTalentTokens(e:Event = null):void {
			
				if (this.game.user.scoreAnimal.tokens >= goalTokens.tokens) {
						
					var scores:Array = new Array();
					scores = this.game.user.getTokensOrderedScores(this.game);
									
					animalTalents++;
					(this.bg.multi.animal as TextField).text = (animalTalents).toString();
					this.game.user.scoreAnimal.tokens = 0;
				
				}
			
		}
		
		private function checkGoalTokens():void {

				if ( this.game.user.score.tokens >= levelTokens) {
					
					this.game.nextLevel(this.game.user, "winner");
				} 
		}
		
		
		
		private function onPlaySFX(ev:SEvent):void
		{
			this.playSfx(ev.data);
		}
		
		private function onMatchDone(ev:SEvent):void {
			
			var tile:Tile;
			for (var k:int = 0; k < ev.data.length ; k++) {
				
			
				tile = ev.data[k] as Tile;

				//switch(tile.currentChip.getType()) {
					//
		//
					//case "animal":
						this.game.user.scoreAnimal.tokens += increasePerMatch;
						
					//break;
					//case "water":
						//this.game.user.scoreWater.tokens += increasePerMatch;
					//break;
					//case "garden":
						//this.game.user.scoreGarden.tokens += increasePerMatch;
					//break;
					//case "light":
						//this.game.user.scoreLight.tokens += increasePerMatch;
						//
					//break;
					//case "tinker":
						//this.game.user.scoreTinker.tokens += increasePerMatch;
					//break;
					
				//}
				
				this.game.user.score.sum(scoreByTokens);
				
				var talentMeter:ProgressBar;
				
				talentMeter = this.levelUI.getTimeBar("animal");
				if (talentMeter != levelUI.timerBar) {
					var x:Number = talentMeter.x;
					var y:Number = (talentMeter.defaultHeight - talentMeter.masc.height) + talentMeter.y ;
					talentMeter.showFillTalentAnimation(this.levelUI, x , y);
					
					this.levelUI.getBall("animal").glow(); 
				}
				
				
				
			}
			
			
			var goal:Object = this.game.level.getGoal(); 
			
			checkTalentTokens(); 
			
			decrementGoalTicker(ev.data.length);
		}
		
		private function decrementGoalTicker(times:int):void {
			var timeIncrementByMatch:int;
			
			timeIncrementByMatch = settings.getMaxSettingsPerLevel(this._num).timeIncrementByToken * times;
			
			if (tickCount < timeIncrementByMatch) {
				tickCount = 0;
				
			}else {
				tickCount -= timeIncrementByMatch;
				if (tickCount < 0) tickCount = 0;
				
			}
		}
		
		
		private function playSfx(id:String):void
		{
			App.I().audio.play('sfx/' + id);
		}
		
		public function get num():int
		{
			return this._num;
		}
		
		public function getGoal():Object
		{
			return this.goal;
		}
		
		
		private function cheatlevel(ev:KeyboardEvent):void{this.game.nextLevel(this.game.user, "winner");}

	}
}