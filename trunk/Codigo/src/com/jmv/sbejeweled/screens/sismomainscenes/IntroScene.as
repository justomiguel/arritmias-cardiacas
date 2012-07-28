package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled.screens.Intro;
	
	/**
	 * ...
	 * @author ...
	 */
	public class IntroScene extends SScene
	{
		public var intro:Intro;
		
		public function IntroScene() 
		{
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			intro = new Intro();
			this.addChild(intro);
			
		}
		
		override public function dispose():void 
		{
			//try {
				removeChild(intro);
			//}catch (err:Error){
				//
			//}
			super.dispose();
		}
	}

}