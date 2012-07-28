package com.jmv.framework.utils 
{
	import com.jmv.framework.core.IDisposable;
	/**
	 * ...
	 * @author 
	 */
	public class IDisposableUtil
	{
		public static function diposeAll(target:Object):void {
			for (var name:String in target) 
			{
				if (target[name] is IDisposable) {
					IDisposable(target[name]).dispose();
				}
			}
		}
		
		public static function forceDiposeAll(target:Object):void {
			for (var name:String in target) 
			{
				if (target[name] is Object) {
					if (Object(target[name]).hasOwnProperty("dispose")) {
						if (target[name].dispose is Function) {
							try{
								target[name].dispose();
							}
							catch (e:Error) { }
						}
					}
				}
			}
		}
	}

}