package com.jmv.framework.data 
{
	import com.jmv.framework.errors.SError;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author MatiX
	 */
	public class CSV
	{
		
		private static const RECORD_DELIMITTER:String = "\n";
		private static const FIELD_DELIMITTER:String = ";";
		
		protected var _source:String;
		
		protected var struct:Array;
		protected var headers:Array;
		

		public function CSV(source:Object = null, headers:Array=null) 
		{
			this.headers = headers;
			
			if (!source) return;
			
			if(source is String){
				_source = source.toString();
			}
			else if (source is XMLList) {
				_source = XMLList(source).toXMLString();
			}
			else if (source is ByteArray) 
			{
				_source = source.readUTFBytes(source.length);
			}
			else if (source is Class) {
				var src:ByteArray = new source() as ByteArray;
				if (!src) throw new SError("source class is not a byte array !!");
				_source = src.readUTFBytes(src.length);
			}
			
			parse(_source);

		}
		
		private function parse(csv:String):void {
			var records:Array = csv.split(RECORD_DELIMITTER);
			
			if (records[records.length - 1] == "") records.pop();
			
			if(!headers){
				headers = String(records.shift()).split(FIELD_DELIMITTER);
			}
			
			struct = new Array();
			for (var r:int = 0; r < records.length; r++) {
				var record:String = records[r];
				var recordValues:Array = record.split(FIELD_DELIMITTER);
				var entry:Object = { index:r };
				for (var i:int = 0; i < headers.length; i++) 
				{
					entry[headers[i]] = recordValues[i];
					////trace( i,"->", headers[i] , recordValues[i]);
				}
				struct.push(entry);
			}
		}
		
		public function getRecord(i:int):Object {
			if (struct[i]) {
				return struct[i];
			}
			return null;
		}
		
		public function search(fields:Array, values:Array):Array {
			var result:Array = [];
			for each (var record:Object in struct) 
			{
				var recordPassed:Boolean = true;
				for (var i:int = 0; i < fields.length; i++) 
				{
					if (record[fields[i]] != values[i]) {
						recordPassed = false;
					}
				}
				if(recordPassed) result.push(record);
			}
			return result;
		}
		
		public function get length():int {
			if (struct) {
				return struct.length;
			}
			else return 0;
		}
		
		public function toString():String 
		{
			var string:String = super.toString() + "\n";
			for each (var record:Object in struct) 
			{
				string += record.toString() + "\n";
				for (var field:String in record) 
				{
					string += "\t - " + field + " = " + record[field] + "\n";
				}
			}
			return string;
		}
	}	
}