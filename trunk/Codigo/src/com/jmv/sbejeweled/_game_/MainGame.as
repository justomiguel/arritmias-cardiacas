package com.jmv.sbejeweled._game_ 
{
	import com.jmv.arrtimias.board.Cell;
	import com.jmv.arrtimias.board.Tablero;
	import com.jmv.arrtimias.events.GeneralArritmiaEvent;
	import com.jmv.arrtimias.menues.MyMenu;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class MainGame extends Sprite {
		
		public static const INITIAL_ROWS:uint = 30;
		public static const INITIAL_COL:uint = 30;
		
		public var tablero:Tablero;
		public var myMenu:MyMenu;
		
		public var timer:Timer;
		
		
		public function MainGame() {
			super();
			
			this.myMenu = new MyMenu();
			this.addChild(myMenu);
			myMenu.addEventListener(GeneralArritmiaEvent.NEW_MODEL_EVENT, createNewModel);
			myMenu.addEventListener(GeneralArritmiaEvent.ACTIVE_MODEL_EVENT, startModeling);
			myMenu.addEventListener(GeneralArritmiaEvent.DEACTIVE_MODEL_EVENT, stopModeling);
			tablero.buildBoard(INITIAL_ROWS, INITIAL_COL);
			//generate my main Loop
			timer = new Timer(1);
		}
		
		private function stopModeling(e:GeneralArritmiaEvent):void {
			timer.removeEventListener(TimerEvent.TIMER, mainLoop);
		}
		
		private function startModeling(e:GeneralArritmiaEvent):void {
			timer.addEventListener(TimerEvent.TIMER, mainLoop);
		}
		
		private function mainLoop(e:TimerEvent):void {
			tablero.update();
		}
		
		private function createNewModel(e:GeneralArritmiaEvent):void {
			var filas:uint = e.data.filas;
			var columnas:uint = e.data.columnas;
			tablero.buildBoard(filas, columnas);
		}
		
		
	}

}