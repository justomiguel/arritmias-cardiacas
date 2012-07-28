package com.jmv.framework.gaming.gameplay.pause 
{
	/**
	 * ...
	 * @author MatiX
	 */
	import flash.system.ApplicationDomain
	 
	public function addToCurrentPauseManager(pausable:IPausable):void
	{
		var sapplication_uri:String = "com.jmv.framework.core::SApplication";
		var SApplication:Class;
		if (ApplicationDomain.currentDomain.hasDefinition(sapplication_uri)) {
			SApplication = ApplicationDomain.currentDomain.getDefinition(sapplication_uri) as Class;
			SApplication.application.scenes.currentScene.pauseManager.add(pausable);
		}
	}
}