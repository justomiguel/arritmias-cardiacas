package com.jmv.sbejeweled._game_.effects
{
	import com.jmv.framework.utils.AbstractMethodError;
	import com.jmv.sbejeweled._game_._board_.chips.AbstractChip;
	
	
	
	public class CoverChip extends AbstractChip
	{
		public function CoverChip()
		{
			super();
		}
		
		public override function addCoverChip():void
		{
			throw new AbstractMethodError("");
		}
		
		public override function removeCoverChip():void
		{
			throw new AbstractMethodError("");
		}
	}
}