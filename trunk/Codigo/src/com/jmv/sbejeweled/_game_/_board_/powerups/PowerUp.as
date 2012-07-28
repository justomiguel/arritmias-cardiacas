package com.jmv.sbejeweled._game_._board_.powerups
{
	import com.jmv.framework.utils.AbstractMethodError;
	import com.jmv.framework.utils.assert;
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	import com.jmv.sbejeweled._game_._board_.chips.AbstractChip;

	
	
	
	public class PowerUp extends AbstractChip
	{
		public static const DESTROY_ROW:String = 'destroy_row';
		public static const DESTROY_ROW_COL:String = 'destroy_row_col';
		public static const DESTROY_RANDOM:String = 'destroy_random';
		public static const DESTROY_COLOR:String = 'destroy_color';
		
		
		protected var _activated:Boolean;
		protected var _powerUpCount:int = 0;
		protected var _soundEffect:String;
		protected var _score:int;
		
		public function PowerUp()
		{
			this._swappeable = true;
			this._destroyable = true;
			this._activated = false;
			this._score = 250;
			this._soundEffect = 'powerup_explosion';
		}
		
		public function get score():int
		{
			return this._score;
		}
		
		public function get powerUpCount():int
		{
			return this._powerUpCount;
		}
		
		public function activate(neighbour:String = null):void
		{
			this._activated = true;
		}
		
		public function get activated():Boolean
		{
			return this._activated;
		}
		
		public function doStuff(myTile:Tile, board:Board):Array
		{
			if (!this._activated) return [];
			assert(myTile.currentChip == this, 'my tile has a chip which is not this power up... abs!' )
			
			board.dispatch(Board.PLAY_SFX, this._soundEffect);
			
			return secretTilesToRemove(myTile, board);
		}
		
		protected function secretTilesToRemove(myTile:Tile, board:Board):Array
		{
			throw new AbstractMethodError("");
			return [];
		}
		
		public function getTilesToRemove(myTile:Tile, board:Board):Array
		{
			return this.secretTilesToRemove(myTile, board);
		}
		
		protected function getAvailableTiles(board:Board, centralTile:Tile, deltaxs:Array, deltays:Array):Array
		{
			var length:int, deltax:int, deltay:int;
			var nextTile:Tile;
			var ans:Array = [];
			
			while(deltaxs.length > 0 && deltays.length > 0)
			{
				deltax = deltaxs.pop() as int;
				deltay = deltays.pop() as int;
				length = 0;
				
				do{ length++;
					nextTile = board.tileAt( centralTile.row + deltay*length, centralTile.col + deltax*length);
					ans.push( nextTile );
				} while (nextTile && 
				         nextTile.currentChip && 
				         nextTile.currentChip.isDestroyable() );
				ans.pop();
			}
			return ans;
		}

	}
}