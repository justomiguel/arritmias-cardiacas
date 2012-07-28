package com.jmv.sbejeweled._game_._board_.chips
{
	import com.jmv.framework.utils.ArrayUtil;
	import com.jmv.framework.utils.ObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_._board_.powerups.*;
	
	
	 
	public class ChipFactory
	{
		private static var NEED_SUB_TYPE:Array = [
		                                         	PowerUp.DESTROY_COLOR,
		                                         ];
		
		
		
		public static function createRandomStandard():AbstractChip
		{
			trace( "createRandomStandard : " + createRandomStandard );
			var type:String = ArrayUtil.choice(StandardChip.COLORS.slice()) as String;
			return create(type);
		}
		
		public static function createWeightedRandom( odds:Object, subodds:Object = null ):AbstractChip
		{
				
			
			var subType:String = null;
			if (ArrayUtil.contains(NEED_SUB_TYPE, type))
				subType = ArrayUtil.choiceWithProbability(ObjectUtil.keys( subodds ),ObjectUtil.values( subodds)) as String;
			var type:String ;
	
			type = ArrayUtil.choiceWithProbability(ObjectUtil.keys( odds ), ObjectUtil.values( odds)) as String;
			
			var chip:AbstractChip = create( type, subType );
			
			if (!chip){

			
				chip = create( "tinker", null )
			}
			return chip;
		}

		public static function create(type:String, subtype:String = null):AbstractChip
		{
			
			switch(type)
			{
//				STANDARD CHIPS:

				case StandardChip.LIGHT:
					return new ChipYellow() as AbstractChip;
					break;
				case StandardChip.WATER:
					return new ChipBlue() as AbstractChip;
					break;
				case StandardChip.TINKER:
					return new ChipGreen() as AbstractChip;
					break;
				case StandardChip.GARDEN:
					return new ChipRed() as AbstractChip;
					break;
				case StandardChip.ANIMAL:
					return new ChipOrange() as AbstractChip;
					break;
					
//				SPECIAL POWER UPS:
				
				case PowerUp.DESTROY_COLOR:
					//trace( "ChipFactory.create > type : " + type + ", subtype : " + subtype );
					//return createDestroyColor(subtype);
					return new DestroyRandom();
					break;
				case PowerUp.DESTROY_RANDOM:
					//trace( "ChipFactory.create > type : " + type + ", subtype : " + subtype );
					return new DestroyRandom();
					break;
			}
			return null;
		}
		
		private static function createDestroyColor(color:String):AbstractChip
		{
			//trace( "createDestroyColor : " + createDestroyColor );
			switch (color)
			{
				case StandardChip.LIGHT:
					return new DestroyYellow() as AbstractChip;
					break;
				case StandardChip.WATER:
					return new DestroyBlue() as AbstractChip;
					break;
				case StandardChip.TINKER:
					return new DestroyGreen() as AbstractChip;
					break;
				case StandardChip.GARDEN:
					return new DestroyRed() as AbstractChip;
					break;
				case StandardChip.ANIMAL:
					return new DestroyOrange() as AbstractChip;
					break;
			}
			return null;
		}
		
		
	}
}