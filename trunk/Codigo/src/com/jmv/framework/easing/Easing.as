
 
package com.jmv.framework.easing 
{	
	/**
	 * Single-class access to all easing functions.
	 *
	 * <p>This class groups all easing functions and allows to access
	 * them using string identifiers, via <code>getFunction()</code></p>
	 *
	 * @see getFunction
	 */
	public class Easing
	{
		/**
		 * Complete id -> function dictionary. (All ids are lowercase).
		 */
		public static var functions:Object = _init();
		
		private static function _add(dest:Object, name:String, klass:Class):void
		{
			var src:Object = {};
			src[name.toLowerCase() + "easein"] = klass.easeIn;
			src[name.toLowerCase() + "easeout"] = klass.easeOut;
			src[name.toLowerCase() + "easeinout"] = klass.easeInOut;
			for (var s:String in src)
			{
				if (dest[s])
					throw new Error("Duplicate easing identifier: " + s);
				dest[s] = src[s];
			}
		}

		private static function _init():Object
		{
			var obj:Object = {
				linear: Linear.ease,
				easein: Quad.easeIn,
				easeout: Quad.easeOut,
				easeinout: Quad.easeInOut
			};
			_add(obj, "Back", Back);
			_add(obj, "Bounce", Bounce);
			_add(obj, "Circ", Circ);
			_add(obj, "Cubic", Cubic);
			_add(obj, "Elastic", Elastic);
			_add(obj, "Expo", Expo);
			_add(obj, "Quad", Quad);
			_add(obj, "Quart", Quart);
			_add(obj, "Quint", Quint);
			_add(obj, "Sine", Sine);
			return obj;
		}

		/**
		 * Return the easing function that corresponds to the given identifier.
		 *
		 * <p>The following special identifiers are accepted: "linear", "easeIn", "easeOut", "easeInOut",
		 * which map to the Linear and Quad easing functions.</p>
		 *
		 * <p>The rest of the easing functions have <code>class + function</code> identifiers.  For example,
		 * the <code>Cubic.easeIn</code> function can be accessed with the "cubicEaseIn" id.
		 * </p>
		 *
		 * <p>Identifiers are case insensitive: "expoEaseOut", "ExpoEaseOut", "expoeaseout" all map
		 * to the same function: <code>Expo.easeOut</code>.</p>
		 */
		public static function getFunction(id:String = "linear"):Function
		{
			if (id == "" || id == null) id = "linear";
			return functions[id.toLowerCase()];
		}
	}
}

