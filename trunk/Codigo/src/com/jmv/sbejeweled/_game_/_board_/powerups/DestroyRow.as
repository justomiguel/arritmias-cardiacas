package com.jmv.sbejeweled._game_._board_.powerups
{
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	
	
	
	public class DestroyRow extends PowerUp
	{
		public function DestroyRow()
		{
			trace( "DestroyRow : " + DestroyRow );
			super();
			this._score = 50;
			this.type = PowerUp.DESTROY_ROW;
			this._powerUpCount = 1;
		}
		
		protected override function secretTilesToRemove(myTile:Tile, board:Board):Array
		{
			return this.getAvailableTiles(board, myTile, [1,-1], [0,0] ).concat(myTile);
		}
		
	}
}