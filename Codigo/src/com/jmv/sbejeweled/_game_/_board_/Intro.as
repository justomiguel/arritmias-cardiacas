package com.jmv.sbejeweled._game_._board_
{
	import com.jmv.framework.core.SSprite;
	import com.jmv.framework.easing.Linear;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.tween.STween;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.effects.Glow;
	import com.jmv.sbejeweled.settings;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import flash.events.Event;
	
	
	
	public class Intro extends SSprite
	{
		private var board:Board;
		//private var tasks:TaskRunner;
		
		private var tilesInited:Object;		
		private var ticker:Timer;
				
		private var glows:Array;
		private var glowTicker:Timer;
		
		private var glowTick:int = 200;
		private var glowRow:int = Board.ROWS-1;
		
		
		public function Intro(_board:Board)
		{
			super();
			this.board = _board;
			//this.tasks = board.tasks;			
		}
		
		public function init(text:String = null):void
		{
			this.tilesInited = {};
			
			for each (var tile:Tile in this.board.tiles)
			{
				this.tilesInited[tile.row+"_"+tile.col] = false;
			}			
			
			this.ticker = new Timer(1000 / App.I().FRAMERATE);
			this.ticker.addEventListener(TimerEvent.TIMER, this.update);
			ticker.start();
			
			this.glows = [];
			this.glowTicker = new Timer(this.glowTick);
			this.glowTicker.addEventListener(TimerEvent.TIMER,  this.initGlow);
			glowTicker.start();
			
			//this.tasks.add(this.glowTicker);
			//this.tasks.add(this.ticker);
			
			var goal:Object = settings.getGoal
			if (text) this.board.dispatchEvent( new SEvent(Board.SHOW_POPUP, text) );
			
		}
		
		public override function dispose():void
		{
			if (this.glowTicker)
			{
				this.glowTicker.stop();
				this.glowTicker.removeEventListener(TimerEvent.TIMER, initGlow);
				//this.tasks.remove(this.glowTicker);
				this.glowTicker = null;
			}
			if (this.ticker)
			{
				this.ticker.stop();
				this.ticker.removeEventListener(TimerEvent.TIMER, update);
				//this.tasks.remove(this.ticker);
				this.ticker = null;
			}
			this.glows = null;
			this.board = null;
			//this.tasks = null;
			this.tilesInited = null;
		}
		
		private function update(e:TimerEvent):void
		{
			for each (var glowData:Object in this.glows)
			{
				var glow:Glow = glowData.glow;
				var initTile:Tile = glowData.initTile;  
				var endTile:Tile = glowData.endTile;
				var boardwidth:Number = initTile.width * Board.COLS-1;
				var currCol:int = Linear.lerp(glow.x, initTile.getChipX(), Board.COLS-1, initTile.width*.5, 0);
				this.initTiles(initTile.row, currCol); 
			}
		}
		
		private function initTiles(row:int, upToCol:int):void
		{
			for (var c:int = Board.COLS-1; c >= upToCol; c--)
			{
				this.initTile(row, c);				
			}
		}
		
		private function initTile(row:int, col:int):void
		{
			if (this.tilesInited[row+"_"+col]) return;			
			
			var tile:Tile = this.board.tileAt(row, col);
			
			//this.tasks.add(new Sequence(
					//new Tween(
						//tile.currentChip, 1000,
						//{ alpha: 1 },
						//{ transition: 'easeout' }
					//),
					//new Func(this.onTileInitComplete, tile)
				//)
			//);
			
			STween.to(tile.currentChip, 3, { alpha: 1 , transition:"circeaseout", onComplete:onTileInitComplete, onCompleteParams:[tile] } );

			this.tilesInited[row+"_"+col] = true;
		}
		
		private function initGlow(e:TimerEvent):void
		{
			var initTile:Tile = this.board.tileAt(this.glowRow, Board.COLS-1);
			var endTile:Tile = this.board.tileAt(this.glowRow, 0);
			
			var glow:Glow = new Glow();
			this.glows.push( { glow:glow, initTile:initTile, endTile:endTile } );
			
			this.board.addEffect(glow, initTile.getChipX(), initTile.getChipY());
			
			glow.alpha = 0;
			glow.scaleX = glow.scaleY = 0;
			
			//this.tasks.add(new Tween(
					//glow, 100,
					//{ alpha: 1, scaleX: 1, scaleY: 1 },
					//{ transition: 'easeout' }
				//)
			//);
			
			STween.to(glow, 0.1, {  alpha: 1, scaleX: 1, scaleY: 1, transition:"circeaseout"} );
			
			//this.tasks.add(new Sequence(
					//new Tween(
						//glow, 1500,
						//{ x: endTile.getChipX() },
						//{ transition: 'easeinout' }
					//),
					//new Tween(
						//glow, 200,
						//{ alpha: 0, scaleX: 0, scaleY: 0 },
						//{ transition: 'easeout' }
					//),
					//new Func(this.onGlowTweenComplete, glow, this.glowRow)
				//)
			//);
			
			STween.to(glow, 1.5, {  x: endTile.getChipX() ,transition:"circeaseout", onComplete:function():void { STween.to(glow, 0.1, {  alpha: 0, scaleX: 0, scaleY: 0 ,transition:"circeaseout", onComplete:onGlowTweenComplete, onCompleteParams:[glow, glowRow] }) }} );
			
			if (this.glowRow == 0)
			{
				if (this.glowTicker)
				{
					this.glowTicker.stop();
					this.glowTicker.removeEventListener(TimerEvent.TIMER, initGlow);
					//this.tasks.remove(this.glowTicker);
					this.glowTicker = null;
				}				
			}
			else
			{
				this.glowRow--;
			}
		}
		
		private function onGlowTweenComplete(glow:Glow, row:int):void
		{
			glow.dispose();
		}
		
		private function onTileInitComplete(tile:Tile):void
		{
			if (tile.col == 0 && tile.row == 0)
			{
				this.dispatchEvent(new Event(Event.COMPLETE));
				this.dispose();
			}
		}		
	}
}

