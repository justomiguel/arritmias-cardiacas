package com.jmv.sbejeweled._game_.effects.textfx
{
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_.effects.AbstractEffect;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled._game_.players.User;
	//import com.jmv.sbejeweled._game_.spells.AbstractSpell;
	import com.jmv.sbejeweled.settings;
	
	import flash.display.MovieClip;

	
	
	
	public class AISpellDialog extends AbstractEffect
	{
		public var textfield:MovieClip;
		
		public function AISpellDialog(player:AbstractPlayer, spell:AbstractSpell)
		{
			super(true);
			
			var playerid:String = player is User ? "user" : "ai";
			var text:String = settings.getAiSpellDialogText(playerid+"_casts_"+spell.id);
			
			this.textfield.label.text = text;
		}		
	}
}