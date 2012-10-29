package genetics.productos.types;

import genetics.productos.Producto;

public class Producto2 extends Producto {

	static {
		restricciones[0] = 15;
		restricciones[1] = 49;
		restricciones[2] = 12;
		restricciones[3] = 0;
		restricciones[4] = 50;
		restricciones[5] = 21;
		restricciones[6] = 0;
		restricciones[7] = 70;
	}

	public Producto2(){
		setProfitValue(115);
	}
}
