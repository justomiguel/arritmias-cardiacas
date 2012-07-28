package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled.screens.ScreenLoseGame;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScreenLooseGameScene extends SScene
	{
		public var screenlosegmae:ScreenLoseGame;
		
		public function ScreenLooseGameScene() 
		{
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			this.screenlosegmae = new ScreenLoseGame();
			this.addChild(screenlosegmae);
		}
		
		override public function dispose():void 
		{
			removeChild(screenlosegmae);
			super.dispose();
		}
		
	}

}