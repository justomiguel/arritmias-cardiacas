/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.functions.managers;

import com.frre.cemami.utils.DefaultLogguer;
import com.frre.cemami.utils.MathUtils;
import genetics.functions.mutations.AdJoinMutation;
import genetics.functions.mutations.IMutator;
import genetics.functions.mutations.SwapMutation;
import genetics.individuos.Individuo;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Set;

/**
 *
 * @author Justo Vargas
 */
public class MutatorManager {

    public static enum Mutators {

        SWAP,
        ADJOIN
    };

    public static int DEFAULT_SURVIVORS_BY_MUTATORS_METHODS = 20;
    
    private HashMap<Mutators, IMutator> mutatorClasses;
    static DefaultLogguer logguer = DefaultLogguer.getLogger();

    public MutatorManager() {
        mutatorClasses = new HashMap<Mutators, IMutator>();
        mutatorClasses.put(Mutators.SWAP, new SwapMutation());
        mutatorClasses.put(Mutators.ADJOIN, new AdJoinMutation());
    }

    public LinkedList<Individuo> doMutation(LinkedList<Individuo> poblacionOriginal, HashMap<Mutators, Integer> coverageMethods) {

        Set<Mutators> keys = coverageMethods.keySet();

        LinkedList<Individuo> newPopulation = new LinkedList<Individuo>();

        for (Mutators mutatorMethod : keys) {
            int getCoverageOfMethod = coverageMethods.get(mutatorMethod);
            if (getCoverageOfMethod > 0) {
                IMutator mutator = mutatorClasses.get(mutatorMethod);

                // total habitantes
                int numberOfPopulation = poblacionOriginal.size();

                // porcentage a pasar por este metodo
                int percentageOfCopiesToBeGeneratedByThisMethod = getCoverageOfMethod * DEFAULT_SURVIVORS_BY_MUTATORS_METHODS / 100;

                // total de copias de acuerdo al porcentaje anterior
                int numberOfCopiesForThisMethod = percentageOfCopiesToBeGeneratedByThisMethod * numberOfPopulation / 100;

                // genero las individuos que necesito
                while (numberOfCopiesForThisMethod > 0) {
                    int chosenOne = MathUtils.getRandomNumber(0, numberOfPopulation-1);
                    try {
                        Individuo son = mutator.doMutation(poblacionOriginal.get(chosenOne));
                        numberOfCopiesForThisMethod--;
                        newPopulation.add(son);
                    }  catch (NoMateriaPrimaAddedException ex) {
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
