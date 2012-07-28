package com.jmv.framework.core {
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.utils.ArrayUtil;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class Hub extends EventDispatcher {
		
		   protected var listeners:Object;
		
		public function Hub() {
			this.listeners = {};
		}
		
		private var removers:Array = new Array();
		
		//override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			//super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			//var remover:Object = { type:type, listener:listener, useCapture:useCapture };
			//removers.push(remover);
		//}
		
		public function addEventListenerToGroup(type:String, listener:Function, groupKey:String, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void {
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			var remover:Object = { type:type, listener:listener, useCapture:useCapture, groupKey:groupKey };
			removers.push(remover);
		}
		
		//override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			//super.removeEventListener(type, listener, useCapture);
			//for each (var remover:Object in removers) {
				//if (remover.type == type && remover.listener == listener && remover.useCapture == useCapture) {
					//removers.splice(removers.indexOf(remover));
					//break;
				//}
			//}
		//}
		
		//public function dispatch(type:String, data:*= null):void {
			//var e:SEvent = new SEvent(type, data);
			//super.dispatchEvent(e);
		//}
		
		public function removeAllListeners(groupKey:String = null):void {
			for each (var remover:Object in removers) {
				if (groupKey) {
					if (!remover.groupKey ) continue;
					if (remover.groupKey != groupKey) continue;
				}
				removeEventListener(remover.type, remover.listener, remover.useCapture);
			}
			removers = new Array();
		}
		
		 override public function removeEventListener(type:String, fn:Function, useCapture:Boolean = false) : void
        {
            super.removeEventListener(type, fn, useCapture);
            var _loc_4:* = this.listeners[type];
            if (!_loc_4)
            {
                return;
            }
            ArrayUtil.removeElement(_loc_4, fn);
            if (_loc_4.length == 0)
            {
                delete this.listeners[type];
            }
            return;
        }// end function

        override public function addEventListener(type:String, fn:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true) : void
        {
            super.addEventListener(type, fn, useCapture, priority, useWeakReference);
            if (this.listeners[type])
            {
                if (!ArrayUtil.contains(this.listeners[type], fn))
                {
                    this.listeners[type].push(fn);
                }
            }
            else
            {
                this.listeners[type] = [fn];
            }
            return;
        }// end function

        public function dispose() : void
        {
            var _loc_1:String = null;
            var _loc_2:Array = null;
            for (_loc_1 in this.listeners)
            {
                
                _loc_2 = this.listeners[_loc_1];
                do
                {
                    
                    removeEventListener(_loc_1, _loc_2[(_loc_2.length - 1)]);
                    if (_loc_2)
                    {
                    }
                }while (_loc_2.length > 0)
            }
            return;
        }// end function

        public function dispatch(type:String, data:* = null) : Boolean
        {
            return dispatchEvent(new SEvent(type, data));
        }// end function

	}
	
}