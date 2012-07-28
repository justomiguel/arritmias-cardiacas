package com.jmv.sbejeweled._game_._board_.powerups
{
	import com.jmv.framework.utils.ArrayUtil;
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	
	
	
	public class DestroyRandom extends PowerUp
	{
		public static var AMMOUNT:int = 8;
		
		public function DestroyRandom()
		{
			super();
		}
		
		protected override function secretTilesToRemove(myTile:Tile, board:Board):Array
		{
			var ans:Array = [];
			var tiles:Array = board.tiles.concat();
			var tile:Tile;
			for (var i:int = 0; i<AMMOUNT; i++)
			{
				tile = ArrayUtil.popChoice( tiles ) as Tile;
				if (tile.currentChip) ans.push( tile );
			}
			ArrayUtil.addUnique(ans, myTile);
			return ans;
		}
		
		public override function getTilesToRemove(myTile:Tile, board:Board):Array
		{
			return [];
		}
	}
}