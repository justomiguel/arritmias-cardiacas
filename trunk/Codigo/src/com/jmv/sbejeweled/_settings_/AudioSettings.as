package com.jmv.sbejeweled._settings_
{
	
	
	
	public class AudioSettings
	{
		public var music:Array;
		public var sfx:Array;
		
		public function AudioSettings()
		{
			this.music =
			[
				"music/menu",
				"music/ingame"
			];
			
			this.sfx = 
			[
				"sfx/level_start",
				"sfx/match_wrong",
				"sfx/match1",
				"sfx/match2",
				"sfx/match3",
				"sfx/match4",
				"sfx/match5",
				//"sfx/match6",
				"sfx/powerup_explosion",
				"sfx/tokens_fall",
				"sfx/tokens_select",
				"sfx/mouse_over",
				"sfx/mouse_click",
				"sfx/Clock_Counter_V2"
			];
		}
		
		public function dispose():void
		{
			this.music = null;
			this.sfx = null;
		}
	}
}