package com.jmv.sbejeweled._game_._board_
{
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled._game_._board_.chips.AbstractChip;

	
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	
	public class Tile extends MovieClip
	{
		private var _row:int;
		private var _col:int;
		private var _currentChip:AbstractChip;
		private var _board:Board
		
		public function Tile(board:Board, row_:int, col_:int)
		{
			super();
			this._board = board;
			this._row = row_;
			this._col = col_;
			this.x = this.width * col;
			this.y = this.height * row;
		}
		
		
		
		public function setChip(abstractChip:AbstractChip = null):void
		{
			if (!abstractChip){
				this._currentChip = null;
				return;
			}
			
			this._currentChip = abstractChip;
			this._currentChip.x = this.getChipX();
			this._currentChip.y = this.getChipY();
		}
		
		public function get board():Board
		{
			return this._board;
		}
		
		public function getChipY():Number
		{
			return this.y + this.height*.5;
		}
		
		public function getChipX():Number
		{
			return this.x + this.width*.5;
		}
		
		public function get currentChip():AbstractChip
		{
			return this._currentChip;
		}
		
		public function get col():int
		{
			return this._col;
		}
		public function get row():int
		{
			return this._row;
		}
		
		public function rollOverTile(ev:MouseEvent = null):void
		{
			if (this._currentChip && this._currentChip.state != 'selected')
			{
				this._currentChip.setState('stable');
				this._currentChip.setState('rollover');
			}
		}
		
		public override function toString():String
		{
			return 'tile object col: ' + this.col + ' row: '+ this.row + '.'
		}
		
		public function dispose():void
		{
			if (this._currentChip) this._currentChip.dispose();
			this._currentChip = null;
			DisplayObjectUtil.dispose( this );
		}
	}
}
