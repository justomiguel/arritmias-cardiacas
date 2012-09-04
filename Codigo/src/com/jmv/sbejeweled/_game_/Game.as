package com.jmv.sbejeweled._game_ {
	
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import com.jmv.sbejeweled.screens.TransitionClass;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled._game_.players.User;
	import com.jmv.sbejeweled.screens.ScreenEndGame;
	import com.jmv.sbejeweled.settings;
	import flash.utils.Timer;
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class Game extends MovieClip {
		
		public var user:User;
		private var oponents:Array;
		public var level:Level;	
		private var screen:MovieClip;
		private var _duelNum:int;
		private var _gamePause:Boolean;
		public var tasks:Timer;
		public var _currentScene:GameScene;
		public var contPause:uint = 0;
		
		public function Game(caller:GameScene) {
			
			super();
			gamePause = true;
			this.initPlayers();
			_currentScene = caller;
			
		}
		
		public function get duelNum():int
		{
			return this._duelNum;
		}
		
		public function get gamePause():Boolean { return _gamePause; }
		
		public function set gamePause(value:Boolean):void 
		{
			_gamePause = value;
		}
		
		public function setPause(_pause:Boolean):void
		{
			if (_pause)
			{
				_gamePause = true;
				//this.tasks.stop();
				//if (this.level) this.level.goalTicker.stop();
				//if (this.level) this.level.secondTimer.stop();
			}
			else
			{
				_gamePause = false;
				//this.tasks.start();
				//if (this.level) this.level.goalTicker.start();
				
				
			}		}
		
		public function dispose():void{	
			try {
				endMyLevel();
				removeScreen();
				user.dispose();
				super.dispose();
			}catch (err:Error)
			{
				
			}
		}
		
		
		public function init():void
		{
			this.user.score.levelsWon = 0;
			this.user.scoreAnimal.tokens = 0;			
			this.startDuel(1);
		}
		

		
		private function initPlayers():void
		{
			this.user = new User(App.I().userId);

		}
		
		
		
		
		private function addScreen(newscreen:Class):void
		{
			if (this.screen != null) DisplayObjectUtil.dispose(this.screen);
			this.screen = new newscreen;
			this.addChild(this.screen);
		}
		
		private function removeScreen():void
		{
			if (this.screen != null)
			{ 
				DisplayObjectUtil.dispose(this.screen);
				this.screen = null;
			}
		}
		
		public function endGameFunction(winner:AbstractPlayer, status:String):void {
			
			winner.score.levelsWon++;
			
			
			
			winner.gameStatus = status;
			this.setPause(true);
			
			//TransitionClass.getInstance().savePicture(this.level);
			
			this.addScreen(ScreenEndGame);
			
			
			
	
			ScreenEndGame(this.screen).init(this.onScreenEndGameFunctionVictory);
				
		}
		
		private function onScreenEndGameFunctionVictory():void{
			this.screen = null;

			winGame();
		}
		
		private function onScreenEndGameFunctionLoose():void{
			this.screen = null;
			looseGame();
		}
		
		/** 
		 * 	LEVEL
		 */	

		public function nextLevel(winner:AbstractPlayer, status:String):void
		{
			
			if (this.level.num != settings.getCantLevels()) {
				winner.score.levelsWon++;
				winner.score.sum(500);
				winner.gameStatus = status;
				onScreenEndLevelComplete();
			} 
			
			
			
		}
		
		private function onScreenEndLevelComplete():void {
			var nextLevel:int = this.level.num + 1;
				if (this.user.gameStatus == "looser") {
					looseGame();
				} else if (nextLevel == settings.getCantLevels() + 1) {
					winGame();
				} else {
					this.startLevel(nextLevel);	
				}
		}
		
		private function restartLevel():void
		{
			this.endMyLevel();
			this.startLevel(this.level.num);
		}
		
		private function startLevel(num:int):void
		{
	
			if (num == 1) {
				this.endMyLevel();
				this.level = new Level(this, num);
				this.addChild(level);
				this.level.init();
				this.setPause(true);
				beginFirst()
				
			} else {
				this.setPause(false);
				this.level.initSettings(num);
				
			}
			
			
		}
		
		private function beginFirst():void{
			this.setPause(false);
			this.level.initBoardsIntros();
		}
		public function endMyLevel():void
		{
			if (this.level != null)
			{

				this.level.dispose();
				this.level = null;
			}
		}
		
		
		/** 
		 * 	DUEL 
		 */

		private function isNextDuel(nlevel:int):Boolean
		{
			return nlevel > this._duelNum * settings.duel.cantLevelsPerDuel; 
		}
		
		private function isLastLevel():Boolean
		{
			return this.level.num == settings.getCantLevels();
		}
		
		private function getFirstLevelForDuel(nduel:int):int
		{
			return ((nduel-1) * settings.duel.cantLevelsPerDuel) + 1;
		}			
		
		private function looseGame():void
		{
				SApplication.application.scenes.switchScene("ScreenLooseGameScene");
				
		}
		
		private function winGame():void
		{
			SApplication.application.scenes.switchScene("ScreenWinGameScene");
			this.endMyLevel();
			App.I().setGameIsRunning(false);
		}
		
		private function startDuel(num:int):void
		{
				App.I().setGameIsRunning(true);
				this._duelNum = num;
				this.startLevel(this.getFirstLevelForDuel(num));	
		}
		
		private function onScreenStartDuelComplete():void
		{
			this.removeScreen();
			
			this.startLevel(this.getFirstLevelForDuel(this._duelNum));
		}
		
		private function checkLoseGame():Boolean
		{
			return 0 > this.user.score.levelsWon;
		}
	}
}

