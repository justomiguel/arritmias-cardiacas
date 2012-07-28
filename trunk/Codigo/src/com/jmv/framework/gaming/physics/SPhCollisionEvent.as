package com.jmv.framework.gaming.physics 
{
	import Box2D.Dynamics.b2Body;
	import com.jmv.framework.events.SEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class SPhCollisionEvent extends SEvent 
	{
		private var _collidedObject:Object;
		
		public function SPhCollisionEvent(type:String, collidedObject:Object) 
		{ 
			super(type);
			_collidedObject = collidedObject;
			
		} 
		
		public override function clone():Event 
		{ 
			return new SPhCollisionEvent(type, _collidedObject );
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SPhCollisionEvent", "collidedObject"); 
		}
		
		public function get collidedObject():Object { return _collidedObject; }
		
		public function set collidedObject(value:Object):void 
		{
			_collidedObject = value;
		}
		
	}
	
}