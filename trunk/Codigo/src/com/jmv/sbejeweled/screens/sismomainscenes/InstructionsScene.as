package com.jmv.sbejeweled.screens.sismomainscenes 
{
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.sbejeweled.screens.Instructions;
	
	/**
	 * ...
	 * @author ...
	 */
	public class InstructionsScene extends SScene
	{
		public var instruction:Instructions;
		
		public function InstructionsScene() 
		{
			super();
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			this.instruction = new Instructions();
			this.addChild(instruction);
		}
		
		override public function dispose():void 
		{
			removeChild(instruction);
			super.dispose();
		}
		
	}

}