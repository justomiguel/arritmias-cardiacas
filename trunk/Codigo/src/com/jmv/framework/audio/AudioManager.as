

package com.jmv.framework.audio
{
	import flash.events.EventDispatcher;

	/**
	 * Manipulates the interaction between IPlayable's and AudioMixer's
	 * @see IPlayable
	 * @see AudioMixer
	 * 
	 * @example How to create an AudioManager
	 * <listing version="3.0">
	 * // Using default PlayableFactory
	 * var manager : AudioManager = new AudioManager();
	 * // Adding a custom PlayableFactory (specify base url and extension)
	 * var factory : PlayableFactory = new PlayableFactory('assets/','mp3');
	 * var manager : AudioManager = new AudioManager( factory );
	 * </listing>
	 * 
	 * @example How to register an IPlayable to an AudioMixer
	 * <listing version="3.0">
	 * // Register a Sound object (embeded or manually created)
	 * var boing : Sound = new Sound( new URLRequest('assets/boing.mp3') );
	 * manager.registerFx( 'boing', boing );
	 * // Register the straight url (starts loading on the first play()).
	 * manager.registerFx( 'boing', 'assets/boing.mp3' );
	 * // If we specified base and extension on the factory and 
	 * // the id IS the file name, then we can omit it.
	 * manager.registerFx( 'boing' );
	 * // Register a playlist (same options apply to EACH item of the array)
	 * manager.registerFx( 'sequence', ['kick','shout','run'] );
	 * // Register an IPlayable (Audio,Playlist,etc)
	 * manager.registerFx( 'boing', new Audio(boing) );
	 * </listing>
	 * 
	 * @example How to interact with the registered assets
	 * <listing version="3.0">
	 * // Manipulate them by id, on the right AudioMixer
	 * manager.fx.loop( 'sequence', 5 );
	 * manager.music.play( 'bg_music' );
	 * manager.music.pause( 'another_song' );
	 * // Affect more than one by using many ids
	 * manager.fx.play( 'kick, shout' );
	 * // Affect EVERY registered asset
	 * manager.fx.stop();
	 * manager.music.masterVolume = 0.5;
	 * // The same methods can be found on the manager, they affect all the mixers
	 * // No error will be thrown by the AudioMixers for unknown ids.
	 * // So you can just use the manager's methods.
	 * manager.resume( 'another_song, kick, boing' );
	 * </listing>
	 */

	public class AudioManager extends EventDispatcher
	{
		/**
		 * Contains the music Audios
		 */
		public var music : AudioMixer;
		
		/**
		 * Contains the sound effects Audios
		 */
		public var fx : AudioMixer;
		
		protected var factory : PlayableFactory;
		
		/**
		 * Most methods are chainable
		 * http://en.wikipedia.org/wiki/Fluent_interface
		 */
		public function AudioManager( factory : PlayableFactory = null )
		{
			super(this);
			
			this.factory = factory || new PlayableFactory();
			
			this.music = new AudioMixer();
			this.fx = new AudioMixer();
		}
		
		/**
		 * Adds a new Audio to the sounds effects AudioMixer.
		 * 
		 * @param id A unique name for this Audio to be used afterwards on the AudioMixer
		 * @param snd A Sound instance.
		 * 
		 * @see #fx
		 * @see flash.media.Sound 
		 */
		
		public function registerFx( id : String, asset : * = null, options : Object = null  ) : AudioManager
		{
			register( fx, id, asset, options );
			return this;
		}
		
		/**
		 * Adds a new Audio to the music AudioMixer.
		 * 
		 * @param id A unique name for this Audio to be used afterwards on the AudioMixer
		 * @param snd A Sound instance.
		 * 
		 * @see #music
		 * @see flash.media.Sound 
		 */
		
		public function registerMusic( id : String, asset : * = null, options : Object = null  ) : AudioManager
		{
			register( music, id, asset, options );
			return this;
		}
		
		protected function register( mixer : AudioMixer, id : String, asset : *, options:Object ) : void
		{
			if( asset == null )
				asset = id; // the id is the URI

			var playable : IPlayable = factory.create( asset, options );
			playable.id = id;
			mixer.add( playable );
		}
		
		protected function delegate( method : String, args : Array ) : AudioManager
		{
			fx[method].apply( fx, args );
			music[method].apply( music, args );
			return this;
		}
		
		public function play( id : String = null ) : AudioManager
		{
			return delegate( 'play', arguments );
		}
		
		public function loop( id : String = null, times:int = int.MAX_VALUE ) : AudioManager
		{
			return delegate( 'loop', arguments );
		}
		
		public function resume( id : String = null ) : AudioManager
		{
			return delegate( 'resume', arguments );
		}
		
		public function stop( id : String = null ) : AudioManager
		{
			return delegate( 'stop', arguments );
		}

		public function pause( id : String = null ) : AudioManager
		{
			return delegate( 'pause', arguments );
		}
		
 		public function mute( id : String = null ) : AudioManager
		{
			return delegate( 'mute', arguments );
		}
		
		public function unmute( id : String = null ) : AudioManager
		{
			return delegate( 'unmute', arguments );
		}
		
		public function gain( id : String = null ) : AudioManager
		{
			return delegate( 'gain', arguments );
		}
		
		public function remove( id : String = null, dispose:Boolean = false ) : AudioManager
		{
			return delegate( 'remove', arguments );
		}
		
		public function has( id : String ) : Boolean
		{
			return music.has( id ) || fx.has( id );
		}
		
		public function retrieve( id : String ) : IPlayable
		{
			return music.retrieve( id ) || fx.retrieve( id );
		}
		
		public function get masterVolume() : Number
		{
			// Only retrieve it if it's normalized to one single value
			return fx.masterVolume == music.masterVolume ? fx.masterVolume : NaN;
		}
		
		public function set masterVolume( num : Number ) : void
		{
			fx.masterVolume = music.masterVolume = num;
		}
	}
}
