package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.core.SApplication;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.gaming.ai.state_machines.base.SMMachine;
	import com.jmv.framework.gaming.ai.state_machines.base.SMState;
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled.screens.Instructions;
	import com.jmv.sbejeweled.screens.Pause;
	import com.jmv.sbejeweled.screens.Quit;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameScene extends SScene {
		
		public static const ENTER_PLAYING:String = "ENTER_PLAYING";
		public static const EXIT_PLAYING:String = "EXIT_PLAYING";
		
		public static const ON_CLICK_HELP:String = "ON_CLICK_HELP"
		public static const ON_CLICK_QUIT:String = "ON_CLICK_QUIT"
		public static const ON_CLICK_PREV_QUIT:String = "ON_CLICK_PREV_QUIT"
		public static const ON_CLICK_BACK:String = "ON_CLICK_BACK"
		public static const ON_CLICK_MENU:String = "ON_CLICK_MENU"
		public static const ON_CLICK_NO:String = "ON_CLICK_NO"
		public static const ON_CLICK_RESUME:String = "ON_CLICK_RESUME"
		public static const ON_CLICK_YES:String = "ON_CLICK_YES"
		public static const ON_HACK:String = "ON_HACK"
		
		// Screens on this scene
		public var game:Game;
		public var pauseS:Pause;
		public var instructions:Instructions;
		public var quit:Quit;
		
		// state machine for display purpose;
		public var screenMachineState:SMMachine;
		
		// states
		public var gameScene:SMState;
		public var quitScene:SMState;
		public var helpScene:SMState;
		public var pauseScene:SMState;
		private var deadScene:SMState;
		
		
		public function GameScene() {
			
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			gameScene = new SMState("gameScene", null, initGame, exitGame);
			quitScene = new SMState("quitScene", null, enterQuitScene, exitQuitScene);
			helpScene = new SMState("helpScene", null, enterHelpScene, exitHelpScene);
			pauseScene = new SMState("pauseScene", null, enterPauseScene, exitPauseScene);
			deadScene = new SMState("deadScene", null, enterDeadScene);
			
			screenMachineState = new SMMachine(gameScene);
			
			screenMachineState.addTransition(gameScene, helpScene, ON_CLICK_HELP); 
			screenMachineState.addTransition(gameScene, quitScene, ON_CLICK_QUIT);
			screenMachineState.addTransition(gameScene, quitScene, ON_CLICK_PREV_QUIT);
			screenMachineState.addTransition(gameScene, pauseScene, ON_CLICK_MENU);
			screenMachineState.addTransition(gameScene, deadScene, ON_HACK);
			
			screenMachineState.addTransition(helpScene, gameScene, ON_CLICK_BACK);
			
			screenMachineState.addTransition(pauseScene, gameScene, ON_CLICK_RESUME);
			screenMachineState.addTransition(pauseScene, quitScene, ON_CLICK_QUIT);
			
			screenMachineState.addTransition(quitScene, gameScene, ON_CLICK_NO);
			screenMachineState.addTransition(quitScene, deadScene, ON_CLICK_YES);
			
			try {
				if (game) game.dispose();
				game = null;
			} catch (err:Error)	{
				
			}
			
			
			game = new Game(this);
			App.I().game = game;
			this.addChild(game);
			
			this.game.init();
						
		}
		
		
		
		private function enterDeadScene():void {
			if (App.I().game.level.goalTicker) App.I().game.level.goalTicker.stop();
			if (App.I().game.level) App.I().game.level.secondTimer.stop();
			addChild(game);
			SApplication.application.scenes.switchScene("MainMenuScene");
			
			
		}
				
		private function exitHelpScene():void {
			removeChild(instructions);
			this.instructions = null;
		}
		
		private function enterHelpScene():void {
			this.instructions = new Instructions();
			addChild(instructions);
		}
		
		
		private function exitPauseScene():void {
			removeChild(pauseS);
			this.pauseS = null;
		}
		
		private function enterPauseScene():void {
			this.pauseS = new Pause();
			addChild(pauseS);
			
		}
		
		private function exitQuitScene():void {
			removeChild(this.quit);
			this.quit = null;
		}
		
		private function enterQuitScene():void {
			this.quit = new Quit();
			addChild(this.quit);
			
		}
		
		private function exitGame():void {
			App.I().scenes.dispatchEvent(new SEvent(EXIT_PLAYING));
			//this.removeChild(game);
		}
		
		private function initGame():void {
			App.I().scenes.dispatchEvent(new SEvent(ENTER_PLAYING));
			this.addChild(game);
			
		}
		
		override public function dispose():void  {
			//trace( "dispose 0000000000000000000000000000 : " + dispose );
			try {
				//if (game) game.dispose();
				//game = null;
				
				if (pauseS) pauseS.dispose();
				pauseS = null;
				
				if (instructions) instructions.dispose()
				instructions = null;
				
				if (quit) quit.dispose();
				quit = null;
				
				gameScene = null;
				
				quitScene = null;
				
				helpScene = null;
				
				pauseScene = null;
				
				deadScene = null;
				
				screenMachineState = null;
				
			}catch (err:TypeError){
				
			}
			
			super.dispose();
		}
		
	}

}