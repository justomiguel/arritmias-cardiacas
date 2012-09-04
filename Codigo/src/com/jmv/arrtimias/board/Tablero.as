package com.jmv.arrtimias.board
{
	import com.jmv.arrtimias.events.PickerEvent;
	import com.jmv.arrtimias.utilities.MyMatrix;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class Tablero extends Sprite
	{
		
		public var myCells:MyMatrix;
		private var mySelection:Selection;
		
		public var backGround:Sprite;
		public var activador:Sprite;
		
		public var filas:uint;
		public var columnas:uint;
		
		//public var const 
		public var state:Number;
		
		public function Tablero(){
			mySelection = new Selection(this);
			this.activador.addEventListener(MouseEvent.MOUSE_DOWN, startDragActivador);
			this.activador.addEventListener(MouseEvent.MOUSE_UP, stopDragActivador);
		}
		
		private function stopDragActivador(e:MouseEvent):void
		{
			//prevent to create selection when moving the activador
			e.stopImmediatePropagation();
			e.stopPropagation();
			this.removeEventListener(MouseEvent.MOUSE_MOVE, moveActivador);
		}
		
		private function startDragActivador(e:MouseEvent):void
		{
			//prevent to create selection when moving the activador
			e.stopImmediatePropagation();
			e.stopPropagation();
			this.addEventListener(MouseEvent.MOUSE_MOVE, moveActivador);
		}
		
		private function moveActivador(e:MouseEvent):void
		{
			var localX:Number = e.stageX - this.x;
			var localY:Number = e.stageY - this.y;
			this.activador.x = this.mouseX - this.activador.width / 2;
			this.activador.y = this.mouseY - this.activador.height / 2;
		}
		
		public function buildBoard(filas:Number, columnas:Number):void
		{
			disposePreviousCells();
			var alto:Number = (this.backGround.height) / filas;
			var ancho:Number = (this.backGround.width) / (columnas);
			
			this.filas = filas;
			this.columnas = columnas;
			
			this.myCells = new MyMatrix(filas, columnas);
			
			for (var i:int = 0; i < filas; i++)
			{
				for (var j:int = 0; j < columnas; j++)
				{
					var celula:Cell = CellFactory.getCell();
					celula.width = ancho;
					celula.height = alto;
					celula.x = (ancho * j);
					celula.y = (alto * i);
					this.backGround.addChild(celula);
					myCells.setElement(i, j, celula);
				}
			}
			mySelection.createListeners();
			mySelection.addEventListener(PickerEvent.EVENT_TYPE, setColorChosedToCells);
		}
		
		private function setColorChosedToCells(e:PickerEvent):void
		{
			for (var i:int = 0; i < filas; i++)
			{
				for (var j:int = 0; j < columnas; j++)
				{
					var cell:Cell = myCells.getElement(i, j);
					if (cell.hitTestObject(mySelection))
					{
						/*var colors:Object = {one: 0, two: e.color.color, three: e.color.color};
						var m:flash.geom.Matrix = new flash.geom.Matrix();
						m.createGradientBox(200, 200, 3.14, 0, 0);
						cell.graphics.beginGradientFill(GradientType.RADIAL, [0, 0, 0xCCFF66], [1, 1, 1], [0, 0, 0xFF], m, SpreadMethod.REPEAT, InterpolationMethod.RGB, 0.78);
						cell.graphics.drawRect(0, 0, 200, 200);
						cell.graphics.endFill();*/
						
						cell.transform.colorTransform = e.color;
					}
				}
			}
		}
		
		private function disposePreviousCells():void
		{
			if (myCells != null)
			{
				for (var i:int = 0; i < filas; i++)
				{
					for (var j:int = 0; j < columnas; j++)
					{
						var cell:Cell = myCells.getElement(i, j);
						CellFactory.dispose(cell);
						this.backGround.removeChild(cell);
						myCells.setElement(i, j, null)
					}
				}
				myCells.disposeData();
				myCells = null;
			}
			mySelection.destroyListeners();
			mySelection.removeEventListener(PickerEvent.EVENT_TYPE, setColorChosedToCells);
		}
		
		public function dispose():void
		{
		
		}
		
		public function update():void
		{
		
		}
	
	}

}