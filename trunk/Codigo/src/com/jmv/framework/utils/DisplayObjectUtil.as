package com.jmv.framework.utils {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class DisplayObjectUtil {
		
		public static function getChildByPath(target:DisplayObjectContainer ,path:String):DisplayObject {
			var childList:Array = path.split("/");
			var targetChild:DisplayObject = target;
			var childListLength:int = childList.length;
			var childName:String = "";
			for (var i:int = 0; i < childListLength; i++ ) {
				if (targetChild) {
					if (targetChild is DisplayObjectContainer) {
						childName = childList[i];
						targetChild = (targetChild as DisplayObjectContainer).getChildByName(childName);
					}
					else if (i < childListLength - 1) {
						targetChild = null;
						break;
					}
				}
				else {
					break;
				}
			}
			return targetChild;
		}
		
		public static function getDescendantsByName(target:DisplayObjectContainer, name:String):Array {
			var results:Array = getDescendantsByName_proxy(target, name);
			getDescendantsByName_results = null;
			return results;
		}
		
		private static var getDescendantsByName_results:Array
		
		private static function getDescendantsByName_proxy(target:DisplayObjectContainer, name:String):Array {
			if (!getDescendantsByName_results) getDescendantsByName_results = new Array();
			for (var i:int = 0; i < target.numChildren; i++) 
			{
				var child:DisplayObject = target.getChildAt(i);
				if (child.name == name) getDescendantsByName_results.push(child);
				if (child is DisplayObjectContainer) getDescendantsByName_results.concat(getDescendantsByName_proxy(child as DisplayObjectContainer, name));
			}
			var results:Array = getDescendantsByName_results;
			return results;
		}
		
		
		public static function sendToBack(target:DisplayObject):void {
			if (!target) return
			if (! target.parent) return;
			target.parent.addChildAt(target, 0);
		}
		
		public static function duplicateDisplayObject(target:DisplayObject):DisplayObject {
			var targetClass:Class;
			targetClass = Object(target).constructor;
			var duplicated:DisplayObject = new targetClass();

			duplicated.transform = target.transform;
			duplicated.filters = target.filters;
			duplicated.cacheAsBitmap = target.cacheAsBitmap;
			duplicated.opaqueBackground = target.opaqueBackground;

			return duplicated;
		}
		
		public static function globalize(elem:DisplayObject) : void
        {
            var _loc_2:* = globalCoords(elem);
            elem.x = _loc_2.x;
            elem.y = _loc_2.y;
            return;
        }// end function

        public static function globalCoords(elem:DisplayObject) : Point
        {
            return new Point(offsetX(elem), offsetY(elem));
        }// end function

        public static function hide(elem:DisplayObject) : void
        {
            elem.visible = false;
            return;
        }// end function

        public static function remove(elem:DisplayObject) : void
        {
            if (elem is MovieClip)
            {
                (elem as MovieClip).stop();
            }
            if (elem.parent)
            {
                elem.parent.removeChild(elem);
            }
            return;
        }// end function

        public static function offsetX(elem:DisplayObject, relativeTo:DisplayObject = null) : Number
        {
            var _loc_3:Number = 0;
            do
            {
                
                _loc_3 = _loc_3 + elem.x;
                elem = elem.parent;
                if (elem)
                {
                }
            }while (elem != relativeTo)
            return _loc_3;
        }// end function

        public static function offsetY(elem:DisplayObject, relativeTo:DisplayObject = null) : Number
        {
            var _loc_3:Number = 0;
            do
            {
                
                _loc_3 = _loc_3 + elem.y;
                elem = elem.parent;
                if (elem)
                {
                }
            }while (elem != relativeTo)
            return _loc_3;
        }// end function

        public static function reparentTo(elem:DisplayObject, newParent:DisplayObjectContainer) : void
        {
            globalize(elem);
            newParent.addChild(elem);
            localize(elem);
            return;
        }// end function

        public static function forEachChildren(elem:DisplayObjectContainer, fn:Function, recursive:Boolean = false) : void
        {
            var _loc_5:DisplayObject = null;
            var _loc_4:* = map(range(elem.numChildren), elem.getChildAt);
			
			
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5)
                {
                    fn(_loc_5);
                }
                if (recursive)
                {
                }
                if (_loc_5 is DisplayObjectContainer)
                {
                    forEachChildren(_loc_5 as DisplayObjectContainer, fn, true);
                }
            }
            return;
        }// end function

        public static function localize(elem:DisplayObject) : void
        {
            var _loc_2:* = localCoords(elem);
            elem.x = _loc_2.x;
            elem.y = _loc_2.y;
            return;
        }// end function

        public static function mask(elem:DisplayObject, sx:Number = 0, sy:Number = 0, ex:Number = 0, ey:Number = 0) : Shape
        {
            var _loc_6:* = new Shape();
            _loc_6.graphics.beginFill(0x000000);
            _loc_6.graphics.drawRect(sx, sy, elem.width + ex, elem.height + ey);
            _loc_6.x = elem.x;
            _loc_6.y = elem.y;
            elem.parent.addChild(_loc_6);
            elem.mask = _loc_6;
            return _loc_6;
        }// end function

        public static function empty(elem:DisplayObjectContainer) : void
        {
            var _loc_2:* = elem.numChildren;
            while (_loc_2--)
            {
                
                elem.removeChildAt(0);
            }
            return;
        }// end function

        public static function dispose(elem:DisplayObject) : void
        {
            remove(elem);
            if (elem is DisplayObjectContainer)
            {
                forEachChildren(elem as DisplayObjectContainer, remove, true);
            }
            return;
        }// end function

        public static function localCoords(elem:DisplayObject) : Point
        {
            return new Point(elem.x, elem.y).subtract(globalCoords(elem.parent));
        }// end function

        public static function getByPath(elem:DisplayObjectContainer, path:String = "") : DisplayObject
        {
            if (path == "")
            {
                return elem;
            }
            var _loc_3:* = path.split(".");
            var _loc_4:* = _loc_3.shift();
            var _loc_5:* = elem.getChildByName(_loc_4);
            if (_loc_3.length == 0)
            {
                return _loc_5;
            }
            return getByPath(_loc_5 as DisplayObjectContainer, _loc_3.join("."));
        }// end function

        public static function center(elem:DisplayObject) : void
        {
            var elem:* = elem;
            var _loc_3:* = elem;
            with (elem)
            {
                if (parent)
                {
                    x = (parent.width - width) / 2;
                    y = (parent.height - height) / 2;
                }
            }
            return;
        }// end function

        public static function getByName(elem:DisplayObjectContainer, name:String) : DisplayObject
        {
            var _loc_5:DisplayObjectContainer = null;
            var _loc_3:* = elem.getChildByName(name);
            var _loc_4:* = elem.numChildren;
            do
            {
                
                _loc_5 = elem.getChildAt(_loc_4) as DisplayObjectContainer;
                if (_loc_5)
                {
                    _loc_3 = getByName(_loc_5, name);
                }
                if (!_loc_3)
                {
                }
            }while (_loc_4--)
            return _loc_3;
        }// end function

        public static function bringToFront(elem:DisplayObject) : void
        {
            var _loc_2:* = elem.parent;
            if (_loc_2)
            {
                _loc_2.setChildIndex(elem, (_loc_2.numChildren - 1));
            }
            return;
        }// end function

        public static function show(elem:DisplayObject) : void
        {
            elem.visible = true;
            return;
        }// end function

        public static function stopMovieClip(displayObject:DisplayObject) : void
        {
            if (displayObject is MovieClip)
            {
                (displayObject as MovieClip).stop();
            }
            return;
        }// end function

        public static function children(elem:DisplayObjectContainer, recursive:Boolean = false) : Array
        {
            var _loc_3:* = new Array();
            forEachChildren(elem, _loc_3.push, recursive);
            return _loc_3;
        }// end function
	}
}