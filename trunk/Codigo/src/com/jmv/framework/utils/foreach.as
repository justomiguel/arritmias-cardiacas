
package com.jmv.framework.utils{
	/**
	 * This function seems equal to ([1,3,3]).forEach(function( num:int, index:int, arr:Array ) : void { });
	 * The difference is that it only passes the value (and optionally the index).
	 * This is, in general, the desired behavior.
	 * 
	 * http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/Array.html#forEach()
	 */
	public function foreach( arr:Array, fn:Function, withIndex:Boolean = false ) : void
	{
		// Saves the length so it's not recalculated on each loop
		for( var i:uint = 0, l:uint = arr.length; i < l; i++ ){
			if( withIndex )
				fn( arr[i], i );
			else
				fn( arr[i] );
		}
	}
}
