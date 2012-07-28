package com.jmv.sbejeweled._game_.ui
{
	import com.jmv.framework.tween.STween;
	import com.jmv.sbejeweled._game_._board_.BoardLayer;
	import com.jmv.sbejeweled._game_.Level;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.BallMeter;
	import com.jmv.sbejeweled._game_.ui.bars.TimeBar;
	import com.jmv.sbejeweled._game_.ui.fxbars.TimePassFx;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled._game_.Score;
	import com.jmv.sbejeweled.screens.sismomainscenes.GameScene;
	import com.jmv.sbejeweled.screens.TransitionClass;
	import com.jmv.sbejeweled.settings;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import flash.utils.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	
	public class LevelUI extends MovieClip
	{
		public var btn_pause:MovieClip;
		public var btn_help:MovieClip;
		public var btn_quit:MovieClip;
		
		

		public var userScore:TextField;
		public var score_name1:TextField;
		public var duel_name:TextField;
		public var tokens_name1:TextField;
		public var userTokens:TextField;
		public var score_board:TextField;
		
		private var game:Game;
		
		private var tiempo:MovieClip;
		
		public var talentHeader:TextField;
		
		public var timerBar:ProgressBar; 
		private var meterWater:ProgressBar; 
		private var meterGarden:ProgressBar; 
		private var meterLight:ProgressBar; 
		private var meterTinker:ProgressBar; 
		private var meterAnimal:ProgressBar; 
		
		private var ballWater:BallMeter; 
		private var ballGarden:BallMeter; 
		private var ballLight:BallMeter; 
		private var ballTinker:BallMeter; 
		private var ballAnimal:BallMeter; 
		private var arrayBackUsed:Array;
		
		private var fondoAnterior:MovieClip;
		private var fondoNuevo:MovieClip;
		
		public var tiempoRestante:TextField;
		
		public function LevelUI(game:Game, timerBar:ProgressBar, timerFX:TimePassFx, meterAnimal:ProgressBar, vectorBalls:Array, tiempo:MovieClip)
		{
			super();
			
			
			arrayBackUsed = new Array();
			
			this.timerBar = timerBar;
			this.meterWater = meterWater;
			this.meterGarden = meterGarden;
			this.meterLight = meterLight;
			this.meterTinker = meterTinker;
			this.meterAnimal = meterAnimal;
			
			
			this.ballWater =  vectorBalls[4];
			this.ballGarden=  vectorBalls[1];
			this.ballLight=  vectorBalls[2];
			this.ballTinker=  vectorBalls[3];
			this.ballAnimal=  vectorBalls[0];
			
			this.game = game;
			this.tiempo = tiempo;
		
			
			App.I().initButton( this.btn_pause, this.onClickPause );
			App.I().initButton( this.btn_help, this.onClickHelp );			
			App.I().initButton( this.btn_quit, this.onClickPrevQuit );			
			
			
			
			App.I().initTextFields(this);
			
			
			
			
		}
		
		
		
		public function updateBackGround():void {
			
			
			
			if (this.game.level.bg.bg.numChildren <= 0) {
				fondoNuevo = getRandomBackground();
				this.game.level.bg.bg.addChild(fondoNuevo);
			} else {
				
				
				var myBeforeBitmap:BitmapData = new BitmapData(fondoNuevo.width, fondoNuevo.height, true)
				
				myBeforeBitmap.draw(fondoNuevo);
				
				fondoAnterior = null;
				fondoAnterior = new MovieClip();
				fondoAnterior.addChild(new Bitmap(myBeforeBitmap));
				
				fondoNuevo = getRandomBackground();
				this.game.level.bg.bg.addChild(fondoNuevo);
				
				this.game.level.bg.bg.addChild(fondoAnterior);
				
				
				STween.to(fondoAnterior, 0.3, { autoAlpha:0, BlurFilter:{blurX:20}, onComplete:finishTweenLite } );
				
			}
		}
		
		private function finishTweenLite():void {
			if (fondoAnterior) {
				this.game.level.bg.bg.removeChild(fondoAnterior);
				fondoAnterior = null;
			}
		}
		
	
		public function getRandomBackground():MovieClip {
			
			var num:int;
			var i:int;
			var band:Boolean = true;
			var background:MovieClip = new BackGroundImage();
		
			if (arrayBackUsed.length == 0) {
				num = Math.round(Math.random() * (background.totalFrames - 1));
				arrayBackUsed.push(num);
			} else {
				if (arrayBackUsed.length == background.totalFrames) {
					arrayBackUsed = new Array();
				}
				while (band) {
					
					num = Math.round(Math.random() * (background.totalFrames - 1));
					
					i = 0;
					while ((i < arrayBackUsed.length) && (num != arrayBackUsed[i])) {
						
						i++;
					}
					if (i == arrayBackUsed.length) {
						arrayBackUsed.push(num);
						band = false;
					}
				}
				
			}
			
			
			background.gotoAndStop(num);
			
			return background;
		}
		
		public function dispose():void
		{
			//Log.sendMessage( "dispose : " + dispose );
			this.game = null;
			 
			timerBar = null; 
			meterWater = null; 
			meterGarden = null; 
			meterLight = null; 
			meterTinker = null; 
			meterAnimal = null; 
		
			ballWater = null;  
			ballGarden = null;  
			ballLight = null;  
			ballTinker = null;  
			ballAnimal = null;  
			arrayBackUsed = null;
		
			fondoAnterior = null;
			fondoNuevo = null;	
			
			App.I().buttonmanager.removeButton( this.btn_pause);
			App.I().removeButton( this.btn_pause, this.onClickPause );
			
			App.I().buttonmanager.removeButton( this.btn_help );
			App.I().removeButton( this.btn_help, this.onClickHelp );
		
			
			tiempoRestante = null;
		
			
		}
		
		
		
		
		public function init():void {
			

			
			var nlevel:int = this.game.level.num;
			
			var goal:Object = this.game.level.getGoal();
			
			updateBackGround();
			
			this.updateScore(goal);
			
			this.tiempoRestante.text = this.game.level.getGoal().seconds;
		}
		
		
		public function getTimeBar(string:String):ProgressBar {
			switch (string) {
				case "time":
					return this.timerBar;
				break;
				case "animal":
					return this.meterAnimal;
				break;
				default:
					return this.meterAnimal;
				break;
			}
			return timerBar;
		}
		
		public function getBall(string:String):BallMeter {
			switch (string) {
				case "animal":
					return this.ballAnimal;
				break;
				default:
					return this.ballAnimal;
				break;
			}
			return ballTinker;
		}
		
		public function updateSeconds(sec:Number):void 
		{
		
			var totalSeconds:int = this.game.level.getGoal().seconds;
			
			
			//if ((sec / totalSeconds) < 0.36) {
				//((this.timerBar) as TimeBar).addTimeOverFX(this, this.timerBar.x, this.timerBar.y);
			//}else {
				//((this.timerBar) as TimeBar).removeTimeOverFX();
			//}
			
			//((this.timerBar) as TimeBar).updateTimer(sec / totalSeconds);
			//trace( "sec : " + sec );
			

			tiempoRestante.text = formatearTiempo(sec);
			if (sec == 10) {
				trace("reproducir sonido");
				App.I().audio.fx.play("sfx/Clock_Counter_V2");
				this.tiempo.visible = true;
			}
			
		}
		
		public function updateScore(goal:Object):void {
			
			var usScore:Score = this.game.user.score;
		
			this.userTokens.text = usScore.tokens.toString();
	
			//this.userScore.text = usScore.totalScore.toString();
			this.userScore.text = usScore.totScore.toString();
			
			var usAnimalScore:Score = this.game.user.scoreAnimal;

			this.meterAnimal.update( (usAnimalScore.tokens / goal.tokens) );

		}
		
		/**
		* funcion de ayuda para formatear el tiempo
		* @param	tpf 	tiempo para formatear
		* @return tiempo formateado en el format mm:ss
		*/
		private function formatearTiempo(tpf:Number):String {
			var minutes : String;
			var seconds : String;
			minutes = Math.floor(tpf / 60).toString();
			if(minutes.length < 2) {
				minutes = "0" + minutes;
			}
			seconds = (Math.floor(tpf) % 60).toString();
			if(seconds.length < 2) {
				seconds = "0" + seconds;
			}
			
			return (minutes + ":" + seconds) ;
		}
		
		private function onClickPrevQuit(ev:MouseEvent):void
		{
			
			//TransitionClass.getInstance().savePicture(this.game.level);
			//App.I().hub.dispatch('onClickHelp');
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_PREV_QUIT);
		}
		
		private function onClickHelp(ev:MouseEvent):void
		{
			
			//TransitionClass.getInstance().savePicture(this.game.level);
			//App.I().hub.dispatch('onClickHelp');
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_HELP);
		}
		
		private function onClickPause(ev:MouseEvent):void {
			
			this.game.setPause(true);
			//TransitionClass.getInstance().savePicture(this.game.level);
			//App.I().hub.dispatch('onClickPause');
			
			//contar la cantidad de pausas que se hicieron en la partida
			App.I().game.contPause++;
			
			//if (App.I().game.contPause > 2){
				//this.game.level.tickCount++;
			//}
			App.I().game._currentScene.screenMachineState.setEvent(GameScene.ON_CLICK_MENU);
			
		}		
	}
}