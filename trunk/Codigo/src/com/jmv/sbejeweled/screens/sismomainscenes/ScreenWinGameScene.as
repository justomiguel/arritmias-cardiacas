package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled.screens.ScreenWinGame;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScreenWinGameScene extends SScene
	{
		public var screenwingmae:ScreenWinGame;
		
		public function ScreenWinGameScene() 
		{
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			this.screenwingmae = new ScreenWinGame();
			this.addChild(screenwingmae);
		}
		
		override public function dispose():void 
		{
			removeChild(screenwingmae);
			super.dispose();
		}
		
	}

}