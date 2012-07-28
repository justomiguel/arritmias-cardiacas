package com.jmv.sbejeweled._app_
{
	import com.jmv.sbejeweled.FSDLoadTracker;
	import com.jmv.sbejeweled.FSDLoader;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;

	
	 
	public class FSDApp extends BaseApp
	{
		public var fsdLoader:FSDLoader;
		private var fsdLoadTracker:FSDLoadTracker;
		private const fsdGameID:String = "???";
		private const fsdFeedbackObject:String = "???";
		
		public function FSDApp()
		{
			super();
		}		
		
		public override function dispose():void
		{
			if (this.fsdLoader != null)
			{
				this.removeChild(fsdLoader);
				this.fsdLoader = null;
			}
			super.dispose();
		}
		
		public function submitScore(score:int):void
		{
			fsdLoader = new FSDLoader(fsdGameID, fsdFeedbackObject, score);
			
			fsdLoader.x = this.WIDTH*.5;
			fsdLoader.y = this.HEIGHT*.5;
			
			fsdLoader.addEventListener(Event.COMPLETE, fsdLoadComplete);
			fsdLoader.addEventListener(ProgressEvent.PROGRESS, fsdLoadProgress);
			fsdLoader.addEventListener(FSDLoader.FSD_PLAYAGAIN, fsdPlayAgain);
			fsdLoader.addEventListener(FSDLoader.FSD_ERRORDISPLAY, errorComplete);
			
			this.fsdLoadTracker = new FSDLoadTracker();
			this.fsdLoadTracker.x = this.WIDTH*.5;
			this.fsdLoadTracker.y = this.HEIGHT*.5;
			
			this.addChild(fsdLoadTracker);
			this.addChild(fsdLoader);
		}
		
		final private function fsdLoadProgress( event: ProgressEvent ): void
		{
			var p:Number = event.bytesLoaded/event.bytesTotal;
			log( "Game received FSD ProgressEvent.PROGRESS " + p );
			this.fsdLoadTracker.masc.width = p * this.fsdLoadTracker.bar.width;
		}
		
		final private function fsdLoadComplete( event: Event ): void
		{
			log( "Game Received FSD Event.COMPLETE" );
			this.fsdLoadTracker.cleanup();
			this.removeChild(this.fsdLoadTracker);
			this.fsdLoadTracker = null;
		}
		
		public function fsdPlayAgain( event: Event ): void
		{			
			log( "Game Received FSDLoader.FSD_PLAYAGAIN" );
			this.cleanupFSDLoader();	
		}		
		
		final private function errorComplete( event: Event = null ): void
		{
			log( "User sees Disney's error message." );
			log( "Provide an 'OK' button to restart the app." );
		}		
		
		public function cleanupFSDLoader():void
		{
			if (this.fsdLoader != null)
			{
				this.removeChild(fsdLoader);
				this.fsdLoader = null;
			}
		}
	}
}