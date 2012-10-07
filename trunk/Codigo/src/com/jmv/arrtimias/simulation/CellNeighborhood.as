package com.jmv.arrtimias.simulation 
{
	/**
	 * ...
	 * @author matix
	 */
	public class CellNeighborhood 
	{
		
		private var p_cells:Object;
		
		public function CellNeighborhood(cells:Object) 
		{
			this.p_cells = cells;
		}
		
		public function get topLeft():Cell {
			return p_cells["topLeft"] as Cell;
		}
		public function get top():Cell {
			return p_cells["top"]  as Cell;
		}
		public function get topRight():Cell {
			return p_cells["topRight"]  as Cell;
		}
		public function get bottomLeft():Cell {
			return p_cells["bottomLeft"]  as Cell;
		}
		public function get bottom():Cell {
			return p_cells["bottom"]  as Cell;
		}
		public function get bottomRight():Cell {
			return p_cells["bottomRight"]  as Cell;
		}	
		public function get left():Cell {
			return p_cells["left"]  as Cell;
		}
		public function get right():Cell {
			return p_cells["right"]  as Cell;
		}
		
		public function getCell(position:String):Cell {
			return p_cells[position] as Cell;
		}
	}

}