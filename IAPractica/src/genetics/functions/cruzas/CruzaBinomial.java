/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.functions.cruzas;

import genetics.individuos.Individuo;
import genetics.individuos.IndividuosFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.Random;

/**
 *
 * @author Justo Vargas
 */
public class CruzaBinomial implements ICruzator {

    private static final int MAX_GENES_OF_FATHER = 40;

    protected Random random = new Random();

    public Individuo makeCruza(Individuo father, Individuo mother) throws ProductCreationException, NoMateriaPrimaAddedException {

        int[] productos = new int[father.getTotalDiferrentProducts()];

        int totalProducts = productos.length;

        for (int i = 0; i < totalProducts; i++) {
            double randomNumber = random.nextDouble() * 100;
            if (randomNumber >= 0 && randomNumber <= MAX_GENES_OF_FATHER) {
                productos[i] = father.getProductsSize(i + 1);
            } else {
                productos[i] = mother.getProductsSize(i + 1);
            }
        }
        Individuo individuo = IndividuosFactory.getInstance().createIndividuo(productos);
        return individuo;
    }
}
