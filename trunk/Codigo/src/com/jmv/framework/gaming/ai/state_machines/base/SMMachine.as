package com.jmv.framework.gaming.ai.state_machines.base 
{
	import com.jmv.framework.gaming.ai.state_machines.base.SMTransition;
	import com.jmv.framework.gaming.ai.state_machines.base.SMState;
	import com.jmv.framework.core.SStage;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Facu
	 */
	public class SMMachine extends EventDispatcher{
		
		
		private var transitions:Array;
		private var _state:SMState;
		private var stateMachine:Array;
		private var guardFunction:Function;
		private var states:Dictionary;
		
		
		public function SMMachine(firstState:SMState) {
			
			stateMachine = new Array();
			_state = firstState;
	
		}
		
		public function addTransition(previousState:SMState, nextState:SMState, event:String, condition:Function = null, action:Function = null):SMTransition {
			
			var transition:SMTransition;
			transition = new SMTransition(previousState, nextState, event, condition, action);
			previousState.transitions.push(transition);
			
			return transition;
			
		}
		
		public function update():void {
			
			for each (var transition:SMTransition in _state.transitions) {	
				evaluateTransition(transition);
			}
			if (_state.action != null) {
				_state.action();	
			}
			
		}
		
		public function setEvent(event:String):void {
			
			for each (var transition:SMTransition in _state.transitions) {
				
				if (transition.event == event) {
					
					if (transition.condition != null) {
						evaluateTransition(transition);		
					}else {
						setNextState(transition);
						
					}	
	
				}			
			}
			
		}
		
		private function setNextState(transition:SMTransition):void {
			
			if (_state.exitAction != null) {
				_state.exitAction();
			}
			if (transition.action != null) {
				transition.action();
			}
			if (transition.nextState.enterAction != null) {
				transition.nextState.enterAction();
			}
		
			_state = transition.nextState;
			
		}
		
		private function evaluateTransition(transition:SMTransition):void {
			
			if (transition.condition != null) {
				if (transition.condition()) {
					setNextState(transition);
				}					
			}
			
		}
		
		public function get state():SMState {return _state;}
		
		public function set state(newState:SMState):void {
			_state = newState;
		}
		
	}

}