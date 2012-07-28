package com.jmv.framework.errors {

	/**
	 * ...
	 * @author MatiX @ sismogames
	 */
	public class SError extends Error {

		private var _data:Object;

		public function SError(type:String, data:Object = null) {
			super(type);
			this._data = data;
		}

		public function get data():Object {
			return _data
		}

		public function toString():String {
			return "------------ SISMO FRAMEWORK ERROR ------------------\n" + this.message;
		}

	}
}

