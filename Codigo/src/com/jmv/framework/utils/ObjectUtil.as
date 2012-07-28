package com.jmv.framework.utils 
{
	/**
	 * ...
	 * @author Nati
	 */
	public class ObjectUtil
	{
		
		public function ObjectUtil() 
		{
			
		}
		
		 public static function isObject(obj:*) : Boolean
        {
            if (!obj){
				return false;
            }
            return typeof(obj) == "object";
        }// end function

        public static function values(src:Object) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for (_loc_3 in src)
            {
                
                _loc_2.push(src[_loc_3]);
            }
            return _loc_2;
        }// end function

        public static function keys(src:Object) : Array
        {
            var _loc_3:String = null;
            var _loc_2:Array = [];
            for (_loc_3 in src)
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        public static function copy(src:Object, target:Object = null, deep:Boolean = false) : Object
        {
            var _loc_4:String = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            if (!target)
            {
                target = {};
            }
            for (_loc_4 in src)
            {
                
                _loc_5 = target[_loc_4];
                _loc_6 = src[_loc_4];
                if (deep)
                {
                }
                if (isObject(_loc_5))
                {
                    isObject(_loc_5);
                }
                if (isObject(_loc_6))
                {
                    copy(_loc_6, _loc_5, true);
                    continue;
                }
                target[_loc_4] = _loc_6;
            }
            return target;
        }// end function

        public static function find(list:Object, value:Object) : String
        {
            var _loc_3:String = null;
            for (_loc_3 in list)
            {
                
                if (list[_loc_3] === value)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function contains(list:Object, value:Object) : Boolean
        {
            return find(list, value) !== null;
        }// end function

		
	}

}