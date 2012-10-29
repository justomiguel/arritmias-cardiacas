/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.functions.managers;

import com.frre.cemami.utils.DefaultLogguer;
import com.frre.cemami.utils.MathUtils;
import genetics.functions.cruzas.CruzaBinomial;
import genetics.functions.cruzas.CruzaMultipunto;
import genetics.functions.cruzas.ICruzator;
import genetics.individuos.Individuo;
import genetics.individuos.PoblacionFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Justo Vargas
 */
public class CruzaManager {

    public static enum Cruzators {

        BINOMIAL, MULTIPUNTO
    };
    public static int DEFAULT_SURVIVORS_BY_CRUZATOR_METHODS = 40;
    private HashMap<Cruzators, ICruzator> cruzaClasses;
    static DefaultLogguer logguer = DefaultLogguer.getLogger();

    public CruzaManager() {
        cruzaClasses = new HashMap<Cruzators, ICruzator>();
        cruzaClasses.put(Cruzators.BINOMIAL, new CruzaBinomial());
        cruzaClasses.put(Cruzators.MULTIPUNTO, new CruzaMultipunto());
    }

    public LinkedList<Individuo> doCruzas(LinkedList<Individuo> poblacionOriginal, HashMap<Cruzators, Integer> coverageMethods) {

        Set<Cruzators> keys = coverageMethods.keySet();

        LinkedList<Individuo> newPopulation = new LinkedList<Individuo>();
        int father;
        int mother;

        for (Cruzators cruzaMethod : keys) {
            int getCoverageOfMethod = coverageMethods.get(cruzaMethod);
            if (getCoverageOfMethod > 0) {
                //obtiene metodo
                ICruzator cruzator = cruzaClasses.get(cruzaMethod);

                // total habitantes
                int numberOfPopulation = poblacionOriginal.size();

                // porcentage a pasar por este metodo
                int percentageOfCopiesToBeGeneratedByThisMethod = getCoverageOfMethod * DEFAULT_SURVIVORS_BY_CRUZATOR_METHODS / 100;

                // total de copias de acuerdo al porcentaje anterior
                int numberOfCopiesForThisMethod = percentageOfCopiesToBeGeneratedByThisMethod * numberOfPopulation / 100;

                // genero las individuos que necesito
                while (numberOfCopiesForThisMethod > 0) {
                    father = MathUtils.getRandomNumber(0, numberOfPopulation-1);
                    mother = MathUtils.getRandomNumberExcludeOne(0, numberOfPopulation-1, father);
                    try {
                        Individuo son = cruzator.makeCruza(poblacionOriginal.get(father), poblacionOriginal.get(mother));
                        numberOfCopiesForThisMethod--;
                        newPopulation.add(son);
                    } catch (NoMateriaPrimaAddedException ex) {
                       logguer.logError(this, ex.getMessage(), ex);
                    } catch (ProductCreationException ex) {
                       // logguer.warning(this, "Can not make the cruza", ex);
                    }
                }
            }
        }

        return newPopulation;
    }
}
