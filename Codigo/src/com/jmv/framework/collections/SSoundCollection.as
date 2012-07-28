package com.jmv.framework.collections {
	import com.jmv.framework.sound.base.SSound;
	import flash.errors.IllegalOperationError;
	import flash.utils.Proxy;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SSoundCollection extends Proxy {
		
		private var collection:Array;
		
		import flash.utils.flash_proxy;
		use namespace flash.utils.flash_proxy;
		
		public function SSoundCollection(source:Array = null) {
			if (source) collection = source
			else collection = new Array();
		}
		
		/*public function playSound(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):void {
			callProperty("playSound", startTime, loops, sndTransform);
		}*/

		public function stop():void {
		}
		
		override flash_proxy function callProperty(name:*, ...args):* {
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean {
			return delete collection[name];
        }
  
        override flash_proxy function getProperty(name:*):* {
            return collection[name];
        }
  
        override flash_proxy function hasProperty(name:*):Boolean {
            return name in collection;
        }
  
		override flash_proxy function nextNameIndex(index:int):int {
			if (index > collection.length)
				return 0;
			return index + 1;
		}

		override flash_proxy function nextName(index:int):String {
			return String(index - 1);
		}

		override flash_proxy function nextValue(index:int):* {
			return collection[index - 1];
		}
		
		public function toArray():Array {
			return collection;
		}
		
		public function stopAll():void {
			for each (var sound:SSound in collection) {
				if(sound){
					if (sound.isInState(SSound.STATE_PLAYING)) {
						sound.stop();
					}
				}
			}
		}
		
		public function toString():String {
			return "[object SSoundCollection: " + String(collection) + "]";
		}
	}
	
}