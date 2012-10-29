package genetics.functions.mutations;

import genetics.individuos.Individuo;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;

public interface IMutator {

    public Individuo doMutation(Individuo individuo) throws ProductCreationException, NoMateriaPrimaAddedException;
}
