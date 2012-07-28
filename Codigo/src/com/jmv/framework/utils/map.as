
package com.jmv.framework.utils{
	/**
	 * @see foreach() to see the difference between this function and anArray.map
	 *
	 * http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/Array.html#map()
	 */
	public function map( arr:Array, fn:Function, withIndex:Boolean = false ) : Array
	{
		var mapped:Array = new Array( arr.length );
		
		for( var i:uint = 0, l:uint = arr.length; i < l; i++ )
			mapped[i] = withIndex ?	fn( arr[i], i ) : fn( arr[i] );
		
		return mapped;
	}
}