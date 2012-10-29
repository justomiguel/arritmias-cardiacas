package genetics.functions.selection;

import genetics.individuos.Individuo;
import java.util.LinkedList;

public interface ISelector {

    public LinkedList<Individuo> doSelection(LinkedList<Individuo> poblacion, int selectionMethodCoverage);
}
