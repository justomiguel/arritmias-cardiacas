

package com.jmv.framework.utils {
	/**
	 * Throw an error if the given condition is false.
	 *
	 * @throws AssertionError
	 *
	 * @see http://www.stanford.edu/~pgbovine/programming-with-asserts.htm The benefits of programming with assertions
	 */
	public function assert(condition:Boolean, message:String = null):void
	{
		if (condition == false)
			throw new AssertionError(message);
	}
}

