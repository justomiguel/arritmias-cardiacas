package com.jmv.framework.gaming.scenes.base 
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	
	/**
	 * ...
	 * @author 
	 */
	public class Timeline
	{
		
		private var mc:MovieClip
		
		public function Timeline(mc:MovieClip) 
		{
			this.mc = mc;		
		}
		
		public function get currentFrame () : int {
			return mc.currentFrame;
		}

		public function get currentFrameLabel () : String {
			return mc.currentFrameLabel;
		}

		public function get currentLabel () : String {
			return mc.currentLabel;
		}

		public function get currentLabels () : Array {
			return mc.currentLabels;
		}

		public function get currentScene () : Scene {
			return mc.currentScene;
		}

		public function get enabled () : Boolean {
			return mc.enabled
		}
		
		public function set enabled (value:Boolean) : void {
			mc.enabled = value;
		}

		public function get framesLoaded () : int {
			return mc.framesLoaded;
		}

		public function get scenes () : Array {
			return mc.scenes
		}

		public function get totalFrames () : int {
			return mc.totalFrames;
		}

		public function get trackAsMenu () : Boolean {
			return mc.trackAsMenu
		}
		
		public function set trackAsMenu (value:Boolean) : void {
			mc.trackAsMenu = value;
		}

		public function addFrameScript (frame:int, method:Function) : void {
			mc.addFrameScript(frame, method);
		}

		public function gotoAndPlay (frame:Object, scene:String = null) : void 
		{
			mc.gotoAndPlay(frame, scene);
		}

		public function gotoAndStop (frame:Object, scene:String = null) : void {
			mc.gotoAndStop(frame, scene);
		}

		public function nextFrame () : void {
			mc.nextFrame();
		}

		public function nextScene () : void {
			mc.nextScene();
		}
		
		public function play () : void {
			mc.play();
		}

		public function prevFrame () : void {
			mc.prevFrame();
		}

		public function prevScene () : void {
			mc.prevScene();
		}

		public function stop () : void {
			mc.stop();
		}
		
		public function getMovieClip():MovieClip {
			return mc;
		}
		
	}

}