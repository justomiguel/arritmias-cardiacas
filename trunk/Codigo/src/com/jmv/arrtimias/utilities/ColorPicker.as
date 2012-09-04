package com.jmv.arrtimias.utilities
{
	import com.jmv.arrtimias.events.PickerEvent;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class ColorPicker extends Sprite
	{
		
		private var bitmapData:BitmapData;
		private var colorTransform:ColorTransform;
		private var hexColor:*; //This variable will store the bitmap color data  
		
		//movievlicp vars
		public var spectrum:Sprite;
		public var color:Sprite;
		public var colorHex:TextField;
		
		public var btnCerrar:Sprite;
		
		public function ColorPicker(){
			bitmapData = new BitmapData(202, 132); //A Bitmap Data object, the size is based on the color spectrum size  
			colorTransform = new ColorTransform();
			bitmapData.draw(this.spectrum)
		}
		
		public function showColorPicker(myParent:Sprite):void {
			myParent.stage.addChild(this);
			this.x = this.stage.width/2 - this.width/2
			this.y = this.stage.height/2 - this.height/2
			/* Function listeners */
			this.spectrum.addEventListener(MouseEvent.MOUSE_MOVE, updateColorPicker);
			this.spectrum.addEventListener(MouseEvent.MOUSE_UP, setValue);
			this.btnCerrar.addEventListener(MouseEvent.CLICK, removeFromStage);
		}
		
		private function updateColorPicker(e:MouseEvent):void{
			/* Gets the color from the pixel where the mouse is and passes the value to the colorTransform variable */
			
			hexColor = "0x" + bitmapData.getPixel(this.spectrum.mouseX, this.spectrum.mouseY).toString(16);
			colorTransform.color = hexColor;
			
			/*Sets the color transform data to the "color" clip and the "colorHex" field in the ColorPicker */
			
			this.color.transform.colorTransform = colorTransform;
			this.colorHex.text = "#" + bitmapData.getPixel(this.spectrum.mouseX, this.spectrum.mouseY).toString(16).toUpperCase();
		}
		
		private function setValue(e:MouseEvent):void  {  
			removeFromStage();
			
			var event:PickerEvent = new PickerEvent(colorTransform);
			this.dispatchEvent(event);
		} 
		
		private function removeFromStage(e:Event = null):void 
		{
			//txt.textColor = hexColor; //This is the target 
			this.spectrum.removeEventListener(MouseEvent.MOUSE_MOVE, updateColorPicker);
			this.spectrum.removeEventListener(MouseEvent.MOUSE_UP, setValue);
			this.btnCerrar.removeEventListener(MouseEvent.CLICK, removeFromStage);
			
			if (parent != null) {
				this.parent.removeChild(this);
			}
		}
	
	}

}