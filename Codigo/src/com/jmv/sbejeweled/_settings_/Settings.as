package com.jmv.sbejeweled._settings_
{
	import com.jmv.framework.math.SMath;
	
	
	
	public class Settings
	{
		private var data:XML;
		public var duel:Object;
		
		public function Settings(data:XML)
		{
			this.data = data;
			this.init();			
		}
		
		private function init():void
		{
			this.duel = 
			{
				cantLevelsPerDuel: this.data.duel.cantLevelsPerDuel.@value
			};
		}
		
		
		public function getTextFieldText(_name:String):String
		{
			return this.data.texts.textfield.(@name == _name);
		}
		
		public function getButtonText(name:String):String
		{
			return this.data.texts.button.(@name == name.split('_')[1]);
		}
		
		public function getIngameText(name:String):String
		{
			var list:XMLList = this.data.texts.ingame.(@name == name);
			if (list.length()==1)
				return list;
			else if (list.length()>1)
				return list[SMath.randint(0,list.length()-1)];
				
			return null;
		}
		
		public function getFortuneText(name:String):String
		{
			
			return this.data.texts.fortunes.ingame.(@name == name);
			
		}
		
			public function getFinalScoreText(text:String):String
		{
			
			return this.data.texts.fortunes.score.(@text == text);
			
		}
		
		public function getFinalLinkText(text:String):String
		{
			
			return this.data.texts.fortunes.link.(@text == text);
			
		}
		
			public function getFinalLinkURL(url:String):String
		{
			
			return this.data.texts.fortunes.link1.(@url == url);
			
		}
		public function getLinkDescription(name:String):String
		{
			return this.data.texts.fortunes.link_description.(@text == name);
		}
		
		public function  getCantTotalScoreText():int
		{
			return this.data.texts.fortunes.score.@text.length();
		}
		
		public function getCantTotalFortunes(talent:String = ""):int
		{
			return this.data.texts.fortunes.ingame.((@name.toString()).indexOf(talent) != -1).length();
		}
		
		
		public function getGoal(level:int):Object
		{
			var objective:Object = {}
			for each ( var goal:XML in this.data.levels.level.(@id == level.toString()).objective.* )
			{
				objective[goal.name().toString()] = parseInt(goal.toString());
			}
			return objective;
		}
		
		public function getGoalTokens():Object{
			var objective:Object = { }
			
				for each ( var goal:XML in this.data.levels.talentobjective.* ){
					objective[goal.name().toString()] = parseInt(goal.toString());
				}
			return objective;
		}
		
		public function getMaxSettingsPerLevel(level:int):Object
		{
			var resp:Object = {}
			for each ( var sett:XML in this.data.levels.level.(@id == level.toString()).settings.* )
			{
				resp[sett.name().toString()] = parseInt(sett.toString());
			}
			
			return resp;
		}
		
		public function getCantLevels():int {
			return this.data.levels.level.length();
		}
		
		public function getPlayerData(player:String, level:int):Object
		{
			var node:XML = this.data.levels.level.(@id == level.toString())[player][0];
			
			var answer:Object = {
									mentalspeed:parseInt(node.mentalspeed.toString()),
									moveodds:{},
									colorodds:{},
									powerups: {}
								};
			for each ( var moveodd:XML in node.moveodds.* )
			{
				answer.moveodds[moveodd.name().toString()] = parseFloat(moveodd.toString());
			}
			for each ( var powerup:XML in node.powerups.* ){
				if (powerup.toString().indexOf('_') != -1 ) {
					answer.powerups[powerup.name().toString()] = powerup.toString();
				} else {
					answer.powerups[powerup.name().toString()] = parseFloat(powerup.toString());
				}
			}
			for each ( var colorodd:XML in node.colorodds.* )
			{
				answer.colorodds[colorodd.name().toString()] = parseFloat(colorodd.toString());
			}
			return answer;
		}
		
		public function getEfecctsSettings():Object
		{
			var resp:Object = {}
			for each ( var sett:XML in this.data.general.* )
			{
				resp[sett.name().toString()] = sett.toString();
			}
			return resp;
		}
		
		public function dispose():void
		{
			this.duel = null;
			this.data = null;
		}
	}
}