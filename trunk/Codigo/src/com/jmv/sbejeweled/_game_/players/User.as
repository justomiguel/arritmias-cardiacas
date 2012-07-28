package com.jmv.sbejeweled._game_.players
{
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.BoardLayer;
	import com.jmv.sbejeweled._game_._board_.Tile;
	
	import flash.events.MouseEvent;
	
	
	
	public class User extends AbstractPlayer
	{		
		private var lastTile:Tile;
		private var mouseDown:Boolean;
		
		public function User(_id:String)
		{
			super(_id);
		}
		
		private function clickOnTile(ev:MouseEvent):void
		{
			this.mouseDown = true;
			this.lastTile = ev.currentTarget as Tile
			this.board.clickOnTile( this.lastTile );
		}
		
		public override function setBoard(b:Board, othersPlayer:AbstractPlayer = null):void
		{
			super.setBoard(b, othersPlayer);
			this.addListeners();
		}
		
		public override function endLevel():void
		{
			this.removeListeners();
			super.endLevel(); 
		}
		
	
		

	
		

		
		private function addListeners():void
		{
			this.board.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp, false, 0 , true );
			for each (var tile:Tile in this.board.tiles)
			{
				tile.addEventListener(MouseEvent.MOUSE_DOWN, this.clickOnTile, false, 0 , true );
				tile.addEventListener(MouseEvent.ROLL_OVER, this.rollOverTile, false, 0, true );
			}
		}
		
		private function onMouseUp(ev:MouseEvent):void
		{
			this.mouseDown = false;
			this.lastTile = null;
		}
		
		private function rollOverTile(ev:MouseEvent):void
		{
			var tile:Tile = ev.currentTarget as Tile;
			if (this.mouseDown && tile != this.lastTile)
			{
				this.mouseDown = false;
				this.board.clickOnTile( tile );
			} else {
				tile.rollOverTile();
			}
			
		}
		
		private function removeListeners():void
		{
			if (this.board){
				this.board.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
				for each (var tile:Tile in this.board.tiles)
				{
					tile.removeEventListener(MouseEvent.ROLL_OVER, this.rollOverTile);
					tile.removeEventListener(MouseEvent.MOUSE_DOWN, this.clickOnTile)
				}
			}
		}
		
		public override function dispose():void
		{
			this.lastTile = null;
			this.removeListeners();
			super.dispose();
		}
		
	}
}