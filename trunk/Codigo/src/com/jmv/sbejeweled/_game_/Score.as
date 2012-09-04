package com.jmv.sbejeweled._game_
{
	import com.jmv.sbejeweled.App;
	
	
	
	public class Score
	{
		public var points:int;
		public var _tokens:int;
		public var tokensAcum:int; 
		public var matches:int;
		public var totalScore:int;
		public var name:String;
		
		
		
		public var levelsWon:int;
		
		
		public function Score(name:String)
		{
			this.name = name;
			
			this.tokensAcum = 0; 
			this.points = 0;
			this.tokens = 0;
			this.levelsWon = 0;
			
			this.matches = 0;
			
			//App.I().swfs["sismo"].score();
			//this.totalScore = 0;	
			//App.I().danone = new Array(0, 0);
		}
		
		public function sum(dif:int):void
		{
			//App.I().swfs["sismo"].sum(dif);	
		}
		
		public function get totScore():int {

			//return App.I().swfs["sismo"].totScore;
			return 0

		}
		
		public function endLevel():void
		{
			this.points = 0;
			this.matches = 0;
			this.tokens = 0;
		}
		
		public function set tokens(value:int):void { 
				
			_tokens = value;		
			tokensAcum += value;	
			
		}
		public function get tokens():int {
			
			return _tokens;
		}
	}
}