package genetics.functions.cruzas;

import genetics.individuos.Individuo;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;

public interface ICruzator {

    public Individuo makeCruza(Individuo father, Individuo mother) throws ProductCreationException, NoMateriaPrimaAddedException;

}
