package com.jmv.sbejeweled._game_._board_.chips
{
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.App;
	import com.jmv.sbejeweled._game_._board_.Board;
	import com.jmv.sbejeweled._game_._board_.Tile;
	import com.jmv.sbejeweled._game_.effects.AbstractEffect;
	import com.jmv.sbejeweled._game_.effects.BigExplotion;
	import com.jmv.sbejeweled._game_.effects.CoverChip;
	import com.jmv.sbejeweled._game_.effects.Explotion;
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	 
	public class AbstractChip extends MovieClip
	{
		protected var _swappeable:Boolean;
		protected var _destroyable:Boolean;
		public var type:String;
		protected var _coverChip:CoverChip;
		protected static const ACC:Number = 0.006;
		private var stateLoopValues:Object = {
			                                    entry:false,
			                                    entryend:false,
			                                 	stable:true,
			                                 	rollover:false,
			                                 	selected:true
		                                     };
		
		public function AbstractChip()
		{
			super();
			this.setState('stable');
		}
		
		public function addCoverChip():void
		{
			if (this._coverChip)
				this._coverChip.dispose();
			if (this.getChildAt(0))
				this.getChildAt(0).visible = false;
			else
			{
				this.addEventListener(Event.RENDER, this.onRender, false, 0, true);
				this.stage.invalidate();
			}
			this._coverChip = new CoverChip();
			this._coverChip.setState( this.currentLabel );
			this.addChild( this._coverChip );
		}
		
		private function onRender(ev:Event):void
		{
			if (this.getChildAt(0))
				this.getChildAt(0).visible = false;
			this.removeEventListener(Event.RENDER, this.onRender);
		}
		
		public function removeCoverChip():void
		{
			if (!this._coverChip) return;
			if (this.getChildAt(0)) this.getChildAt(0).visible = true;
			var label:String = this._coverChip.currentLabel;
			this._coverChip.dispose();
			this._coverChip = null;
			this.setState( label );
		}
		
		public function get state():String
		{
			if (this._coverChip) return this._coverChip.currentLabel;
			return this.currentLabel;
		}
		
		public function fallTo(oldTile:Tile, tile:Tile, timeMult:int, appear:Boolean = false, proxFuncion:Object = null):STween
		{
			var deltay:Number = tile.getChipY() - this.y;
			var time:Number = Math.sqrt( 2*deltay/ACC )*timeMult;
			
			var abstarc:AbstractChip = this;
			
			var next:Function = function():void {
				if (!proxFuncion) {
					//trace("aun nooooooooo");
					STween.to(abstarc, (time+200)/1000, {y:tile.getChipY(),transition:"circeaseout", onComplete:changeTile, onCompleteParams:[oldTile, tile, appear]}, true)
				} else {
					//trace("vamossssssssssssssssss");
					STween.to(abstarc, (time+200)/1000, {y:tile.getChipY(),transition:"circeaseout", onComplete:function():void{STween.to(abstarc, 0.1, { onStart:changeTile,transition:"circeaseout", onStartParams:[oldTile, tile, appear], onComplete:proxFuncion.fun } );}}, true)
				}
			}
			
			if (appear){
				this.alpha = 0;
				this.setState('entry');
				//task = new Tween( this, 500 * timeMult, { alpha:1 }, { transition:'easeOut' } ) as Task;
				//return STween.to(abstarc, 650 * timeMult/1000, { alpha:1 ,transition:"circeaseout", onComplete:next}, true );
				return STween.to(abstarc, time/1000, { alpha:1 ,transition:"circeaseout", onComplete:next}, true );
				//TODO add stars in container
			} else {
				//task = new Wait(400 * timeMult) as Task;
				 return STween.to(abstarc,100 * timeMult/1000, { onComplete:next ,transition:"circeaseout"}, true );
			}
			
			//return new Sequence(
			                      //task,
			                      
			                   //);
							   
		}
		
		protected function changeTile(oldTile:Tile, tile:Tile, appear:Boolean):void
		{
			//trace("change tile "+changeTile);
			if (oldTile && oldTile.currentChip == this ) oldTile.setChip( null );
			if (appear){
				this.setState('entryend');
			}else{
				this.setState('stable');
			}
			tile.setChip( this );
		}
			
		public function getType():String
		{
			return this.type;
		}
		
		public function isSwappealble():Boolean
		{
			return this._swappeable
		}
		
		public function isDestroyable():Boolean
		{
			return this._destroyable;
		}
		
		public function remove(bigExplode:Boolean = false):void
		{
			this.visible = false;			
			var board:Board = App.I().game.level.userBoard;
			var explotion:AbstractEffect =  new BigExplotion ;
			explotion.addEventListener(Event.COMPLETE, this.dispose, false,0,true);
			board.addEffect(explotion, this.x, this.y);
		}
		
		private function onEnterFrame(ev:Event):void
		{
			if (this.numChildren == 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
				return;
			}
			var mc:MovieClip = this.getChildAt(0) as MovieClip;
			if (mc && mc.currentFrame == mc.totalFrames){
				mc.stop();
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			}
		}
		
		public function dispose(e:Event = null):void
		{
			
			if (this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			if (this.hasEventListener(Event.RENDER))
				this.removeEventListener(Event.RENDER, this.onRender);
			if (this._coverChip)
				this._coverChip.dispose();
			this._coverChip = null;
			
			DisplayObjectUtil.dispose(this);
		}
		
		public function setState(label:String):void
		{
			if (this._coverChip)
			{
				this._coverChip.setState(label);
				return;
			}
			
			var loop:Boolean = this.stateLoopValues[label] as Boolean;
			
			if (this.hasEventListener(Event.ENTER_FRAME))
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			this.gotoAndStop(label);
			if (this.numChildren == 0){
				return;
			} 
			if (!loop){
				this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
			}
		}
	}
}
