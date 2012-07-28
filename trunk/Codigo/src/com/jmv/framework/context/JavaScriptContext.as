package com.jmv.framework.context 
{
	import flash.external.ExternalInterface;
	/**
	 * ...
	 * @author MatiX
	 */
	public class JavaScriptContext
	{
		
		public static function executeScript(script:String):void {
			ExternalInterface.call("eval", validateScript(script));
		}
		
		private static function validateScript(script:String):String {
			return script;
		}
		
	}

}