package com.jmv.sbejeweled._game_.players
{
	import com.jmv.sbejeweled._game_._board_.Tile;
	
	
	
	public class Swap
	{
		private var _tile1:Tile;
		private var _tile2:Tile;
		private var _horizontal:Boolean;
		private var _valid:Boolean;
		public var rating:Number;
		
		public function Swap(tilee1:Tile, tilee2:Tile)
		{
			//COMENT: this doesnt check that tiles are actually neighbours
			this._tile1 = tilee1;
			this._tile2 = tilee2;
			this._horizontal = (this._tile1.row == this._tile2.row);
			this._valid = false;
			if (this._tile1.currentChip && this._tile1.currentChip.isSwappealble()
				&& this._tile2.currentChip && this._tile2.currentChip.isSwappealble()
					&& this._tile1.currentChip.getType() != this._tile2.currentChip.getType())
					this._valid = true; 
		}
		
		public function get valid():Boolean
		{
			return this._valid;
		}
		
		public function get tile1():Tile
		{
			return this._tile1;
		}
		
		public function get tile2():Tile
		{
			return this._tile2;
		}
		
		public function get horizontal():Boolean
		{
			return this._horizontal;
		}
		
		public function get vertical():Boolean
		{
			return !this._horizontal;
		}
		
		public function toString():String
		{
			return 'Swap Obj: tile1=' + this._tile1.toString() + ' tile2=' + this._tile2.toString();
		}

	}
}