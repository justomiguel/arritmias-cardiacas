package com.jmv.sbejeweled._game_.ui
{
	import com.jmv.sbejeweled._game_.ui.bars.AnimalMeter;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.AnimalBall;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.GardenBall;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.LigthBall;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.TinkerBall;
	import com.jmv.sbejeweled._game_.ui.bars.ballmeters.WaterBall;
	import com.jmv.sbejeweled._game_.ui.bars.GardenMeter;
	import com.jmv.sbejeweled._game_.ui.bars.LightMeter;
	import com.jmv.sbejeweled._game_.ui.bars.TimeBar;
	import com.jmv.sbejeweled._game_.ui.bars.TinkerMeter;
	import com.jmv.sbejeweled._game_.ui.bars.WaterMeter;
	import com.jmv.sbejeweled._game_.ui.fxbars.TimePassFx;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	
	
	public class Background extends MovieClip
	{
		public var anchorBoard1:MovieClip;
		public var anchorBoard2:MovieClip;
		
		
		public var meterAnimal:AnimalMeter;
		
		public var timerBar:TimeBar;
		
		public var tiempo:MovieClip;
		
		public var animal:TextField;
		
		public var multi:MovieClip;
		
		public var timerFX:TimePassFx;
		
		public var animalBallMeter:AnimalBall; 
				
		public var bg:MovieClip;
		
		
		public function Background()
		{
			super();			
			
			
		}
		
		
		
	
	}
}