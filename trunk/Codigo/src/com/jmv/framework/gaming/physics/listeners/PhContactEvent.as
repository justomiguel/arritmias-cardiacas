package com.jmv.framework.gaming.physics.listeners {
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	import flash.events.Event;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class PhContactEvent extends Event {

		public static const CONTACT_ADD:String = "onContactAdd";
		public static const CONTACT_PERSIST:String = "onContactPersist";
		public static const CONTACT_REMOVE:String = "onContactRemove";
		public static const CONTACT_RESULT:String = "onContactResult";

		public var point:b2ContactPoint;
		public var result:b2ContactResult;

		public function PhContactEvent(type:String, point:b2ContactPoint = null, result:b2ContactResult = null) { 
			if (point) {
				this.point = point;
			}
			if (result) {
				this.result = result;
			}
			super(type);
		} 

		public override function clone():Event { 
			return new PhContactEvent(type, point, result);
		} 

		public override function toString():String { 
			return formatToString("PhContactEvent", "type", "bubbles", "cancelable", "eventPhase", "point"); 
		}

	}

}

