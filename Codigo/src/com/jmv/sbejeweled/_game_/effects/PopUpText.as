package com.jmv.sbejeweled._game_.effects
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	
	
	public class PopUpText extends AbstractEffect
	{
		public var textfield:MovieClip;
		
		public function PopUpText(text:String)
		{
			super();
			//App.I().log(text);
			var label:TextField = this.textfield.label;
			label.text = text!=null?text:"1";
			/*
			if (text.length>15)
			{
				
				label.scaleX = 0.8;
				label.scaleY = 0.8;
				
			}
			*/
		}
		
	}
}