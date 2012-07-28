package com.jmv.sbejeweled._game_.players
{
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.Score;
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.BoardLayer;
	import com.jmv.sbejeweled._game_._board_.Tile;
	//import com.jmv.sbejeweled._game_._board_.chips.spellchips.SpellChip;
	import com.jmv.sbejeweled._game_._board_.powerups.PowerUp;

	
	
	
	
	
	public class AbstractPlayer
	{
		public static const FAIRY:String = "fairy";
		//public static const MAX:String = "max";
		//public static const ALEX:String = "alex";
		
		//public static var PLAYERS_IDS:Array = [ALEX,MAX];
		
		private var _id:String;
		
		internal var board:Board;
		//protected var spells:Array;
		//protected var otherPlayer:AbstractPlayer;
		
		
		public var score:Score;		
		public var scoreAnimal:Score; 
		
		private var _gameStatus:String;
		
		public function AbstractPlayer(_id:String)
		{
			this._id = _id;
			
			this.score = new Score("main"); 
			this.scoreAnimal = new Score("Animal"); 
			
		}
		
		
		
		public function setBoard(b:Board, othersPlayer:AbstractPlayer = null):void
		{
			this.board = b;
			this.board.player = this;
		}
		
		public function endLevel():void
		{
			this.board = null;
			this.score.endLevel();
		}
		
	
		
		public function get id():String
		{
			return this._id
		}
		
		public function get gameStatus():String { return _gameStatus; }
		
		public function set gameStatus(value:String):void 
		{
			_gameStatus = value;
		}
		
		public function dispose():void
		{
			this.board = null;
			this.score = null;
			
		}

		public function getOrderedScores(game:Game):Array {
			
			var scores:Array = new Array();
			
			scores.push(game.user.scoreAnimal);
			scores.sortOn("tokensAcum", Array.NUMERIC | Array.DESCENDING);
			
			
			
			return scores;
			
		}
		
			public function getTokensOrderedScores(game:Game):Array {
			
			var scores:Array = new Array();
			
			scores.push(game.user.scoreAnimal);
			
			scores.sortOn("tokens", Array.NUMERIC | Array.DESCENDING);
			
			return scores;
			
		}
		
	}
}