package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled.screens.MainMenu;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MainMenuScene extends SScene {
		
		public var main:MainMenu;
		
		public function MainMenuScene() {
			//trace( "MainMenuScene : " + MainMenuScene );
			
			super();
			
		}
		
		override public function initialize():void {
			
			super.initialize();
			//trace( "MainMenu : " + MainMenu );
			main = new MainMenu() ;
			this.addChild(main);
			
		}
		
		override public function dispose():void {
			try {
					
				this.removeChild(main);
				
			} catch (err:Error)
			{
				
			}
			super.dispose();
		}
	}

	
	
}