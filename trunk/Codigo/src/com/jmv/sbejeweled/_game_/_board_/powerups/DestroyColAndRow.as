package com.jmv.sbejeweled._game_._board_.powerups
{
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	
	
	
	public class DestroyColAndRow extends PowerUp
	{
		public function DestroyColAndRow()
		{
			trace( "DestroyColAndRow.DestroyColAndRow" );
			super();
			this.type = PowerUp.DESTROY_ROW_COL;
			this._powerUpCount = 2;
			this._score = 100;
		}
		
		protected override function secretTilesToRemove(myTile:Tile, board:Board):Array
		{
			return this.getAvailableTiles(board, myTile,  [1,-1,0,0], [0,0,1,-1] ).concat(myTile);
		}
		
	}
}