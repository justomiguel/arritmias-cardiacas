package genetics.individuos;

import com.frre.cemami.utils.DefaultLogguer;
import genetics.cromosomas.fitnessfunctions.FitnessFunction;
import java.util.LinkedList;

import genetics.productos.Producto;
import genetics.productos.ProductosFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class IndividuosFactory {

    static DefaultLogguer logguer = DefaultLogguer.getLogger();
    private static IndividuosFactory instance;
    private HashMap<Integer, Integer> maxQuantitiesOfProduct;
    private LinkedList<Integer> materiasPrimas;

    private IndividuosFactory() {
        maxQuantitiesOfProduct = new HashMap<Integer, Integer>();
        materiasPrimas = new LinkedList<Integer>();
    }

    public static IndividuosFactory getInstance() {
        if (instance == null) {
            instance = new IndividuosFactory();
        }
        return instance;
    }

    @SuppressWarnings("unchecked")
    public Individuo createIndividuo(int[] productos) throws ProductCreationException, NoMateriaPrimaAddedException {

        Individuo individuo = new Individuo();
        if (materiasPrimas.isEmpty()) {
            throw new NoMateriaPrimaAddedException("No se puede crear Individuo por que no se setearon las masterias primas");
        }
        LinkedList<Integer> materiasPrimasClone = (LinkedList<Integer>) materiasPrimas.clone();

        for (int i = 0; i < productos.length; i++) {
            int quantityOfProduct = productos[i];
            while (quantityOfProduct > 0) {
                Producto producto = ProductosFactory.getProducto(i + 1);
                int[] restriccionesProducto = producto.getRestricciones();
                for (int j = 0; j < restriccionesProducto.length; j++) {
                    int montoMateriaPrimaMinimo = restriccionesProducto[j];
                    int materiaPrimaDisponible = materiasPrimasClone.get(j);
                    materiaPrimaDisponible = materiaPrimaDisponible - montoMateriaPrimaMinimo;
                    if (materiaPrimaDisponible < 0) {
                        String errorDesc = "No hay suficiente materia prima para esta configuracion";
                        throw new ProductCreationException(errorDesc);
                    } else {
                        materiasPrimasClone.set(j, materiaPrimaDisponible);
                    }
                }
                quantityOfProduct--;
                individuo.add(i, producto);
            }
        }
        double fitnessValue = FitnessFunction.getFitnessValue(individuo);
        individuo.setFitnessValue(fitnessValue);
        return individuo;
    }

    public LinkedList<Integer> getMateriasPrimas() {
        return materiasPrimas;
    }

    public void setMateriasPrimas(LinkedList<Integer> materiasPrimas) {
        this.materiasPrimas = materiasPrimas;
    }

    public HashMap<Integer, Integer> getMaxQuantitiesOfProduct() {
        return maxQuantitiesOfProduct;
    }

    public void setMaxQuantitiesOfProduct(HashMap<Integer, Integer> maxQuantitiesOfProduct) {
        this.maxQuantitiesOfProduct = maxQuantitiesOfProduct;
    }

    public int maxQuantityOfProductToBeCreated(int product) throws NoMateriaPrimaAddedException {
        Integer number = maxQuantitiesOfProduct.get(product);
        if (number == null) {
            if (materiasPrimas.isEmpty()) {
                throw new NoMateriaPrimaAddedException("No se puede crear Individuo por que no se setearon las masterias primas");
            }
            try {
                Producto producto = ProductosFactory.getProducto(product);
                int[] restricciones = producto.getRestricciones();
                LinkedList<Integer> materiasPrimasClone = (LinkedList<Integer>) materiasPrimas.clone();
                number = Integer.MAX_VALUE;
                for (int i = 0; i < restricciones.length; i++) {
                    int materiaRequerida = restricciones[i];
                    if (materiaRequerida != 0) {
                        int materiaPrimaDisponible = materiasPrimasClone.get(i);
                        int diff = materiaPrimaDisponible / materiaRequerida;
                        if (diff < number) {
                            number = diff;
                        }
                    }
                }
            } catch (ProductCreationException ex) {
                logguer.logError(this, "Error when creating product", ex);
            }
            maxQuantitiesOfProduct.put(product, number);
        }
        return number;
    }
}
