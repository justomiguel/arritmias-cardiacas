package genetics.productos;

import genetics.productos.exceptions.ProductCreationException;
import genetics.productos.types.Producto1;
import genetics.productos.types.Producto2;
import genetics.productos.types.Producto3;
import genetics.productos.types.Producto4;

public class ProductosFactory {

	private static ProductosFactory instance;

	private ProductosFactory() {

	}

	public static ProductosFactory getInstance() {
		if (instance == null) {
			instance = new ProductosFactory();
		}
		return instance;
	}

	public static Producto getProducto(int producto) throws ProductCreationException {
		switch (producto) {
		case 1:
			return new Producto1();
		case 2:
			return new Producto2();
		case 3:
			return new Producto3();
		case 4:
			return new Producto4();
		}
		
		throw new ProductCreationException("The Product doesn't exists");
		
	}
}
