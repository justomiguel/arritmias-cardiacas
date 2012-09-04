package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled._game_.MainGame;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class ArritmiasMainScene extends SScene 
	{
		
		// Screens on this scene
		public var game:MainGame;
		
		public function ArritmiasMainScene() 
		{
			super();
			
			this.game = new MainGame();
			this.addChild(game);
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
		}	
		
	}

}