package com.jmv.framework.gaming.scenes.manager
{
    import com.jmv.framework.core.managers.base.SManager;
    import com.jmv.framework.errors.SError;
	import com.jmv.framework.events.SEvent;
	import com.jmv.framework.gaming.scenes.base.ISScene;
	import com.jmv.framework.gaming.scenes.transitions.base.ISTransition;
	import com.jmv.framework.utils.IntrospectionUtil;
	import com.jmv.framework.gaming.scenes.transitions.manager.TransitionManager;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.utils.describeType;

    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getQualifiedSuperclassName;

    /**
     * Manages Scene navigation and transitions into a given stage
     *
     * @author MatiX @ sismogames
     */
    public class SceneManager extends SManager
    {
		
		private var _stage:DisplayObjectContainer;
        private var _scenes:Dictionary;
        private var _currentScene:ISScene;
        private var _currentSceneKey:String;
		
		private var _persistedScenes:Array = new Array();
		
		public var transitions:TransitionManager;

        /// Constructor, recieves the stage where the scenes will be showed
        public function SceneManager(stage:DisplayObjectContainer)
        {
            super();
            this._stage = stage;
        }

        override public function initialize():void
        {
            super.initialize();

            // INIT SCENES COLLECTION 
            _scenes = new Dictionary();
			
			// INIT TRANSITIONS MANAGER
			transitions = new TransitionManager(this);
			transitions.initialize();
        }

        override public function dispose():void
        {
            super.dispose();
			_scenes = null;
			transitions.dispose();
			transitions = null;
        }

        /**
         * Switches the current scene with the correspondat scene by the scene given by the key param
         *
         * syntax: switchScene(key:Object,[sceneArg0,[sceneArg1,...[sceneArgN]]])
         *
         * @param key: Object, Scene key previously registered by addScene(key,scene) that identifies the scene to switch to
         *
         * @param sceneArg0,sceneArg1,...sceneArgN:*, parameters to be passed to the Scene contructor as an array
         *
         */
        public function switchScene(key:String, args:Object= null, useTransition:Boolean = true, transitionArgs:Object = null):void
        {
			if (_scenes[key])
            {
				var fromScene:String;
				var toScene:String;
				var fromSnapshot:Bitmap;
				var toSnapshot:Bitmap;
				var transition:ISTransition;
				
				if (!_currentScene) {
					// if no scene loaded first, abort trasitioning
					useTransition = false
				}
				
				if (useTransition) {
					fromScene = _currentSceneKey;
					toScene = key;
					transition = transitions.getTransition(fromScene, toScene);
					if (transition) {
						fromSnapshot = _currentScene.snapshot();
					}
					else {
						useTransition = false;
					}
				}
				
                //if there is an scene registered by the key given 
                if (_currentScene)
                {
                    // if theres a current scene running
                    if (args && args.hasOwnProperty("persistCurrentScene") && args.persistCurrentScene) {
						_currentScene.pause();
						_persistedScenes.push( { key:_currentSceneKey, scene:_currentScene } );
					}
					else{
						// dispose and remove from stage
						dispatchEvent(new SEvent(SEvent.EXIT, _currentSceneKey));
						_currentScene.dispose();
					}
                    _stage.removeChild(_currentScene as DisplayObject);
                }
				
                // instantiate next scene object
				try {
					var fromPersisted:Boolean = false;
					for each (var persistedScene:Object in _persistedScenes) {
						if (persistedScene.key == key) {
							_currentScene = persistedScene.scene as ISScene;
							//trace( "_currentScene : " + _currentScene );
							_currentScene.unpause();
							_persistedScenes.splice(_persistedScenes.indexOf(_currentScene));
							fromPersisted = true;
							break;
						}
					}
					
					if (!fromPersisted) {
						if (args == null)
						{
							// if no scene parameters
								_currentScene = new(Class(_scenes[key])) as ISScene;
						}
						else
						{
							// else pass parameters as an array (contempled in SScene contructor)
							try
							{
								_currentScene = new(Class(_scenes[key]))(args) as ISScene;
							}
							catch (e:Error) {
								_currentScene = new(Class(_scenes[key])) as ISScene;
							}
						}
					}
					dispatchEvent(new SEvent(SEvent.ENTER, key));
				}
				catch (e:Error) {
					throw new SError("Errors Found trying to instantiate the scene \n"+e.message+"\n"+e.getStackTrace()+"\n Possible cause: Object " + _scenes[key] + " is not an ISScene!");
				}
				// set current scene key
				_currentSceneKey = key;
                // add Scene to the stage
                _stage.addChild(_currentScene as DisplayObject);
                // set focus on scene
                _stage.stage.focus = _currentScene as InteractiveObject;
                // initialize scene
				if(!fromPersisted) _currentScene.initialize();
				
				if (useTransition) {
					if (!transitionArgs || !transitionArgs.afterIsLive) toSnapshot = new Bitmap()
					else toSnapshot = _currentScene.snapshot();
					transition.inititalize(fromSnapshot, toSnapshot, _stage, transitionArgs);
					transition.start();
				}
            }
            else
            {
                throw new SError("TRIED TO SWITCH TO UNDEFINED SCENE: '" + key + "'");
            }
        }

        /**
         * Registers an scene Class with an identifiyng KEY object to be instantiated when scene is changed
         *
         * @param key: Object, the identifiying key for the scene
         *
         * @paran scene: Class that defines the scene to be instantiated when switching to the scene given by the key
         * must subclass SScene class or an error will be thrown.
         *
         */
        public function addScene(key:String, scene:Class):void
        {
			var isScene:Boolean = IntrospectionUtil.implementsInterface(scene, ISScene);
			if (!isScene) {
				throw new SError("Class: " + scene + "does not implement the com.jmv.framework.gaming.scenes.base::ISScene interface!!");
			}
			if(!_scenes[key]){
                _scenes[key] = scene;
            }
            else {
                throw new SError("Scene " + key +"already declared!");
            }
        }

        /**
         * Removes an scene previously registered
         *
         * @param key: Object, the identifiying key for the scene to be removed
         *
         */
        public function removeScene(key:String):void
        {
            if (_scenes[key])
            {
                delete _scenes[key];
            }
            else
            {
                throw new SError("TRIED TO DELETE UNDEFINED SCENE: '" + key + "'");
            }
        }
		
		public function sceneExists(key:String):Boolean {
			return _scenes[key] != undefined
		}
		
        /**
         * Returns the currently active scene instance in the stage
         */
        public function get currentScene():ISScene
        {
            return _currentScene;
        }

    }

}

