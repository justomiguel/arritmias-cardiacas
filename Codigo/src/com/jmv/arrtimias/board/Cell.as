package com.jmv.arrtimias.board 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Justo Vargas
	 */
	public class Cell extends Sprite {
		
		public var activeTimeToSpare:uint=10;
		
		public var inactiveTime:uint=30;
		
		public var uppVelocityToSpare:uint=10;
		public var downVelocityToSpare:uint=10;
		public var rigthVelocityToSpare:uint =10;
		public var leftVelocityToSpare:uint = 10;
		
		/*habria que hacer una makinita de estado de forma que la muy loca me diga en que
		 * estado de la celula estoy y si puedo seguir contagiando la onda o no
		 * tengo que ver como manejar que la celula no puede recibir impactos si 
		 * ya esta activada y cuando se chocan dos ondas
		 * esta medio complicado aca pero ya no me da la cabeza.. estuve laburando desde las 16 maso o menos son las  1 de la noche
		 * */
			
		public function Cell() {
			super();
		}
		
	}

}