package genetics.productos.types;

import genetics.productos.Producto;

public class Producto1 extends Producto {
	
	static {
		restricciones[0] = 80;
		restricciones[1] = 0;
		restricciones[2] = 44;
		restricciones[3] = 72;
		restricciones[4] = 0;
		restricciones[5] = 55;
		restricciones[6] = 22;
		restricciones[7] = 0;
	}

	public Producto1(){
		setProfitValue(90);
	}
}
