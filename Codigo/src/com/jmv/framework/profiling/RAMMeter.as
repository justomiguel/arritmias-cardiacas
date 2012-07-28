package com.jmv.framework.profiling 
{
	import com.jmv.framework.math.SMath;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	
	[Embed (source="/./com/sismogames/framework/_assets/core_assets.swf", symbol="framework.assets.RAMMeter")]
	public class RAMMeter extends Sprite
	{
		
		// assets
		public var graph:Sprite;
		public var ram_txt:TextField;
		
		private var scale:Number
		
		private var currentMemoryMB:Number = 0;
		private var maxMemoryMB:Number = 0;
		
		private var currentX:Number = 0;
		private var topGraphMemoryMB:Number = 50;
		
		
		private var graph_init_width:Number = 0;
		private var g:Graphics;

		public function RAMMeter(scale:Number = 1)
		{
			super();
			
			this.scale = scale
			
			graph_init_width = graph.width;
			
			g = graph.graphics;
			reset()
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function reset():void {
			g.clear();
			g.lineStyle(2, 0xffffff, 1);
			g.moveTo(0, currentMemoryMB*scale);
			currentX = 0;
		}
		
		protected function draw():void {
			if (currentX >= graph_init_width) reset();
			
			if (currentMemoryMB > maxMemoryMB) {
				maxMemoryMB = currentMemoryMB;
				graph.getChildByName("max").y = maxMemoryMB*scale
			}
			
			g.lineTo(currentX, currentMemoryMB*scale);
			currentX++;
		}
		
		protected function update(e:Event = null):void {
			currentMemoryMB = System.totalMemory / 1024 / 1024;
			ram_txt.text = SMath.round(currentMemoryMB) + " MB";
			DisplayObjectUtil.bringToFront(this);
			draw();
		}
		
	}

}