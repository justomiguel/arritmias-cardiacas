package com.jmv.sbejeweled._game_._board_.powerups
{
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	import com.jmv.sbejeweled._game_._board_.chips.AbstractChip;
	
	
	
	public class DestroyColor extends PowerUp
	{
		private var _color:String;
		
		public function DestroyColor(color:String)
		{
			super();
			this.type = PowerUp.DESTROY_COLOR;
			this._color = color;
		}
		
		protected override function secretTilesToRemove(myTile:Tile, board:Board):Array
		{
			return board.tiles.filter( this.colorFilter ).concat(myTile);
		}
		
		private function colorFilter(tile:*, index:int = 0, array:Array = null):Boolean
		{
			return (tile.currentChip && AbstractChip(tile.currentChip).getType() == this._color);
		}
	}
}