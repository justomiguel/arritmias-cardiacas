package com.jmv.facebar.class_folder{
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class PHPconnection 
	{
		
		
		private var _caller:Object;
		private static var _instance:PHPconnection = null;
	
		
		public function PHPconnection() 
		{
			
		}
		
		public static function get instancia():PHPconnection{
			if(_instance == null){
				_instance= new PHPconnection;
				//_instance= this;
			}
			return _instance;
		}	
	
		public function updateScore(uid:Number, score:Number, apikey:String, pause:uint):void{
			
			//var callDetails:Object = {
		        // Required Parameters
		        //serviceClass: "DBbar",
		        //method: "UpdateUser",
		        //args: [uid, score],
		        //resultHandler: updateScoreResultHandler,
		        //progressHandler: progressHandler,
		        //timeoutHandler: timeoutHandler,
		        //faultHandler: faultHandler,
		        //debug: true
			//}
			//_swx.call(callDetails);
			
		}

	}
	
}