package  com.jmv.facebar.class_folder{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Fbclass {
		
		private static var _instance:Fbclass= null;
		private var facebook:Object;
		
		private var myscore:uint;
		private var mypause:uint;
		private var avatar:Object;
		private var fbuser:Object;
		private var api_key:String;
		private var _catch_mouse:Boolean;
		
		public function Fbclass(){	
			
		}
		/**
		 * 
		 */
		public static function get instancia():Fbclass{
			if(_instance == null){
				_instance= new Fbclass();
				
			}else{
				//trace("Singleton  FUNCIONA - swf");
			}
			return _instance;
		}
		
		
		
		public function get facebookInstance():Object {
			return new Object; 	
		}
		
		public function get userdata(): Object {
			
			var obj: Object = new Object();
			obj.pic_square = "FacebookUser.gif";
			obj.uid = "";
			return obj;	
		}
		
		public function get apiKey():String {
			return api_key;
		}
		
		public function setFbScore(_score:Number, _scoreEncrypt:String, pause:uint):void	{
			//actualiza el puntaje de la barra.	
			//myscore = _score;
			//mypause = pause;
			//trace( "GAME myscore : " + myscore );
			//trace( "GAME apiKey : " + apiKey );
			//trace( "GAME pause : " + mypause );
		//
			//PHPconnection.instancia.updateScore(this.userdata.uid, myscore, apiKey, mypause);		
		}
		
		public function updateTiempoInicio():void {
			//trace( "updateTiempoInicio : " + updateTiempoInicio );
		}
		
		public function updateAvatar(_avatar:Object):void{
			avatar = new Object();
			avatar = _avatar;
			
		}
		
		public function set catch_mouse(catchmouse:Boolean):void{
			_catch_mouse = catchmouse;
		}
		
		public function get catch_mouse():Boolean{
			return _catch_mouse;
		}
	
		
		
		
	}
	
}