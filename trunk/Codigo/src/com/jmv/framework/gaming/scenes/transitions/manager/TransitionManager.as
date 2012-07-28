package com.jmv.framework.gaming.scenes.transitions.manager {
	import com.jmv.framework.core.managers.base.SManager;
	import com.jmv.framework.errors.SError;
	import com.jmv.framework.gaming.scenes.base.ISScene;
	import com.jmv.framework.gaming.scenes.base.SScene;
	import com.jmv.framework.gaming.scenes.manager.SceneManager;
	import com.jmv.framework.gaming.scenes.transitions.base.ISTransition;
	import com.jmv.framework.utils.IntrospectionUtil;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class TransitionManager extends SManager{

		private var _sceneManager:SceneManager;
		
		private var _transitions:Dictionary;

		public function TransitionManager(sceneManager:SceneManager) {
			this._sceneManager = sceneManager;
		}
		
		public function addTransition(fromScene:String, toScene:String, transition:Class):void {
			if (!IntrospectionUtil.implementsInterface(transition, ISTransition)) throw new SError(fromScene + " is not a ISTransition !");
			if(!_sceneManager.sceneExists(fromScene)) throw new SError(fromScene + " is not registered!");
			if(toScene != "*" && !_sceneManager.sceneExists(toScene)) throw new SError(toScene+ " is not registered!");
			
			
			if (!_transitions[fromScene]) {
				_transitions[fromScene] = new Array();
			}
			(_transitions[fromScene] as Array).push( { toScene:toScene, transition:transition } );
		}
		
		public function removeTransition(fromScene:String, toScene:String):void {
			if (!_transitions[fromScene]) {
				return
			}
			else {
				var sceneTransitions:Array = _transitions[fromScene] as Array;
				for (var i:int = 0; i < sceneTransitions.length; i++) {
					var item:Object = sceneTransitions[i];
					if (item.toScene == toScene) {
						sceneTransitions.splice(i);
						return 
					}
				}
			}
		}
		
		public function getTransition(fromScene:String, toScene:String):ISTransition {
			if (!_transitions[fromScene]) {
				return null;
			}
			else {
				var sceneTransitions:Array = _transitions[fromScene] as Array;
				for (var i:int = 0; i < sceneTransitions.length; i++) {
					var item:Object = sceneTransitions[i];
					if (item.toScene == toScene || item.toScene == "*") {
						var transClass:Class = item.transition as Class
							return new transClass() as ISTransition;
					}
				}
			}
			return null;
		}
		
		override public function initialize():void {
			super.initialize();
			_transitions = new Dictionary();
		}

		override public function dispose():void {
			super.dispose();
			_transitions = null;
			_sceneManager = null;
		}

	}

}

