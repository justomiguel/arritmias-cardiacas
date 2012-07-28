package com.jmv.framework.gaming.physics 
{
	/**
	 * ...
	 * @author 
	 */
	public class PhUserData{
		
		
		private var _type:String;
		public var state:String;
		private var _owner:Object;
		
		public function PhUserData(type:String, owner:Object) {
			_type = type;
			_owner = owner;
		}
			
		public function get type():String { return _type; }
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get owner():Object { return _owner; }
		
		public function set owner(value:Object):void 
		{
			_owner = value;
		}
		
	}

}