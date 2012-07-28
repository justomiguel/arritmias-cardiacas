package com.jmv.framework.rsl {
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class RSL {
		
		private var applicationDomain:ApplicationDomain;
		
		public function RSL(applicationDomain:ApplicationDomain) {
			this.applicationDomain = applicationDomain;
		}
		
		public function getClassDefiniton(linkage:String):Class {
			return applicationDomain.getDefinition(linkage) as Class;
		}
		
		public function hasClassDefinition(linkage:String):Boolean {
			return applicationDomain.hasDefinition(linkage);
		}
		
	}
	
}