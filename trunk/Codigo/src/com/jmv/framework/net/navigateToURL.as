package com.jmv.framework.net {
	import com.jmv.framework.errors.SError;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public function navigateToURL(url:Object, window:String = null):void {
		if (url is URLRequest) {
			flash.net.navigateToURL(url as URLRequest, window);
		}
		else if (url is String) {
			var request:URLRequest = new URLRequest(url as String);
			flash.net.navigateToURL(request, window);
		}
		else {
			throw new SError("Unsupported URl type: " + url);
		}
	}
}