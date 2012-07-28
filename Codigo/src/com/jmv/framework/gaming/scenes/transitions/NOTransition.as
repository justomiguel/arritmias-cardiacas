package com.jmv.framework.gaming.scenes.transitions 
{
	import flash.display.DisplayObjectContainer;
	import com.jmv.framework.gaming.scenes.transitions.base.STransition;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author MatiX
	 */
	public class NOTransition extends STransition
	{
		override public function inititalize(beforeSnapshot:Bitmap, afterSnapshot:Bitmap, stage:DisplayObjectContainer, args:Object = null):void 
		{}
		
		override public function start():void 
		{}
	}

}