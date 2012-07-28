package com.jmv.framework.utils 
{
	import com.jmv.framework.math.SMath;
	/**
	 * ...
	 * @author MatiX
	 */
	public class ArrayUtil
	{
		public static function clone(source:Array):Array {
			var result:Array = new Array();
			for (var i:int = 0; i < source.length; i++) 
				result.push(source[i]);
			return result;
		}
		
		public static function randomize(source:Array,factor:int=-1):Array
		{
			if (factor < 0) {
				factor = source.length;
			}
			var result:Array = clone(source);
			for (var i:int = 0; i < factor; i++) 
			{
				var popped:* = result.pop();
				var to:int = SMath.random(0, result.length, 0);
				result.splice(to, 0, popped);
			}
			return result;
		}
		
		/**
		 * Remove an element from an array.
		 *
		 * @return The object removed; or <code>null</code> if it is not found.
		 */ 
		public static function removeElement(array:Array, elem:Object):Object
		{
			var i:int = array.indexOf(elem);
			if (i != -1)
				return array.splice(i, 1)[0];
			return null;
		}
		
		/**
		 * Adds without duplicates.
		 * @param data The array with duplicate values.
		 */ 
		public static function addUnique(arr:Array, value:*):void
		{
			if( !contains( arr, value ) )
				arr.push( value );
		}
		
		/**
		 * Given an array with duplicate values, returns an array 
		 * with no duplicates.
		 * The <i>data</i> is not changed.
		 * 
		 * @param data The array with duplicate values.
		 */ 
		public static function removeDuplicates(data:Array):Array
		{
			var unique:Array = new Array();
			
			for (var i:int=0, l:int = data.length; i<l; i++)
				addUnique( unique, data[i] );
			
			return unique;
		}
		
		/**
		 * Remove a random element from the array and return it.
		 */
		public static function popChoice(values:Array):Object
		{
			var n:Number = SMath.randint(0, values.length - 1);
			return values.splice(n,1)[0];
		}
		
		/**
		 * Return a random element from the array.
		 */
		public static function choice(values:Array):Object
		{
			var n:Number = SMath.randint(0, values.length - 1);
			return values[n];
		}
		
		/**
		 * Return a random element with probabilities from the array.
		 */
		public static function choiceWithProbability(values:Array, probabilities:Array):Object
		{
			var sum:Number = 0;
			var i:Number;
			for (i = 0; i < probabilities.length; i++)
				sum += probabilities[i];
			var n:Number = sum * Math.random();
			for (i = 0; i < probabilities.length; i++)
			{
				n -= probabilities[i];
				if (n < 0)
				{
					return values[i];
				}
			}
			return null;
		}
		
		/**
		 * Return a new array with the elements in random order.
		 */
		public static function shuffle(old:Array):Array {
			var tmp:Array = old.slice();
			var new_:Array = [];
			while (tmp.length > 0)
			{
				var o:Object = tmp.splice(Math.round((tmp.length - 1) * Math.random()), 1)[0];
				new_.push(o);
			}
			return new_;
		}
		
		/**
		 * Return whether an array contains an element.
		 */
		public static function contains( arr:Array, obj:* ) : Boolean
		{
			return arr.indexOf( obj ) != -1;
		}
		
		/**
		 * Returns whether 2 arrays have the same elements, in the same order.
		 */
		public static function equal( arr1:Array, arr2:Array ) : Boolean
		{
			var l:int = arr1.length;
			if( arr2.length != l )
				return false;
			while( l-- )
				if( arr1[l] !== arr2[l] )
					return false;
			return true;
		}
	}

}