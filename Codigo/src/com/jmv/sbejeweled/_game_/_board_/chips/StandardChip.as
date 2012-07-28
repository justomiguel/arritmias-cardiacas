package com.jmv.sbejeweled._game_._board_.chips
{
	
	
	public class StandardChip extends AbstractChip
	{		
		public static const LIGHT:String = 'light';
		public static const GARDEN:String = 'garden';
		public static const TINKER:String = 'tinker';
		public static const WATER:String = 'water';
		public static const ANIMAL:String = 'animal';
		
		public static const COLORS:Array = [LIGHT, GARDEN, TINKER, WATER, ANIMAL];
		
		public function StandardChip()
		{
			super();
			this._swappeable = true;
			this._destroyable = true;
		}
	}
}