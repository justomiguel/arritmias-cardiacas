package com.jmv.framework.gaming.scenes.transitions.base 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public interface ISTransition 
	{
		function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void;
		function start():void;
	}
	
}