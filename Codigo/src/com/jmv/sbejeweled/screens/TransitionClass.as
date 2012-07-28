package com.jmv.sbejeweled.screens 
{
	import com.jmv.sbejeweled.screens.Mask;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	
	
	
	public class TransitionClass extends MovieClip {
		
		public static var instance:TransitionClass;
		private var _functionToDo:Function;
		private var myBeforePicture:Bitmap;
		private var myBeforeBitmap:BitmapData;
		private var sprite:Sprite;
		public var transFX:MovieClip;
		private var Maskara:Mask;
		
		
		public function TransitionClass() {
			
		}
		
		public static function getInstance():TransitionClass {
			if (!instance)
				instance = new TransitionClass();
			return instance;
		}
		
		
		public function takePicture(asset:DisplayObject, parent:Sprite):Boolean {

			
			if (myBeforePicture){
				sprite = new Sprite();
				
				transFX = new TransitionFx();
				transFX.cacheAsBitmap = true;
				
				Maskara = new Mask();
				
				sprite.addChild(myBeforePicture);
				parent.addChild(Maskara);
				parent.addChild(sprite);
				
				sprite.mask = Maskara;
				Maskara.x = 0;

				if (transFX.guia) {
					Maskara.x = transFX.guia.x;
					Maskara.y = transFX.guia.y;
				}
				
				
				parent.addChild(transFX);
				
				
				
			
				transFX.stop();
				transFX.y = 0;
				return false;
			} else {
				return true;
			}
		}
		
		
		public function takeEndingPicture(asset:DisplayObject, parent:Sprite):void {

			
			if (myBeforePicture) {
				
				sprite = new Sprite();
				
				transFX = new FinalTransition();
				transFX.cacheAsBitmap = true;
								
				sprite.addChild(myBeforePicture);
				
				
				sprite.mask = (transFX as FinalTransition).maskara;
				parent.addChild(sprite);
				
				parent.addChild(transFX);
				
				
				
			
				transFX.stop();
				transFX.maskara.stop();
				transFX.y = 0;
			}
		}
		
		
		public function savePicture(asset:DisplayObject):void {
	
			myBeforeBitmap = new BitmapData(asset.width, asset.height, true);
			myBeforeBitmap.draw(asset);
			myBeforePicture = new Bitmap(myBeforeBitmap);
			
		}

		
		public function doFade( finishMotionFunc:Function = null):void {
			_functionToDo = finishMotionFunc;
				if (myBeforePicture) {
					
					transFX.gotoAndPlay(1);
					
					transFX.addEventListener(Event.ENTER_FRAME, finishTweenLite);
					 
				}
		}
		
		public function doLastFade( finishMotionFunc:Function = null):void {
			_functionToDo = finishMotionFunc;
				if (myBeforePicture) {
					
					transFX.gotoAndPlay(1);
					try {
						(transFX as FinalTransition).addEventListener(Event.ENTER_FRAME, finishLastFade);
					} catch (err:TypeError){
						
					}
					 
				}
		}
		
		private function finishLastFade(e:Event):void {
			if (transFX) {
				if (transFX.currentFrame == transFX.totalFrames) {
					
					try {
						(transFX as FinalTransition).removeEventListener(Event.ENTER_FRAME, finishLastFade);
						removePictures();
				
					} catch (err:TypeError){
						
					}
				}
			}
		}
		
		
		
		
		public function finishTweenLite(e:Event):void {

			if (transFX) {
				if (transFX.getChildByName("guia") != null) {
					Maskara.x = transFX.guia.x;
					Maskara.y = transFX.guia.y;
				}
				
				if (transFX.currentFrame == transFX.totalFrames) {
					transFX.removeEventListener(Event.ENTER_FRAME, finishTweenLite); 
					removePictures();
					
				}
			}
		}
		
		private function removePictures():void {
			
				if (myBeforeBitmap) {
				myBeforeBitmap.dispose();
				myBeforeBitmap = null;
				}
			
			if (transFX) {
				if (transFX.parent) {
					transFX.parent.removeChild(transFX);
					transFX = null;
				}
			}
			

			if (Maskara){
				if (Maskara.parent) {
					Maskara.parent.removeChild(Maskara);
					Maskara = null;
				}
			}
			
			if (myBeforePicture){
				if (myBeforePicture.parent) {
					myBeforePicture.parent.removeChild(myBeforePicture);
					myBeforePicture = null;
				}
			}
			if (sprite) {
				if (sprite.parent) {
				sprite.parent.removeChild(sprite);
				sprite = null;
			}
			}
			
			
			if (_functionToDo != null){
						_functionToDo.call(this);
			}
		}
	}

}