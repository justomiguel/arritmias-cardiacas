

package com.jmv.framework.utils {
	/**
	 * Represents a call to an abstract method
	 * @example
	 * <listing version="3.0">
	 * package pkg
	 * {
	 * 		public class Foo {
	 * 			public function Foo(){
	 *			}
	 * 			// bar is an abstract method
	 * 			public function bar() : void
	 *  		{
	 * 				throw new AbstractMethodError('pkg.Foo','bar');
	 *  		}
	 * 		}
	 * }
	 * </listing>
	 */
	public class AbstractMethodError extends Error
	{
		protected static const MESSAGE:String = 'Abstract method called';
		
		/**
		 * Represents a call to an abstract method
		 * 
		 * @param className The name of the abstract class (can contain the package)
		 * @param method The name of the abstract method, can be omited for the constructor  
		 */
		public function AbstractMethodError( className:String, method:String = null )
		{
			if( method == null )
				method = className.split('.').pop();
			method += '()';
			
			var parts:Array = [ className, method, MESSAGE ];
			
			super( parts.join(' > ') );
		}
		
	}
}