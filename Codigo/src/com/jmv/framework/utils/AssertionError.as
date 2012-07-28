

package com.jmv.framework.utils {
	/**
	 * Assertion error, thrown when a call to <code>assert()</code> fails.
	 *
	 * @see assert
	 */
	public class AssertionError extends Error
	{
		public function AssertionError(message:String = null)
		{
			super(message || "Assertion error");
		}
	}
}
