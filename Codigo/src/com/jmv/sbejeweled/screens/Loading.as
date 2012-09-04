package com.jmv.sbejeweled.screens 
{
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	
	
	public class Loading extends MovieClip{
		
		private var _container:MovieClip;
		private var _func:Function;
		private var time:Timer;
		private var flagWater:Boolean;
		private var flagGarden:Boolean;
		private var flagLight:Boolean;
		private var flagAnimal:Boolean;
		private var flagTinker:Boolean;
		private var TalentCont:uint;
		private var GoTOEnd:Boolean;

		
		public function Loading(container:MovieClip) {
			
			super();
			
			this._container = container;
		
			this.addChild(_container);
			
			init();
		}
		
		public function init():void {
			App.I().initTextFields(this._container);
			
		}
		
		public function resetAnimations():void {
			
			_container.water.gotoAndStop(1);
			_container.animal.gotoAndStop(1);
			_container.garden.gotoAndStop(1);
			_container.light.gotoAndStop(1);
			_container.tinker.gotoAndStop(1);
			
			TalentCont = 0;
				flagWater = false
				flagGarden = false
				flagLight = false;
				flagAnimal = false;
				flagTinker = false;
				GoTOEnd = false;

		}
		
		public function dispose():void {
			
			DisplayObjectUtil.dispose(this);
		}	
		
		public function removeLoading(funct:Function):void {
	
				time = new Timer(0,0 );
			
			
			
			
			_func = funct;
			time.addEventListener(TimerEvent.TIMER, updateAnimations);
			time.start();
			
		}
		
		public function removeLoadingWithoutLoading(funct:Function):void {
			this.water.gotoAndPlay(1);
			this.water.addEventListener(Event.ENTER_FRAME, updateFlagWater)
			removeLoading(funct);
		}
		private function updateAnimations(e:TimerEvent):void 
		{
			if ((flagLight)&&(!flagAnimal)) { 
				this.animal.play();
				this.animal.addEventListener(Event.ENTER_FRAME, updateFlagAnimal);
				
				}
			if ((flagWater)&&(!flagGarden)) {
				this.garden.play();
				this.garden.addEventListener(Event.ENTER_FRAME, updateFlagGarden)
				}
			if ((flagGarden) &&(!flagLight)){
				this.light.play();
				this.light.addEventListener(Event.ENTER_FRAME, updateFlagLight)
				}
			if ((flagAnimal) &&(!flagTinker)){
				this.tinker.play();
				this.tinker.addEventListener(Event.ENTER_FRAME, updateFlagTinker)
				}
	
				if ((flagTinker) && (this.tinker.currentFrame == this.tinker.totalFrames)) {
										
					//TransitionClass.getInstance().savePicture(this._container);
					
					time.removeEventListener(TimerEvent.TIMER, updateAnimations);
					time.stop();
					time.reset();
					
					//nextStep();
					STween.to(this, 5, { onComplete:nextStep } );
				}
		}
		
		private function nextStep():void 
		{
			try 
			{
				time.reset();
				time.stop();
				var loading:Loading = this;
				if (this.parent) {
					STween.to(this, 1, {autoAlpha:0, onComplete:function():void{loading.parent.removeChild(loading); _func.apply(loading);}})
					//this.parent.removeChild(this);
				}
			} catch (err:Error)
			{
				
			}
		}
		
		
		public function loadAnimations(e:Object = null):void
		{
		
			if ((e.progressPercent > 15) && (this.water.currentFrame == 1)) {
				
				this.water.gotoAndPlay(1);
				this.water.addEventListener(Event.ENTER_FRAME, updateFlagWater)
				
			} else if ((e.progressPercent > 35) && ((this.garden.currentFrame == 1) && (flagWater))) {
				
				this.garden.gotoAndPlay(1);
				this.garden.addEventListener(Event.ENTER_FRAME, updateFlagGarden)
			
				
			} else if ((e.progressPercent > 55) && ((this.light.currentFrame == 1) && (flagGarden))) {
				
				this.light.gotoAndPlay(1);
				this.light.addEventListener(Event.ENTER_FRAME, updateFlagLight)
			
				
			} else if ((e.progressPercent > 75) && ((this.animal.currentFrame == 1)) && (flagLight)) {
				
				this.animal.gotoAndPlay(1);
				this.animal.addEventListener(Event.ENTER_FRAME, updateFlagAnimal);
			
				
			} else if ((e.progressPercent > 85) && ((this.tinker.currentFrame == 1)) && (flagAnimal)) {
				
				this.tinker.gotoAndPlay(1);
				this.tinker.addEventListener(Event.ENTER_FRAME, updateFlagTinker)
				
				
			} 
			
		}
		
		private function updateFlagTinker(e:Event):void
		{
			if (this.tinker.currentFrame == this.tinker.totalFrames) {
				this.tinker.removeEventListener(Event.ENTER_FRAME, updateFlagTinker);
				flagTinker = true;
			}
		}
		
		private function updateFlagAnimal(e:Event):void
		{
			if (this.animal.currentFrame == this.animal.totalFrames) {
				this.animal.removeEventListener(Event.ENTER_FRAME, updateFlagAnimal);
				flagAnimal = true;
			}
		}
		
		private function updateFlagLight(e:Event):void
		{
			if (this.light.currentFrame == this.light.totalFrames) {
				this.light.removeEventListener(Event.ENTER_FRAME, updateFlagLight);
				flagLight = true;
			}
		}
		
		private function updateFlagGarden(e:Event):void
		{
			if (this.garden.currentFrame == this.garden.totalFrames) {
				this.garden.removeEventListener(Event.ENTER_FRAME, updateFlagGarden);
				flagGarden = true
			}
		}
		
		private function updateFlagWater(e:Event):void
		{
			if (this.water.currentFrame == this.water.totalFrames) {
				this.water.removeEventListener(Event.ENTER_FRAME, updateFlagWater);
				flagWater = true;
			}
			
		}
		
		
		public function get water():MovieClip { return _container.water; }
		
		public function set water(value:MovieClip):void 
		{
			_container.water = value;
		}
		
		public function get animal():MovieClip { return _container.animal; }
		
		public function set animal(value:MovieClip):void 
		{
			_container.animal = value;
		}
		
		public function get light():MovieClip { return _container.light; }
		
		public function set light(value:MovieClip):void 
		{
			_container.light = value;
		}
		
		public function get garden():MovieClip { return _container.garden; }
		
		public function set garden(value:MovieClip):void 
		{
			_container.garden = value;
		}
		
		public function get tinker():MovieClip { return _container.tinker; }
		
		public function set tinker(value:MovieClip):void 
		{
			_container.tinker = value;
		}
	}

}