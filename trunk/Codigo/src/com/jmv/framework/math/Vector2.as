package com.jmv.framework.math 
{
		
	/**
	 * ...
	 * @author SismoGames -->  www.sismogames.com 
	 */
	public class Vector2 {
		
		public var x:Number;
		public var y:Number;
		private var dx:Number;
		private var dy:Number;
		
		
		public function Vector2(x:Number,y:Number){
			this.x = x;
			this.y = y;
			var vlen:Number = this.largo();
			if(vlen!=0){
				dx = x / vlen;
				dy = y / vlen;
			} 
		}
		
		
		public function toString():String {
			return "(" + this.x + "," + this.y + ")";
		}
		
		public function clonar():Vector2 {
			var vtemp:Vector2;
			vtemp = new Vector2(this.x, this.y );
			return vtemp;
		}
		
		public function sumar(v2:Vector2):Vector2 {
			var vtemp:Vector2;
			vtemp = new Vector2(this.x + v2.x , this.y + v2.y);
			return vtemp;
		}
		
		public function restar(v2:Vector2):Vector2 {
			var vtemp:Vector2;	
			vtemp = new Vector2(this.x - v2.x , this.y - v2.y);
			return vtemp;	
		}
		
		public function minus(v2:Vector2):Vector2 {
			var vtemp:Vector2;	
			vtemp = new Vector2(this.x - v2.x , this.y - v2.y);
			return vtemp;	
		}
		
		public function normR():Vector2 {
			var vtemp:Vector2;
			vtemp = new Vector2(this.y * -1 , this.x);
			return vtemp;
		}
		
		public function normL():Vector2 {
			var vtemp:Vector2;
			vtemp = new Vector2(this.y  , this.x  * -1);
			return vtemp;
		}
		
		public function dir():Vector2 {
			var vtemp:Vector2 = this.clonar();
			vtemp.normalizar();
			return vtemp;	
		}
		
		//public function proj(vtemp2:Number):Vector2 {
			//var vtemp3 = vtemp2;
			//var vtemp1:Vector2;
			//vtemp2 = vtemp3.dot(vtemp3);
			//if(vtemp2==0){
				//vtemp1 = this.clonar();
			//} else {
				//vtemp1 = vtemp3.clonar();
				//vtemp1.mult(this.dot(vtemp3) / vtemp2);
			//}
			//return vtemp1;
		//}
		
		
		public function projLargo(v2:Vector2):Number {
			var v1:Number = v2.dot(v2);
			if(v1==0) {
				return 0;
			} else {
				return Math.abs(this.dot(v2) / v1);
			}
		}
		
		public function projlen(v2:Vector2):Number {
			var v1:Number= v2.dot(v2);
			if(v1==0) {
				return 0;
			} else {
				return Math.abs(this.dot(v2) / v1);
			}
		}
		
		//Function: dot
		// el dot product da informacion acerca del angulo de los vectores
		//
		// Parametros:
		// vtemp2 - vector a multiplicar
		//
		// Valor devuelto:
		// - si A * B < 0 ( negativo ) donde A y B son los vectores , entonces el angulo es > a 90public static const
		// - si A * B > 0 ( positivo ) , entonces el angulo es < a 90public static const
		// - si A * B == 0 , entonces son perpediculares
		//
		// tambien provee el largo de la proyeccion de un vector sobre el otro
		public function dot(vtemp2:Vector2):Number {
			return this.x * vtemp2.x + this.y * vtemp2.y;
		}
		
		
		//Function: cross
		// como el dot , tambien multiplica un vector por otro , pero devuelve un vector
		//
		// y tiene diferentes usos.
		//
		//Parametros:
		// vtemp2 - vector a multiplicar
		public function cross(vtemp2:Vector2):Number {
			return this.x * vtemp2.y + this.y * vtemp2.x;
		}
		
		public function largo():Number {
			var vtemp:Vector2 = this;
			return Math.sqrt(vtemp.x * vtemp.x + vtemp.y  * vtemp.y);
		}
		
		public function len():Number {
			var vtemp:Vector2 = this;
			return Math.sqrt(vtemp.x * vtemp.x + vtemp.y  * vtemp.y);
		}
		
		public function copiar(vtemp2:Vector2):void {
			this.x = vtemp2.x;
			this.y = vtemp2.y;
		}
		
		public function mult(s:Number):void {
			this.x *= s;
			this.y *= s;
		}
		
		public function normalizar():void {
			var vtemp2:Vector2 = this;
			var vlen:Number = vtemp2.largo();
			if(vlen!=0){
				vtemp2.x /= vlen;
				vtemp2.y /= vlen;
			} 
		}
		
		public function normalize():void {
			normalizar();
		}
		
		public function sumareq(vtemp2:Vector2):void {
			this.x += vtemp2.x;
			this.y += vtemp2.y;
		}
		
		public function sumeq(vtemp2:Vector2):void {
			this.x += vtemp2.x;
			this.y += vtemp2.y;
		}
		
		public function sumeq2(vtemp2:Vector2):Vector2 {
			var vtemp :Vector2 = new Vector2(0,0);
			vtemp.x = this.x + vtemp2.x;
			vtemp.y = this.y + vtemp2.y;
			return vtemp;
		}
		
		public function restareq(vtemp2:Vector2):void {
			this.x -= vtemp2.x;
			this.y -= vtemp2.y;
		}
		
		/**
		*  Perp product is similar to dot product only instead of first vector its normal is used.
		* @param	vtemp
		* @return
		*/
		public function perP(vtemp:Vector2):Number {
			var pp :Number;
			pp = this.x*vtemp.y -this.y*vtemp.x;
			return pp;
			
		}
		
		public function get anguloGrados():Number {
			var anguloRadian:Number;
			var anguloGrados:Number;
			
			
			anguloRadian = Math.atan2(this.y, this.x);
			anguloGrados = anguloRadian * 180 /  Math.PI;
			
			return anguloGrados;
			
		}
		
		
		
	
		
	}

}