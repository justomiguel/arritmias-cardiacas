package com.jmv.framework.gaming.ai.state_machines.base 
{
	import com.jmv.framework.events.SEvent;
	/**
	 * ...
	 * @author Facu
	 */
	public class SMEvent extends SEvent{
		
		public var description:String;
		public var name:String;
		
		public function SMEvent(type:String):void {
			name = type;
			super(type);
		}
		
	}

}