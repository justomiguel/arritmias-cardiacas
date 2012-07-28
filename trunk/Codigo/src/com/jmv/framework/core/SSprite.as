package com.jmv.framework.core {
	import com.jmv.framework.utils.DisplayObjectUtil;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.describeType;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SSprite extends Sprite {

		public function SSprite() {
			super();
		}

		/// Precise hit testing against shaped DisplayObject 
		public function hitTestShape(target:DisplayObject):Boolean {
			return false;
		}
		
		 public function addLayer(path:String) : SSprite
        {
            var _loc_2:* = new SSprite();
            var _loc_3:* = path.split(".");
            var _loc_4:* = _loc_3.pop();
            addNamedChildAtPath(_loc_3.join("."), _loc_4, _loc_2);
            return _loc_2;
        }// end function

        public function getChildByPath(path:String) : DisplayObject
        {
            return DisplayObjectUtil.getByPath(this, path);
        }// end function

        public function addChildAtPath(path:String, child:DisplayObject) : void
        {
            (getChildByPath(path) as DisplayObjectContainer).addChild(child);
            return;
        }// end function

        public function addNamedChild(name:String, child:DisplayObject) : void
        {
            addNamedChildAtPath("", name, child);
            return;
        }// end function

        public function addNamedChildAtPath(path:String, name:String, child:DisplayObject) : void
        {
            child.name = name;
            addChildAtPath(path, child);
            return;
        }// end function

        public function dispose() : void
        {
            DisplayObjectUtil.dispose(this);
            return;
        }// end function
	}

}

