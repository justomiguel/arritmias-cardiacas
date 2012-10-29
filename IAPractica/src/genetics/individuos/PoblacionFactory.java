package genetics.individuos;

import com.frre.cemami.utils.DefaultLogguer;
import com.frre.cemami.utils.MathUtils;
import genetics.cromosomas.fitnessfunctions.FitnessFunction;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PoblacionFactory {

    static DefaultLogguer logguer = DefaultLogguer.getLogger();
    private static PoblacionFactory instance;

    private PoblacionFactory() {
    }

    public static PoblacionFactory getInstance() {
        if (instance == null) {
            instance = new PoblacionFactory();
        }
        return instance;
    }

    public LinkedList<Individuo> createInitialRandomPopulation(Poblacion p, int initialPopulation, LinkedList<Integer> materiasPrimas) throws NoMateriaPrimaAddedException {

        LinkedList<Individuo> initialPop = new LinkedList<Individuo>();

        IndividuosFactory.getInstance().setMateriasPrimas(materiasPrimas);
        
        LinkedList<Integer> maxQuantities = new LinkedList<Integer>();
        for (int i = 0; i < 4; i++) {
            int number = IndividuosFactory.getInstance().maxQuantityOfProductToBeCreated(i+1);
            logguer.logInfo("Max of "+i+" "+number);
            maxQuantities.add(number);
        }


        int[] productos = new int[4];
        int currentSize = 0;
        while (currentSize < initialPopulation) {
            productos[0] = MathUtils.getRandomNumber(0, maxQuantities.get(0));
            productos[1] = MathUtils.getRandomNumber(0, maxQuantities.get(1));
            productos[2] = MathUtils.getRandomNumber(0, maxQuantities.get(2));
            productos[3] = MathUtils.getRandomNumber(0, maxQuantities.get(3));
            try {
                Individuo individuo = IndividuosFactory.getInstance().createIndividuo(productos);
                initialPop.add(individuo);
                currentSize = initialPop.size();
                int percetageOfSucces = currentSize*100/initialPopulation;
                p.updateUIProgress(5+percetageOfSucces*40/100);
            } catch (ProductCreationException ex) {
                //logguer.logError(this, "No pudo crear producto por que materia prima insuficiente", ex);
            }  
        }  
        return initialPop;
    }

    public LinkedList<Individuo> cloneInitialPopulation(LinkedList<Individuo> initialPop){
        LinkedList<Individuo> ind = new LinkedList<Individuo>();
        for (int i = 0; i < initialPop.size(); i++) {
            Individuo individuo = null;
            try {
                individuo = (Individuo) initialPop.get(i).clone();
            } catch (CloneNotSupportedException ex) {
               logguer.logError(this, "Can Not Clone Element du to ",ex);
            }
            ind.add(individuo);
        }
        return ind;
    }

}
