package com.jmv.framework.gaming.physics.listeners {
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class PhContactListener extends b2ContactListener {

		private var addListeners:Array;
		private var persistListeners:Array;
		private var removeListeners:Array;
		private var resultListeners:Array;

		private var isOn:Boolean = true

		public function PhContactListener() {
			this.addListeners = new Array();
			this.persistListeners = new Array();
			this.removeListeners = new Array();
			this.resultListeners = new Array();
			super();
		}

		override public function Add(point:b2ContactPoint):void {
			if(isOn){
				if(point.shape1 && point.shape2){
					var event: PhContactEvent = new PhContactEvent(PhContactEvent.CONTACT_ADD, point);
					for each (var listener:Function in addListeners) {
						listener.call(this, event);
					}
				}
			}
		}

		override public function Persist(point:b2ContactPoint):void {
			if (isOn) {
				if(point.shape1 && point.shape2){
					var event: PhContactEvent = new PhContactEvent(PhContactEvent.CONTACT_PERSIST, point);
					for each (var listener:Function in persistListeners) {
						listener.call(this, event);
					}
				}
			}
		}

		override public function Remove(point:b2ContactPoint):void {
			if (isOn) {
				if (point.shape1 && point.shape2) {
					var event: PhContactEvent = new PhContactEvent(PhContactEvent.CONTACT_REMOVE, point);
					for each (var listener:Function in removeListeners) {
						listener.call(this, event);
					}
				}
			}
		}

		override public function Result(result:b2ContactResult):void {
			if (isOn) {
				if (result.shape1 && result.shape2) {
					var event: PhContactEvent = new PhContactEvent(PhContactEvent.CONTACT_RESULT, null, result);
					for each (var listener:Function in resultListeners) {
						listener.call(this, event);
					}
				}
			}
		}

		public function addContactListener(type:String, handler:Function):void {
			switch(type) {
				case PhContactEvent.CONTACT_ADD: 
					this.addListeners.push(handler);
					break;
				case PhContactEvent.CONTACT_PERSIST:
					this.persistListeners.push(handler);
					break;
				case PhContactEvent.CONTACT_REMOVE:
					this.removeListeners.push(handler);
					break;
				case PhContactEvent.CONTACT_RESULT:
					this.resultListeners.push(handler);
					break;
			}
		}

		public function removeContactListener(type:String, handler:Function):void {
			var idx:int;
			switch(type) {
				case PhContactEvent.CONTACT_ADD: 
					idx = this.addListeners.indexOf(handler);
					if (idx >= 0) {
						this.addListeners.splice(idx, 1);
					}
					break;
				case PhContactEvent.CONTACT_PERSIST:
					idx = this.persistListeners.indexOf(handler);
					if (idx >= 0) {
						this.persistListeners.splice(idx, 1);
					}
					break;
				case PhContactEvent.CONTACT_REMOVE:
					idx = this.removeListeners.indexOf(handler);
					if (idx >=0) {
						this.removeListeners.splice(idx, 1);
					}
					break;
				case PhContactEvent.CONTACT_RESULT:
					idx = this.resultListeners.indexOf(handler);
					if (idx >= 0){ 
						this.resultListeners.splice(idx, 1);
					}
					break;
			}
		}

		public function removeAllContactListeners():void {
			this.addListeners = new Array();
			this.persistListeners = new Array();
			this.removeListeners = new Array();
			this.resultListeners = new Array();
		}

		public function toggleListeners(b:Boolean):void {
			this.isOn = b;
		}
	}

}

