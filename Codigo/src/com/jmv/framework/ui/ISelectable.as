package com.jmv.framework.ui 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public interface ISelectable extends IEventDispatcher
	{
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get enabled():Boolean;
		function set enabled(value:Boolean):void;
	}
	
}