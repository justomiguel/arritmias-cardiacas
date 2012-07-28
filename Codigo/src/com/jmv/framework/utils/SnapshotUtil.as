package com.jmv.framework.utils {
	import com.jmv.framework.core.SSprite;
	import com.jmv.framework.errors.SError;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SnapshotUtil {
		
		public static function takeSnapshot(source:DisplayObject):Bitmap {
			if(source.width > 2880 || source.height > 2880){
				throw new SError("La imagen supera los 2880 pixeles permitidos para BitmapData", source);
				return null;
			}
			var bitmapData:BitmapData = new BitmapData(source.width, source.height, true);
			bitmapData.draw(source);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			return bitmap;
		}
		
	}

}

