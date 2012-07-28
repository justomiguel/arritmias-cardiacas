package com.jmv.framework.core {
	import com.jmv.framework.log.Alert;
	import com.jmv.framework.events.RSLEvent;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.gaming.scenes.manager.SceneManager;
	import com.jmv.framework.log.LogManager;
	import com.jmv.framework.rsl.BatchRSLLoader;
	import com.jmv.framework.rsl.RSLLoader;
	import com.jmv.framework.sound.manager.SoundManager;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	//[Frame (factoryClass="com.jmv.framework.core.ApplicationFactory")]
	public class SApplication extends SStage implements IInitializable, IDisposable {
		
		public static var application:SApplication;		
		private var _hub:Hub;
		private var _scenes:SceneManager;
		private var _rsl:BatchRSLLoader;
		public var currentApplicationDomain:ApplicationDomain = ApplicationDomain.currentDomain;
		private var _logger:LogManager;
		private var _sound:SoundManager;
		
		public function SApplication() 
		{
			if (stage) this.initialize();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.initialize();
		}
		
		/* INTERFACE com.jmv.framework.core.IInitializable */
		
		public function initialize():void
		{
			SApplication.application = this;
			stage.showDefaultContextMenu = false;
			autoMaskingEnabled = true;
		}
		
		public static function alert(message:String, source:Object = null, title:String = null, duration:Number = -1):Alert {
			if (application) {
				return application.logger.alert(message, source, title, duration);
			}
			return null
		}
		
		/* INTERFACE com.jmv.framework.core.IDisposable */
		
		public override function dispose():void
		{
			if (_hub) _hub;
			if (_logger) _logger.dispose();
			if (_rsl) _rsl.dispose();
			if (_scenes) _scenes.dispose();
			if (_sound) _sound.dispose();
		}
		
		private var automasking:Boolean = false;
		
		public function set autoMaskingEnabled(value:Boolean):void 
		{
			if (value) {
				var msk:Shape = new Shape()
				msk.graphics.beginFill(0, 1);
				msk.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				msk.graphics.endFill();
				addChild(msk);
				this.mask = msk;
			}
			else {
				mask = null
			}
			
			automasking = value;
		}
		
		public function get autoMaskingEnabled():Boolean
		{ return automasking; }
		
		public function get hub():Hub { 
			if (!_hub) {
				_hub = new Hub();
			}
			return _hub; 
		}
		
		public function get scenes():SceneManager { 
			if (!_scenes) {
				_scenes = new SceneManager(this);
				_scenes.initialize();
			}
			return _scenes; 
		}
		
		public function get rsl():BatchRSLLoader { 
			if (!_rsl) {
				_rsl = new BatchRSLLoader();
				_rsl.initialize();
			}
			return _rsl;
		}
		
		public function get logger():LogManager { 
			if (!_logger) {
				_logger = new LogManager(this);
				_logger.initialize();
			}
			return _logger; 
		}
		
		public function get sound():SoundManager { 
			if (!_sound) {
				_sound = new SoundManager();
				_sound.initialize();
			}
			return _sound; 
		}
	}
	
}