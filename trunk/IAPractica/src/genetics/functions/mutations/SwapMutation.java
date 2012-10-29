/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.functions.mutations;

import com.frre.cemami.utils.MathUtils;
import genetics.individuos.Individuo;
import genetics.individuos.IndividuosFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;

/**
 *
 * @author Justo Vargas
 */
public class SwapMutation implements IMutator {

    public Individuo doMutation(Individuo individuo) throws ProductCreationException, NoMateriaPrimaAddedException {
        Individuo mutatedInd = null;

        int[] productos = new int[individuo.getTotalDiferrentProducts()];

        int totalProducts = productos.length;

        int genNumber1 = MathUtils.getRandomNumber(1, totalProducts);
        int genNumber2 = MathUtils.getRandomNumberExcludeOne(1, totalProducts, genNumber1);

        for (int i = 0; i < totalProducts; i++) {
            int productsSize = 0;
            if ((i+1) == genNumber1){
                productsSize = individuo.getProductsSize(genNumber2);
            } else if ((i+1) == genNumber2){
                productsSize = individuo.getProductsSize(genNumber1);
            } else {
                productsSize = individuo.getProductsSize(i+1);
            }
           productos[i] = productsSize;
        }

        mutatedInd = IndividuosFactory.getInstance().createIndividuo(productos);
        return mutatedInd;
    }
}
