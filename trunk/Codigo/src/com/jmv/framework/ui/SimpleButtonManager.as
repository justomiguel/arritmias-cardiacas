package  com.jmv.framework.ui {
	
	import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Miguel
	 */
	
	public class SimpleButtonManager extends Object {
	
		public var rollOutEffect:Function;
        public var rollOverEffect:Function;
        public var playRollOverSound:Function;
        public var playClickSound:Function;
		
		public function SimpleButtonManager(rollOverEffect1:Function = null, rollOutEffect1:Function = null, playRollOverSound1:Function = null, playClickSound1:Function = null) {
			super();
			this.rollOverEffect = rollOverEffect1;
            this.rollOutEffect = rollOutEffect1;
            this.playRollOverSound = playRollOverSound1;
            this.playClickSound = playClickSound1;
			
		}
		
		private function _onRollOver(colorTransform:MouseEvent) : void {
         
			if (playRollOverSound != null) {
                playRollOverSound();
            }
			
            if (rollOverEffect != null) {
                rollOverEffect(colorTransform.currentTarget);
            } else {
                InteractiveObject(colorTransform.currentTarget).transform.colorTransform = new ColorTransform(2.2, 2.2, 2.2);
            }
			
        }

        private function _onRollOut(colorTransform:MouseEvent) : void{
           
			if (rollOutEffect != null){
                rollOutEffect(colorTransform.currentTarget);
            }else{
                InteractiveObject(colorTransform.currentTarget).transform.colorTransform = new ColorTransform();
            }
			
        }

        public function addButton(myBtn:InteractiveObject, fun:Function = null) : void {
            
			if (myBtn == null){
                return;
            }

            if (myBtn is Sprite){
                Sprite(myBtn).buttonMode = true;
            }
			
			if (myBtn is MovieClip) {
				MovieClip(myBtn).buttonMode = true;
				MovieClip(myBtn).gotoAndStop(1);
			}
            
			if (fun != null) {
                myBtn.addEventListener(MouseEvent.CLICK, fun);
            }
			
            if (playClickSound != null) {
                myBtn.addEventListener(MouseEvent.CLICK, playClickSound);
            }
			
            myBtn.addEventListener(MouseEvent.ROLL_OVER, _onRollOver, false, 0, true);
            myBtn.addEventListener(MouseEvent.ROLL_OUT, _onRollOut, false, 0, true);
			
        }
		
		public function addNamedButton(mc:InteractiveObject, buttonTitle:String, callback:Function = null, textColor:uint = 0):void {
			
			if (mc is MovieClip) MovieClip(mc).stop();
			
			var tf:TextField = MovieClip(mc).label as TextField;
			
			if (tf) {
				tf.text = buttonTitle;
				tf.mouseEnabled = false;	
			} else {
				throw new Error("A Textfield is Missing -- The button must have a textfield called 'label' inside");
			}
			
			if (callback != null) this.addButton( mc, callback );
			
			//if (textColor) tf.textColor = textColor;
			
		}

        public function removeButton(myBtn:InteractiveObject, fun:Function = null) : void {
            if (myBtn is Sprite){
                Sprite(myBtn).buttonMode = false;
            }
			
            if (fun != null){
                myBtn.removeEventListener(MouseEvent.CLICK, fun);
            }
			
            if (playClickSound != null) {
                myBtn.removeEventListener(MouseEvent.CLICK, playClickSound);
            }
			
            myBtn.removeEventListener(MouseEvent.ROLL_OVER, _onRollOver);
            myBtn.removeEventListener(MouseEvent.ROLL_OUT, _onRollOut);
            return;
        }
		
	}

}

