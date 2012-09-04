package com.jmv.sbejeweled
{
	
	import com.jmv.framework.audio.AudioManager;
	import com.jmv.framework.audio.IPlayable;
	import com.jmv.framework.audio.PlayableFactory;
	import com.jmv.framework.core.Hub;
	import com.jmv.framework.events.RSLEvent;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.gaming.scenes.transitions.SCrossFadeTransition;
	import com.jmv.framework.tween.STween;
	import com.jmv.framework.ui.SimpleButtonManager;
	import com.jmv.framework.utils.DisplayObjectUtil;
	import com.jmv.sbejeweled.screens.buttons.Btn_MuteON;
	import com.jmv.sbejeweled.screens.buttons.Btn_Mute;
	import com.jmv.sbejeweled._app_.BaseApp;
	import com.jmv.sbejeweled._game_.Game;
	import com.jmv.sbejeweled._game_.players.AbstractPlayer;
	import com.jmv.sbejeweled._game_.ui.AIMousePointer;
	import com.jmv.sbejeweled._settings_.AudioSettings;
	import com.jmv.sbejeweled._settings_.Settings;
	import com.jmv.sbejeweled.screens.*;
	import com.jmv.sloaders.SLoader;
	import com.jmv.sloaders.SLoaderEvent;
	import flash.media.Sound;
	
	import com.jmv.sbejeweled.screens.sismomainscenes.*;
	import flash.display.BitmapData;
	import flash.filters.DropShadowFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	
	
	public class App extends BaseApp
	{
		static private var _instance:App;		
		static public function I():App { return _instance; }
		
		public var myHub:Hub;
		public var buttonmanager:SimpleButtonManager;		
		
		public var audio:AudioManager;
		public var muted:Boolean;
		
		private var audiosettings:AudioSettings;
		public var swfs:Object = {};
		
		private var _game:Game;
		private var _userId:String;
		public var pointer:AIMousePointer;
		
		
		private var _gameIsRunning:Boolean;
		
		
		private var _firsTime:Boolean;
		private var contLoader:int;
		public static const PLAYING:String = "playing";
		public static const PAUSE:String = "pause";
		private var internalStatus:String;
		public static const ON_MENU:String = "on_menu";
		private var instructionLoaded:Boolean;
		private var progressloaded:Number;
		private var totalToLoad:Number;
		
		//public var danone:Array = new Array(0,0);
		
		public function App() {
			
			_instance = this;
			
			setGameIsRunning(false);
			
			super();
			
			
			this.initAudio();			
		}
		
		private function initSettings():void {			
			var url:String = BASE+"data/settings.xml";
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest(url));
			xmlLoader.addEventListener(Event.COMPLETE, onLoadSettingsComplete);
		}
		
		public override function dispose():void {
			
			if (game) game.dispose();
			
			hub.dispose();
			buttonmanager = null;
			
			DisplayObjectUtil.dispose(pointer);
			
			Mouse.show();
			
			for (var id:String in this.swfs) this.swfs[id] = null;
			this.swfs = null;
			
			this.audiosettings.dispose();
			this.audiosettings = null;

			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
			
			super.dispose();
		}
		
		private function initAudio():void
		{
			
			buttonmanager = new SimpleButtonManager(this.buttonRollOver, this.buttonRollOut, this.playRollButton, this.playClickButton);
			
			this.audiosettings = new AudioSettings();
			var factory:PlayableFactory = new PlayableFactory('assets/','mp3');			
			this.audio = new AudioManager(factory);
		}
		
		public function state():String {
			return this.internalStatus;
		}
		
//		TODO: do this mute stuff better...
		public function mute(m:Boolean):void
		{
			this.muted = m;
			if (m) this.audio.mute();
			else this.audio.unmute();
		}
		
		public function fadeIn(id:String):void
		{
			trace( "id : " + id );
			if (this.muted) return;
			var sound:IPlayable = this.audio.retrieve(id);
			if (!sound.playing)
			{
				sound.volume = 0;
				//this.tasks.add(
					//new Tween(
						//sound, 1500, 
						//{ volume: 0.5 } 
					//) 
				//);
				STween.to(sound, 1.5, {volume:0.5})
				sound.loop();
				
			}
		}
		
		public function fadeOut(id:String):void
		{
			if (this.muted) return;
			var sound:IPlayable = this.audio.retrieve(id);
			if (sound.playing)
			{
				//this.tasks.add(
					//new Sequence(
						//new Tween(
							//sound, 1500, 
							//{ volume: 0 } 
						//),
						//new Func(this.stopAudio, id)
					//) 
				//);
				STween.to(sound, 1.5, {volume:0.5, onComplete:stopAudio, onCompleteParams:[id]})
			}
		}
		
		private function stopAudio(id:String):void
		{
			this.audio.retrieve(id).stop();
		}
		
		public function crossFade(idOut:String, idIn:String):void
		{
			this.fadeOut(idOut);
			this.fadeIn(idIn);
		}

//		From BaseApp.as
		protected override function onLoaded():void
		{
			//this.loadAssets();
			
			loadGameAssetsQpack();
		}
		
		public var sloaderGame:SLoader;
		
		private function loadGameAssetsQpack():void{
			
			this.addLoading();
			sloaderGame = new SLoader("GameAssetsLoader");			
			sloaderGame.add(BASE+"assets/screens.swf", "Screens");
				
			sloaderGame.addEventListener(SLoaderEvent.PROGRESS, onLoadGameAssetsProgressQpack, false, 0, true); 
			sloaderGame.addEventListener(SLoaderEvent.COMPLETE, onLoadGameAssetsCompleteQpack, false, 0, true);			
			sloaderGame.loadAll();
		}
		
		
		private function onLoadGameAssetsProgressQpack(e:SLoaderEvent):void{
			this.getLoading().loadAnimations({progressPercent:e.sloader.getPercentLoaded()*100})
		}
		
		private function onLoadGameAssetsCompleteQpack(e:SLoaderEvent):void{
			
			var Screens:* = this.sloaderGame.getContent("Screens");
			this.swfs["Screens"] = Screens;
			
			for each (var musicId:String in this.audiosettings.music)
				this.audio.registerMusic(musicId, this.sloaderGame.getContent(musicId) as Sound);
				
			for each (var sfxId:String in this.audiosettings.sfx)
				this.audio.registerFx(sfxId, this.sloaderGame.getContent(sfxId) as Sound);
			
			onLoadAssetsComplete();
		
		}
		
		
		private function onLibraryError(e:RSLEvent):void {
			//SApli.alert(e.libraryID +" library could not be loaded. ", this, "LIBRARY MISSING");
		}
		
		private function onLibraryLoaded(e:RSLEvent):void {
			//trace("loaded: " + e.libraryID); 
			progressloaded++;
			this.getLoading().loadAnimations({progressPercent:(progressloaded*100/totalToLoad)})
		}
		
		
		private function onLoadInstructionsCompleteWithoutLoad():void {
			instructionLoaded = true;
			hub.dispatch('finishLoad');
		}
		
		private function onLoadInstructionsComplete():void {
			
			instructionLoaded = true;
			hub.dispatch('finishLoad');
		}
		
		
		private function onLoadAssetsCompleteWithoutLoad():void
		{
			this.removeLoadingWithoutLoad(nextStep);
		}
		
		
		private function onLoadSettingsComplete(e:Event = null):void
		{
			var data:XML = new XML(e.target.data);
			settings = new Settings(data);
			this.loadLoading();			
		}
		
		protected override function onBaseComplete():void {
			initSettings();
		}
		
		private function onLoadAssetsComplete():void
		{
			this.removeLoading(nextStep);
			
			
		}
		
		private function nextStep():void {
			this.initScreens();
			this.initMouse();
		}
		
		
		
		//private function loadGameAssets():void
		//{
//
			//this.addLoading();
			//
			//if ((!this.swfs[BASE+"assets/Game.swf"] )&& (!this.swfs[BASE+"assets/UI.swf"])){
				//
				//
				//var g:GroupLoad = new GroupLoad();
				//
				//
				//this.getLoading().resetAnimations();
				//
				//g.addLoader(BASE+"assets/Game.swf").addEventListener(Event.COMPLETE, this.onLoadSwfComplete);
				//g.addLoader(BASE + "assets/UI.swf").addEventListener(Event.COMPLETE, this.onLoadSwfComplete);
				//g.addLoader(BASE+"assets/Transition.swf").addEventListener(Event.COMPLETE, this.onLoadSwfComplete);
				//g.addLoader(BASE+"assets/Screens_Endings2.swf").addEventListener(Event.COMPLETE, this.onLoadSwfComplete);
				//g.addLoader(BASE + "assets/Screens_Endings.swf").addEventListener(Event.COMPLETE, this.onLoadSwfComplete);
				//
				//g.addEventListener(GroupLoadProgressEvent.PROGRESS, onLoadGameAssetsProgress);
				//tasks.add(new Sequence(g, new Func(onLoadGameAssetsComplete)));
			//} else {
				//onLoadGameAssetsCompleteWithoutLoad();
			//}
		//}
		
		private function onLoadGameAssetsCompleteWithoutLoad():void {
			
			this.removeLoadingWithoutLoad(this.game.init);
			
		}
		
		//private function onLoadGameAssetsProgress(e:GroupLoadProgressEvent = null):void {
			//
			//this.getLoading().loadAnimations(e);
			//
		//}

		private function onLoadGameAssetsComplete():void
		{
			this.removeLoading(this.game.init);
			
		}
		
		
		
		
		public function initTextFields(container:DisplayObjectContainer):void
		{
			DisplayObjectUtil.forEachChildren( container, this.initTextField, true );
		}
		
		public function initTextField(obj:DisplayObject):void
		{
			var tf:TextField = obj as TextField;	
			if (tf){
				var s:String = settings.getTextFieldText(tf.name);
				if (s && s != "" ) {
					tf.htmlText = s;
				}
 			}
		}
		
		public function initButton(mc:MovieClip, callback:Function = null):void
		{
			mc.stop();
			var tf:TextField = mc.label as TextField;
			
			if (tf == null) { 
				tf = mc.mctext.label as TextField;
			}
			
			tf.text = settings.getButtonText(mc.name);
			tf.mouseEnabled = false;			
			if (callback != null) this.buttonmanager.addButton( mc, callback );
			tf.textColor = settings.getEfecctsSettings().buttonrolloutcol; 
			
		}
		
		public function removeButton(mc:MovieClip, funct:Function):void {

				mc.removeEventListener(MouseEvent.MOUSE_UP, funct);
		}
		
		public function playClickButton(ev:MouseEvent = null):void
		{
			this.audio.play("sfx/mouse_click");
		}
		
		public function playRollButton(ev:MouseEvent = null):void
		{
			//this.audio.play("sfx/mouse_over");
		}
		
		private function buttonRollOver(mc:MovieClip):void{
			try {
					mc.gotoAndStop(2);
					var tf:TextField = mc.label as TextField;
					if (tf == null) { 
						tf = mc.mctext.label as TextField;
					}
					tf.text = settings.getButtonText(mc.name);
					
					tf.textColor = settings.getEfecctsSettings().buttonrollovercol;
			} catch( e:Error ) {

			}
		}
		
		private function buttonRollOut(mc:MovieClip):void{
			mc.gotoAndStop(1);
			try {	
					if ( mc.label) {
						var tf:TextField = mc.label as TextField;
						tf.textColor = settings.getEfecctsSettings().buttonrolloutcol; 
					}

			} catch  (e:Error ) {
				
			}
		}
		
		private function testDisplayObject(ev:Event):void
		{
			
		}
		
		
		/**
		 * 	SCREENS FSM
		 */
		 
		 
		private function initScreens():void
		{
			//trace( "initScreens : " + initScreens );
			
			
			// INIT SCENES
			scenes.addScene("MainMenuScene", MainMenuScene);
			scenes.addScene("InstructionsScene", InstructionsScene);
			scenes.addScene("GameScene", ArritmiasMainScene);

			
			// SET TRANSITIONS
			SCrossFadeTransition.defaultDuration = 0;
			scenes.transitions.addTransition("MainMenuScene", "GameScene", SCrossFadeTransition);
			scenes.transitions.addTransition("InstructionsScene", "GameScene", SCrossFadeTransition);
			scenes.transitions.addTransition("GameScene", "InstructionsScene", SCrossFadeTransition);
			
			scenes.addEventListener(SEvent.ENTER, onEnterMainMenu);
			scenes.addEventListener(SEvent.ENTER, onEnterGame);
			scenes.addEventListener(GameScene.ENTER_PLAYING, onEnterPlaying)
			scenes.addEventListener(GameScene.EXIT_PLAYING, onExitPlaying)
			
			// GOTO START SCENE
			scenes.switchScene("MainMenuScene", null, false, { afterIsLive:true } );
			
		}
		
		private function onScreenWinGameScene(e:SEvent):void 
		{
			//trace( "App.onScreenWinGameScene > e : " + e );
			if (e.data == "ScreenWinGameScene" || e.data =="ScreenLooseGameScene") {
				this.fadeIn("music/ingame");
			}
		}
		
		
		private function showInstructions(e:Event):void {
			//trace( "App.showInstructions > e : " + e );
			this.fadeOut("music/ingame");
			hub.removeEventListener('finishLoad', showInstructions);
			removeLoading(function():void {hub.dispatch('loadingComplete')})
		}
		
		private function onEnterIntro(e:SEvent):void {
			
			if (e.data == "IntroScene") {
				
			}
		}
		
		private function initMouse():void
		{
			
			//this.pointer = new AIMousePointer();
			//this.pointer.mouseChildren = false;
			//this.pointer.mouseEnabled = false;
			//this.stage.addChild( this.pointer );
			//this.pointer.x = this.mouseX;
			//this.pointer.y = this.mouseY;
			//Mouse.hide();
			//this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
			
		}
				
		private function onMouseMove(ev:MouseEvent):void
		{
			 var myParent:DisplayObjectContainer = pointer.parent;
            if (myParent){
                myParent.setChildIndex(pointer, (myParent.numChildren - 1));
            }
			this.pointer.x = ev.stageX;
			this.pointer.y = ev.stageY;
			Mouse.hide();
		}
		
		private function onEnterMainMenu(e:SEvent):void
		{
			if (e.data == "MainMenuScene") {
				//trace( "onEnterMainMenu : " + onEnterMainMenu );
				setGameIsRunning(false);
				
				//trace( App.I().swfs["sismo"].id);
			
				this.fadeIn("music/ingame");
				//this.crossFade("music/ingame", "music/ingame");
				internalStatus = ON_MENU
			}
			
		}
		
		private function onEnterGame(e:SEvent= null):void
		{
			if (e.data == "GameScene" || !e) {
				
				//this.fadeOut("music/ingame");
				this.crossFade("music/menu", "music/ingame");
				
				if (!this.muted) App.I().audio.retrieve('music/ingame').volume = 0.4;
				//this.loadGameAssets()
			}
			
				
		}

		private function onEnterPlaying(ev:SEvent):void
		{ 
			
			internalStatus = PLAYING;
			
			despausarJuego();
			
		}
		
		private function despausarJuego():void
		{
			this.game.setPause(false);
			
		}
				
		private function onExitPlaying(ev:SEvent):void
		{
			//trace( "App.onExitPlaying > ev : " + ev );
			internalStatus = PAUSE;
			
			this.game.setPause(true);
		}		
		
		
		
		public function get game():Game
		{
			return _game;
		}
		
		public function selectUser(userId:String):void
		{
			this._userId = userId;
		} 	
		
		public function get userId():String
		{
			return this._userId;
		}
		
		public function set game(value:Game):void 
		{
			_game = value;
		}
		
		public function setGameIsRunning(b:Boolean):void {
			_gameIsRunning = b;
		}
	}
}
