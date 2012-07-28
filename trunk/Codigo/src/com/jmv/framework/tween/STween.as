package com.jmv.framework.tween 
{
	import com.jmv.framework.easing.Easing;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;
	import flash.filters.GradientGlowFilter;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	
	
	public class STween extends Timer {
		
		public static const LowValue:Number = 0.0001
		
		// The time duration of the tween in seconds
		private var _duration:Number;
		
		// The left time in miliseconds of the tween 
		private var miliseconds:uint;
		
		// Params for the tween animation it could be change depending the vars you want to modify
		private var _params:Object;
		
		// Anothers params about the tween animation, suchs as the update function to be called every step of the tween
		private var _options:Object;
		
		// the object to be transformed
		private var _targetMC:Object;
		
		// the current difference between the actual values of the display object, and the new ones
		private var dx:Number;
		
		// These are a copy of the initial values object of the current target display object to be animated
		private var initialObjectparameters:Object;
		
		// The current delay propertie set by the user to start the animation after the time
		private var delayTimer:Timer;
		
		// the current transition
		private var ease:Function;
		
		/**
		 * Generic tween animation. Allows to animate (tween) one or more properties of any given object.
		 *
		 * Create a Tween animation.
		 *
		 * @param target The target object whos attributes will be modified.
		 * @param duration Duration (in seconds) for the animation.
		 * @param dest Attributes to be modified and their destination values.
		 * These params could be:
		 * 
		 * - Display Object Properties:
		 * --- Alpha
		 * 
		 * - Display Object Filters:
		 * 
		 * --- BevelFilter: Initializes a new BevelFilter instance with the specified parameters.
		 * ------> distance:Number = 0, angle:Number = 0, highlightColor:uint = 16777215, highlightAlpha:Number = 1, shadowColor:uint = 0, shadowAlpha:Number = 1, blurX:Number = 0, blurY:Number = 0, strength:Number = 0, quality:int = 1
		 * --- BlurFilter: Creates a new BlurFilter instance with the specified parameters.
		 * ------> blurX:Number = 0, blurY:Number = 0, quality:int = 1
		 * --- DropShadowFilter: Creates a new DropShadowFilter instance with the specified parameters.
		 * ------> distance:Number = 0, angle:Number = 0, color:uint = 0, alpha:Number = 1, blurX:Number = 0, blurY:Number = 0, strength:Number = 0, quality:int = 1
		 * --- GlowFilter:Creates a new GlowFilter instance with the specified parameters.
		 * -----> color:uint = 16711680, alpha:Number = 1, blurX:Number = 0, blurY:Number = 0, strength:Number = 0, quality:int = 1
		 * 
		 * - Functions
		 * --- onStart : Function - A function that should be called when the tween begins
		 * --- onStartParams : Array - An Array of parameters to pass the onStart function
		 * --- onUpdate : Function - A function that should be called every time the tween's time/position is updated (on every frame while the tween is active)
		 * --- onUpdateParams : Array - An Array of parameters to pass the onUpdate function
		 * --- onComplete : Function - A function that should be called when the tween has completed
		 * --- onCompleteParams : Array - An Array of parameters to pass the onComplete function
		 * 
		 * @param transition Any identifier accepted by <code>Easing.getFunction()</code>. Examples: "linear" (default), "easeIn", "easeOut", "easeInOut", "bounceEaseIn", etc.
		 * 
		 * <p>Example: tween the alpha property of a DisplayObject for 1.3 seconds:
		 * <pre>
		 * var tween1:STween = new STween(sprite1, 1.3, {alpha:0.3});
		 * </pre>
		 * </p>
		 *
		 */
		public function STween(mc:Object, duration:Number, params:Object, startInmediatily:Boolean = true) {
			
			if (mc) {
				super(10);
			
				_duration = duration * 1000;
				
				
				if (params.hasOwnProperty("transition")) {
					this.ease = Easing.getFunction(params["transition"]);
				} else {
					this.ease = Easing.getFunction("linear");
				}
				
				_params = params;
				
				_targetMC = mc;
				
				miliseconds = 0;
				
				this.addEventListener(TimerEvent.TIMER, onTick);
				
				initParameters();
				
				if (startInmediatily) start();
			
			}
			
			return;
		}
		
		private function initParameters():void {
			initialObjectparameters = new Object();
						
			for (var name:String in params) {
				
				if (_targetMC.hasOwnProperty(name)) {
					initialObjectparameters[name] = targetMC[name]
					
				} else {
					var filter:BitmapFilter = null;
					switch(name) {
						case "autoAlpha":
							initialObjectparameters["alpha"] = targetMC["alpha"];
							params.alpha = 0;
						break;
						case "BevelFilter":
							filter = new BevelFilter(0, 0, params[name]["highlightColor"], 1, params[name]["shadowColor"], 0, 0, 0, 1);
						break;
						case "BlurFilter":
							filter = new BlurFilter(0, 0, 1);
						break;
						case "DropShadowFilter":
							filter = new DropShadowFilter(0, 0, 0, 1, 0, 0, 0, 1);
						break;
						case "GlowFilter":
							filter = new GlowFilter(params[name]["color"], 1, 0, 0, 0, 1); break;
						case "delay":
							delayTimer = new Timer(params.delay,1);
						break;
							
					}
					if (filter) {
						if (!initialObjectparameters["filters"]) {
							if (targetMC.filters.length == 0) {
								initialObjectparameters["filters"] = new Array();
							} else {
								initialObjectparameters["filters"] = targetMC.filters;
							}
						}
						initialObjectparameters["filters"].push(filter);
					}
				}
			}
		}
		
		public function getFilterPosition(filter:BitmapFilter, target:Object):int {
			for (var i:int = 0; i < target.filters.length ; i++) {
				if (getQualifiedClassName(target.filters[i]) == getQualifiedClassName(filter)) {
					return i;
					break;
				}
			}
			return -1;
		}
		
		override public function start():void {
			//trace("comienzo");
			if (params.hasOwnProperty("onStartParams")) {
				params.onStart.apply(null, params.onStartParams)
			} else if (params.hasOwnProperty("onStart")) {
				params.onStart.apply(null);
			}
			
			if (delayTimer) {
				delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayTimerTick);
				delayTimer.start();
			}else super.start();
		}
		
		private function onDelayTimerTick(e:TimerEvent):void 
		{
			delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onDelayTimerTick);
			delayTimer = null;
			super.start();
		}
		
		private function onTick(e:TimerEvent):void {
			
			miliseconds += 35;
			
			if (_targetMC) {
				applyProperties();
				if (params.hasOwnProperty("onUpdate")) {
					if (params.hasOwnProperty("onUpdateParams")) {
						params.onUpdate.apply(null, params.onUpdateParams);
					} else {
						params.onUpdate.apply(null);
					}
				}
				if (miliseconds >= duration) {
					dispose();
				}
			} else {
				dispose();
			}
		}
		
		private function applyProperties():void {
			
			for (var name:String in params) {

				if (targetMC.hasOwnProperty(name)) {
					if (params[name] is Number) {
					
						dx = params[name] - initialObjectparameters[name];
						var tween:Number = this.ease(miliseconds, 0, 1, duration);
						var future:Number = dx*tween;
						
						targetMC[name] = initialObjectparameters[name] + future;
					}
				}
				if (targetMC is DisplayObject) {		
					
					if (name == ("autoAlpha")){
						if (_targetMC.alpha <= 0) {
							targetMC.visible = false;
						}
					} else if (name.indexOf("Filter") != -1) {
						
						var copy:Array = initialObjectparameters["filters"];
						
						var i:int = getFilterPosition((new (getDefinitionByName("flash.filters."+name) as Class)()), initialObjectparameters);
						for (var prop:String in params[name]) {
							if (params[name][prop] is Number) {
								dx = params[name][prop] - initialObjectparameters["filters"][i][prop];
								tween = this.ease(miliseconds, 0, 1, duration);
								//future = miliseconds * dx / _duration;
								future = dx*tween;
								
								if (future is Number) {
									copy[i][prop] = initialObjectparameters["filters"][i][prop] + future;
								}
							}
							
						}
						
						targetMC.filters = copy;
						
						
					}
				}
			}
		}
		
		
		
		public static function to(mc:Object, duration:Number, params:Object, startNow:Boolean = true):STween {
			return new STween(mc, duration, params, startNow);
		}
		
		public static function transformAroundCenter(mc:Object, duration:Number, params:Object):STween {
			
		/*	//(mc as DisplayObject).
			//trace( "(mc as DisplayObject).getRect((mc as DisplayObject).parent).y : " + (mc as DisplayObject).getRect((mc as DisplayObject).parent).y );
			//trace( "(mc as DisplayObject).getRect((mc as DisplayObject).parent).x : " + (mc as DisplayObject).getRect((mc as DisplayObject).parent).x );
			
			//trace( "mc.y : " + mc.y );
			//trace( "mc.x : " + mc.x );
			
			var mv:DisplayObject = mc as DisplayObject;
			
			mc.visible = false;
			mc.alpha = 0;
			if (mc is Sprite) {
				(mc as Sprite).buttonMode = false;
				(mc as Sprite).mouseChildren = false;
				(mc as Sprite).mouseEnabled = false;
			}
			
			var assetLocal:DisplayObject = new DisplayObject();
			mv.parent.addChild(assetLocal);
			assetLocal.x =  (mc as DisplayObject).getRect((mc as DisplayObject).parent).x;
			assetLocal.y = (mc as DisplayObject).getRect((mc as DisplayObject).parent).y;*/
			
			
			
			duration = duration / 4;
			
			return STween.to(mc, duration, { scaleX:1.8,scaleY:1.8 ,onComplete:function():void {
															STween.to(mc, duration, { scaleX:1, scaleY:1 , onComplete: function ():void {STween.to(mc,duration, { scaleX:1.7,scaleY:1.7 ,onComplete:function():void {
															STween.to(mc, duration, params ) }} );}} ) }} );
		}
		
		private function dispose():void {
			this.stop();
			this.removeEventListener(TimerEvent.TIMER, onTick);
			
			if (params.hasOwnProperty("onCompleteParams")) {
				params.onComplete.apply(this, params.onCompleteParams)
			} else if (params.hasOwnProperty("onComplete")) {
				params.onComplete.apply(this);
			}
			
			miliseconds = 0;
			_params = null;
			_options = null;
			targetMC = null;
		}
		
		public function get duration():Number { return _duration; }
		
		public function set duration(value:Number):void 
		{
			_duration = value;
		}
		
		public function get params():Object { return _params; }
		
		public function set params(value:Object):void 
		{
			_params = value;
		}
		
		public function get targetMC():Object { return _targetMC; }
		
		public function set targetMC(value:Object):void 
		{
			_targetMC = value;
		}
		
		public function get options():Object { return _options; }
		
		public function set options(value:Object):void 
		{
			_options = value;
		}
		
		
		
	}

}