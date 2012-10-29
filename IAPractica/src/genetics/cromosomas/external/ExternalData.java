/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.cromosomas.external;

import genetics.individuos.Individuo;

/**
 *
 * @author Justo Vargas
 */
public class ExternalData {

    private int[] productS;

    public ExternalData(Individuo individuo) {
        int productsSize = individuo.getTotalDiferrentProducts();
        productS = new int[productsSize];
        for (int i = 0; i < productsSize; i++) {
            productS[i] = individuo.getProductsSize(i + 1);
        }
    }

    public int[] getProductS() {
        return productS;
    }

    public void setProductS(int[] productS) {
        this.productS = productS;
    }
}
