package com.jmv.facebar.class_folder {
	import com.jmv.facebar.class_folder.Fbclass;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class FacebookInterface  {
		private static var facebook:FacebookInterface = null;
		//var fbpicture :Sprite;
		private var _root:Sprite;
		
		public function FacebookInterface() {
			
		}
		
		public static function get instance():FacebookInterface {
			if (facebook == null) {
				facebook = new FacebookInterface();
			}
			return facebook;
		}
		
		
		public function fbPicture( root:Sprite, posX:int, posY:int):void {
			
			
		/*	_root = new Sprite();
			_root = root as Sprite;
			var obj_user: Object;
			obj_user = new Object;
			obj_user = Fbclass.instancia.userdata; //usuario logueado a la barra.
					
			var loader:Loader = new Loader();
			loader.addEventListener(Event.COMPLETE, onload_handler);
			
			
			if (obj_user.pic_square) {
					loader.load(new URLRequest(obj_user.pic_square));
			}else{
					loader.load(new URLRequest("assets/FacebookUser.gif"));
			}
			
			//var fbpicture :Sprite = new Fb_img(); //el mc debe estar en la libreria
			fbpicture  = new Fb_img(); //el mc debe estar en la libreria
			_root.addChild(fbpicture);
			fbpicture.y = posY;
			fbpicture.addChild(loader);*/
		
		}
		
		public function removeFbPicture():void {
			//if (fbpicture.parent)_root.removeChild(fbpicture);
		}
		
		private function onload_handler(e:Event):void {
			trace("terminó de cargar imagen FB");
		}
		
		public function updateScore(score:Number, _scoreEncrypt:String, cont:uint):void {
			Fbclass.instancia.setFbScore(score, _scoreEncrypt, cont);
		}
		
		public function updateTiempoInicio():void {
			Fbclass.instancia.updateTiempoInicio();
		}
				
		/**
		 * Informa a la barra que el juego oculta el mouse, para mostrarlo al hacer rollover sobre la misma.
		 * @param	game_catch_mouse
		 */
		public function catch_mouse(game_catch_mouse:Boolean):void {
			Fbclass.instancia.catch_mouse = game_catch_mouse;
		}
	}
	
}