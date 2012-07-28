package com.jmv.sbejeweled._game_._board_
{
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.ArrayUtil;
	import com.jmv.sbejeweled._game_._board_.chips.AbstractChip;
	import com.jmv.sbejeweled._game_._board_.powerups.PowerUp;
	import com.jmv.sbejeweled._game_.players.Swap;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	
	
	public class Shuffler
	{
		private var chipsCopy:Array;
		private var searchIndex:int;
		
		private var randomTiles:Array;
		private var randomChips:Array;
		private var chipsUsed:Array;
		private var chipDestiny:Object; 
		private var ammount:int;
		private var board:Board;
		private var goodSwap:Swap;
		private var hintCycle:int = 0;
		
		public var id:uint;
		
		public function Shuffler(_board:Board)
		{
			this.board = _board;
			this.chipsCopy = [];
			this.searchIndex = 0;
			id = setInterval(this.checkForMoves, 5000);
			//this.board.tasks.setInterval(this.checkForMoves, 5000);
		}
		
		private function checkForMoves():void
		{
			if (!board.isStandBy()) return;
			this.hasBoardChanged();
			if (this.searchIndex < 0)
			{
				this.hintCycle++;
				if (this.hintCycle == 15)
				{
					this.hintCycle = 0;
					
					this.goodSwap.tile1.rollOverTile();
					//this.board.tasks.setTimeout( this.goodSwap.tile2.rollOverTile, 250);
					setTimeout( this.goodSwap.tile2.rollOverTile, 250);
					setTimeout( this.goodSwap.tile1.rollOverTile, 500);
					//this.board.tasks.setTimeout( this.goodSwap.tile1.rollOverTile, 500);
				}
				return;
			}
			
			if (this.hasPossibleMatch( this.board.tiles[this.searchIndex] as Tile ))
			{
				this.searchIndex = -1;
				return;
			}
			
			
			this.searchIndex++
			if (this.searchIndex == Board.COLS*Board.ROWS)
			{
				this.searchIndex = 0;
			}
		}
		
		private function areTheSame(tile:Tile, other:Tile):Boolean
		{
			return (other && other.currentChip && other.currentChip.getType() == tile.currentChip.getType());
		}
		
		private function checkParallelMatch(tile:Tile, dx:int, dy:int):Boolean
		{
			for (var i:int = 2; i<4; i++)
				if (!this.areTheSame(tile, this.board.tileAt( tile.row + i*dx, tile.col + i*dy )))
					return false;
			return true;
		}
		
		private function checkPerpMatch(tile:Tile, dx:int, dy:int):Boolean
		{
			var oldValue:int = 0;
			var newValue:int;
			for each (var i:int in [-2,-1,1,2])
			{
				newValue = this.areTheSame(tile, this.board.tileAt(tile.row + dx + dy*i, tile.col + dy + dx*i))?1:0;
				if (newValue*oldValue == 1) return true;
				if (i==1 && newValue==0) return false;
				oldValue = newValue;
			}
			return false;
		}
		
		
		
		private function hasPossibleMatch(tile:Tile):Boolean
		{
			if (!this.board.hasColorChip(tile) && !this.board.hasPowerUp(tile)) return false;
			
			var deltaxs:Array = [1,-1,0, 0];
			var deltays:Array = [0, 0,1,-1];
			var nextTile:Tile;
			
			for (var i:int = 0; i<4; i++)
			{
				nextTile = this.board.tileAt(tile.row + deltaxs[i], tile.col + deltays[i]);
				if (nextTile && nextTile.currentChip && nextTile.currentChip.isSwappealble())
				{
					if (tile.currentChip is PowerUp) return true;
					this.goodSwap = new Swap(tile, nextTile);
				}
				else
				{
					continue;
				}
				if (this.checkParallelMatch(tile, deltaxs[i], deltays[i]) ||
				    this.checkPerpMatch(tile, deltaxs[i], deltays[i]))
				{
					this.goodSwap = new Swap(tile, board.tileAt(tile.row + deltaxs[i], tile.col + deltays[i]));   
					return true;
				}
			}
			
			return false;
		}
		
		private function hasBoardChanged():void
		{
			var i:int = 0;
			for each (var tile:Tile in this.board.tiles)
			{
				if (tile.currentChip != this.chipsCopy[i])
				{
					this.chipsCopy[i] = tile.currentChip; 
					this.searchIndex = 0;
				}
				i++;
			}
			
		}
		
		public function noMoreMoves(time:int, nextFunction:Function):void
		{
			this.randomChips = [];
			for each (var tile:Tile in this.board.tiles)
				this.randomChips.push( tile.currentChip );
			
			this.randomChips = ArrayUtil.shuffle(this.randomChips);
			
			var chip:AbstractChip;
			//var p:Parallel = new Parallel();
			for (var i:int = 0; i<this.board.tiles.length ;i++)
			{
				tile = this.board.tiles[i];
				chip = this.randomChips[i] as AbstractChip;
				//p.add(
						//new Sequence(
				                       //new Tween(chip, time, {x:tile.getChipX(), y:tile.getChipY()}),
				                       //new Func(tile.setChip, chip)
				                    //)
				      //);
				STween.to(chip, time/1000, { x:tile.getChipX(), y:tile.getChipY(), onComplete:function():void {
					STween.to(this, 0.01, { onStart:tile.setChip, onStartParams:[chip], onComplete:nextFunction} )
					}})
				tile.setChip();		
			}
		}
		
		public function shuffle(_ammount:int, time:int, nextFUnction:Function):void
		{
			var tiles:Array = board.tiles.filter( board.hasColorChip ); 
			this.randomTiles = [];
			this.randomChips = [];
			this.chipsUsed = [];
			this.chipDestiny = {};
			this.ammount = _ammount;
			
			var tile:Tile;
			for (var i:int = 0; i<this.ammount && tiles.length>0; i++)
			{
				tile = ArrayUtil.popChoice(tiles) as Tile;
				this.randomTiles.push( tile );
				this.randomChips.push( tile.currentChip );
				chipsUsed.push( false );
			}
			this.randomChips = ArrayUtil.shuffle(this.randomChips);
			//var p:Parallel = new Parallel();
			if (!this.putNewChipInTile(0)){
//				TODO: do something else
				return ;
			}
			
			var chip:AbstractChip;
			for each (tile in this.randomTiles)
			{
				chip = this.chipDestiny[tile.toString()] as AbstractChip;
				//s = new Sequence(
				                   //new Tween(chip, time, {x:tile.getChipX(), y:tile.getChipY()}),
				                   //new Func(tile.setChip, chip)
				                 //);
				STween.to(chip, time/1000, { x:tile.getChipX(), y:tile.getChipY(), onComplete:function():void {
					STween.to(this, 0.01, { onStart:tile.setChip, onStartParams:[chip], onComplete:nextFUnction} )
					}})
				tile.setChip();		
				//p.add(s);
			}
			//return p;
		}
		
		private function putNewChipInTile(tileIndex:int):Boolean
		{
			if (tileIndex == this.randomTiles.length) return true;
			var tile:Tile = this.randomTiles[tileIndex] as Tile;
			var chip:AbstractChip;
			
			for (var i:int = 0; i<this.randomChips.length; i++)
			{
				if (chipsUsed[i]) continue;
				
				chip = this.randomChips[i] as AbstractChip;
				chipDestiny[tile.toString()] = chip;
				if (this.checkRandomizedPosition(tile))
				{
					chipsUsed[i] = true;
					if (this.putNewChipInTile(tileIndex + 1)) return true;
					chipsUsed[i] = false;
				}
			}
			delete chipDestiny[tile.toString()]; 
			return false;
		}
		
		private function checkRandomizedPosition(tile:Tile):Boolean
		{
			var type:String = AbstractChip(this.chipDestiny[tile.toString()]).getType();
			
			return ( this.checkRandomizedDirection(type, tile,  0,  1) ||
			         this.checkRandomizedDirection(type, tile,  1,  0) ||
			         this.checkRandomizedDirection(type, tile,  0, -1) ||
			         this.checkRandomizedDirection(type, tile, -1,  0)    );
		}
		
		private function checkRandomizedDirection(type:String, tile:Tile, deltax:int, deltay:int):Boolean
		{
			
			for (var i:int = 1; i<3; i++)
			{
				var nextTile:Tile = board.tileAt(tile.row + deltay*i, tile.col + deltax*i);
				if (!nextTile) return true; 
				if (this.chipDestiny[nextTile.toString()])
				{
					if (AbstractChip(this.chipDestiny[nextTile.toString()]).getType() != type) return true;
				}
				else if (nextTile.currentChip)
				{
					if (nextTile.currentChip.getType() != type) return true; 
				}
				else return true;
			}
			return false;
		}
		
		public function dispose():void
		{
			trace("dispose sufller");
			clearInterval(id);
			this.goodSwap = null;
			this.chipsCopy = null;
			this.randomChips = null;
			this.randomTiles = null;
			this.chipDestiny = null;
			this.chipsUsed = null;
		}

	}
}
