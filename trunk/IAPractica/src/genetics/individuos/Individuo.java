package genetics.individuos;

import java.util.LinkedList;
import genetics.cromosomas.ICromosoma;
import genetics.productos.Producto;
import genetics.productos.exceptions.GeneticException;

public class Individuo implements ICromosoma, Comparable<Individuo>, Cloneable {

    private static int DEFAULT_DIFFERENT_PRODUCTS = 4;
    private double fitnessValue;
    private LinkedList<LinkedList<Producto>> productos;

    public Individuo() {
        this(DEFAULT_DIFFERENT_PRODUCTS);
    }

    public Individuo(int productSize) {
        productos = new LinkedList<LinkedList<Producto>>();
        for (int i = 0; i < productSize; i++) {
            productos.add(i, new LinkedList<Producto>());
        }
    }

    public void add(int index, Producto element) {
        productos.get(index).add(element);
    }

    public int getProductsSize(int productNumber) {
        return productos.get(productNumber - 1).size();
    }

    public LinkedList<Producto> getProductsAt(int productNumber) {
        return productos.get(productNumber - 1);
    }

    public Producto getProductAt(int productNumber) throws GeneticException {
        if (productos.get(productNumber - 1).size() > 0) {
            return productos.get(productNumber - 1).get(0);
        }
        throw new GeneticException("Can not retrieve the product cause the cromosome has 0 genes of it");
    }

    public int getTotalDiferrentProducts() {
        return productos.size();
    }

    @Override
    public Double getFitnessValue() {
        // TODO Auto-generated method stub
        return fitnessValue;
    }

    @Override
    public void mutate() {
        // TODO Auto-generated method stub
    }

    @Override
    public ICromosoma doCruza(ICromosoma cromosoma) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void setFitnessValue(double fitnessValue) {
        this.fitnessValue = fitnessValue;
    }


    @Override
    public Object clone() throws CloneNotSupportedException {
        Individuo clone = (Individuo) super.clone();
        LinkedList<LinkedList<Producto>> newProductS = new LinkedList<LinkedList<Producto>>();
        for (LinkedList<Producto> productList : productos) {
            LinkedList<Producto> newProductList = new LinkedList<Producto>();
            for (Producto producto : productList) {
                Producto cloneProduct = (Producto) producto.clone();
                newProductList.add(producto);
            }
            newProductS.add(productList);
        }
        clone.productos = newProductS;
        return clone;
    }

    /*
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((productos == null) ? 0 : productos.hashCode());
        return result;
    }*/

    @Override
    public int compareTo(Individuo o) {
        // TODO Auto-generated method stub
        if (o.getFitnessValue() > this.fitnessValue) {
            return -1;
        } else if (o.getFitnessValue() < this.fitnessValue) {
            return 1;
        } else {
            return 0;
        }
        // return o.getFitnessValue().compareTo();
    }

    @Override
    public String toString() {
        return "Individuo{" + "fitnessValue=" + fitnessValue + " productos= 1 --> [" + productos.get(0).size() + "] 2 --> [" + productos.get(1).size() + "] 3 --> [" + productos.get(2).size() + "] 4 --> [" + productos.get(3).size() + "] " + '}';
    }
}
