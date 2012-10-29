/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package genetics.functions.selection;

import genetics.functions.managers.SelectionManager;
import genetics.individuos.Individuo;
import java.util.Collections;
import java.util.LinkedList;

/**
 *
 * @author Justo Vargas
 */
public class BestSelector implements ISelector {

    public LinkedList<Individuo> doSelection(LinkedList<Individuo> poblacion, int selectionMethodCoverage) {
        LinkedList<Individuo> newPopulation = new LinkedList<Individuo>();
        int size = poblacion.size();

        Collections.sort(poblacion);

        int numberOfCopies = (selectionMethodCoverage*SelectionManager.DEFAULT_SURVIVORS_BY_SELECTIONS_METHODS/100) * size / 100;
        for (int i = 0; i < numberOfCopies; i++) {
            newPopulation.add(poblacion.get(i));
        }
        return newPopulation;
    }

}
