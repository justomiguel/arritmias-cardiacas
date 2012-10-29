/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.functions.cruzas;

import com.frre.cemami.utils.MathUtils;
import genetics.individuos.Individuo;
import genetics.individuos.IndividuosFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.Random;

/**
 *
 * @author Justo Vargas
 */
public class CruzaMultipunto implements ICruzator {


    public Individuo makeCruza(Individuo father, Individuo mother) throws ProductCreationException, NoMateriaPrimaAddedException {

        int[] productos = new int[father.getTotalDiferrentProducts()];

        int totalProducts = productos.length;

        int getPosition = MathUtils.getRandomNumber(1, totalProducts-1);

        for (int i = 0; i < getPosition; i++) {
            productos[i] = father.getProductsSize(i+1);
        }

        for (int i = getPosition; i < totalProducts; i++) {
            productos[i] = mother.getProductsSize(i+1);
        }

        Individuo individuo = IndividuosFactory.getInstance().createIndividuo(productos);
        return individuo;
    }
}
