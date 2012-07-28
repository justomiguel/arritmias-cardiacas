
package com.jmv.framework.utils
{
	/**
	 * Pythonic range() function: Return a list of integers that will usually
	 * be iterated with <code>for each</code>.
	 *
	 * <p>Example: To repeat a block of code 10 times, the classic way is:
	 * <pre>
	 * for (var i:int = 0; i &lt; 10; i++) { }
	 * </pre>
	 * </p>
	 *
	 * <p>Using range():
	 * <pre>
	 * for each (var i:int in range(10)) { }
	 * </pre>
	 * </p>
	 */
	public function range(from:int, to:int = -999999, step:int = 0):Array
	{
		if (to == -999999)
		{
			to = from;  
			from = 0;  
		}
		  
		if (step == 0)
			step = from > to ? -1 : 1;  

		var arr:Array = [];
		  
		while (test(from, to, step))
		{
			arr.push(from);
			from += step;
		}
		
		return arr;
	}
}

function test(from:int, to:int, step:int):Boolean
{
	if (step > 0)
		return from < to;
	return from > to;
}
