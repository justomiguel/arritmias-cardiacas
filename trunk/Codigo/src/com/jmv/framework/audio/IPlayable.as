
package com.jmv.framework.audio
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Must be implemented by those classes that are meant
	 * to be registered to the AudioMixer's.
	 */
	public interface IPlayable extends IEventDispatcher
	{
		function get id() : String;
		function set id( id : String ) : void;

		function get length() : Number;
		function get volume() : Number;
		function set volume( vol:Number ) : void;
		function get position() : Number;
		function set position( pos:Number ) : void;
		
		function get paused() : Boolean;
		function get playing() : Boolean;
		function get muted() : Boolean;
		
		function play() : void;
		function resume() : void;
		function pause() : void;
		function stop() : void;
		function loop( times:int = int.MAX_VALUE ) : void;
		function mute() : void;
		function unmute() : void;
		function dispose() : void;
	}
}