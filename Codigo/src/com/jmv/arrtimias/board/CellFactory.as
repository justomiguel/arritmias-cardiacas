package com.jmv.arrtimias.board 
{
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class CellFactory 
	{
		
		private var _cells:Array;
		private var _max:uint;
		
		private static var _instance:CellFactory;
		static private var colorTransform:ColorTransform;
		
		
		public function CellFactory() {
			cells = new Array();
			max = 0;
		}
		
		public static function getCell():Cell {
			var cell:Cell;
			if (instance.max > 0) {
				instance.max--;
				cell = instance.cells.pop();
			} else {
				cell = new Cell();
				colorTransform = cell.transform.colorTransform;
			}
			return cell;
		}
		
		public static function get instance():CellFactory 
		{
			if (_instance == null) {
				_instance = new CellFactory();
			}
			return _instance;
		}
		
		public function get cells():Array 
		{
			return _cells;
		}
		
		public function set cells(value:Array):void 
		{
			_cells = value;
		}
		
		public function get max():uint 
		{
			return _max;
		}
		
		public function set max(value:uint):void 
		{
			_max = value;
		}
		
		public static function dispose(cell:Cell):void {
			cell.transform.colorTransform = colorTransform;
			instance.cells.push(cell);
			instance.max++;
		}
		
	}

}