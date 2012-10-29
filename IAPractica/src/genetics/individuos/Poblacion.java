package genetics.individuos;

import com.frre.cemami.utils.DefaultLogguer;
import genetics.cromosomas.external.ExternalDataHandler;
import genetics.functions.managers.CruzaManager;
import genetics.functions.managers.CruzaManager.Cruzators;
import genetics.functions.managers.MutatorManager;
import genetics.functions.managers.MutatorManager.Mutators;
import genetics.functions.managers.SelectionManager;
import genetics.functions.managers.SelectionManager.Selectors;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import iapractica.controllers.GenericController;
import iapractica.controllers.MainPanelController;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Poblacion extends Thread {

    static DefaultLogguer logguer = DefaultLogguer.getLogger();
    private static final int MAXIMUM_DEFAULT_AGE = 600;
    private static final int MAXIMUM_DEFAULT_POPULATION_SIZE = 100;
    //container for the population while it is in memory
    private LinkedList<Individuo> currentPopulation;
    //control the population
    private int maximumAge;
    private int maximumPopulation;
    //curent age
    private int age;
    //says if the thread is running
    private boolean running;
    //Selector manager
    private SelectionManager selectionManager;
    //Cruzas manager
    private CruzaManager cruzaManager;
    //Cruzas manager
    private MutatorManager mutatorManager;
    //
    private HashMap<Selectors, Integer> selectionCoverageMethods;
    private HashMap<Cruzators, Integer> cruzaCoverageMethods;
    private HashMap<Mutators, Integer> mutationsCoverageMethods;
    //external data hanlder
    private ExternalDataHandler dataManager;
    private MainPanelController controller;

    //materias primas
    private LinkedList<Integer> materiasPrimas;

    public Poblacion(GenericController controller, LinkedList<Integer> materiasPrimas) {
        maximumAge = MAXIMUM_DEFAULT_AGE;
        maximumPopulation = MAXIMUM_DEFAULT_POPULATION_SIZE;
        this.controller = (MainPanelController) controller;
        this.materiasPrimas = materiasPrimas;
        init();
    }

    public Poblacion(GenericController controller, LinkedList<Integer> materiasPrimas, int maxAge, int maxPopulation) {
        maximumAge = maxAge;
        maximumPopulation = maxPopulation;
        this.controller = (MainPanelController) controller;
        this.materiasPrimas = materiasPrimas;
        init();
    }

    private void init() {
        age = 1;
        //my population
        currentPopulation = new LinkedList<Individuo>();
        //the managers
        selectionManager = new SelectionManager();
        cruzaManager = new CruzaManager();
        mutatorManager = new MutatorManager();
        //the methods
        //setting selectors
        selectionCoverageMethods = new HashMap<Selectors, Integer>();
        //setting cruzators
        cruzaCoverageMethods = new HashMap<Cruzators, Integer>();
        //setting mutators
        mutationsCoverageMethods = new HashMap<Mutators, Integer>();

        //set initial values
        selectionCoverageMethods.put(Selectors.RANKING_SELECTOR, 50);
        selectionCoverageMethods.put(Selectors.COPY_CONTROL_SELECTOR, 0);
         selectionCoverageMethods.put(Selectors.BEST_SELECTOR, 50);

        cruzaCoverageMethods.put(Cruzators.BINOMIAL, 50);
        cruzaCoverageMethods.put(Cruzators.MULTIPUNTO, 50);

        mutationsCoverageMethods.put(Mutators.SWAP, 50);
        mutationsCoverageMethods.put(Mutators.ADJOIN, 50);

        dataManager = new ExternalDataHandler();
    }

    public void evolve() {
        //do stuff
        LinkedList<Individuo> newPopulationAfterSelection = selectionManager.doSelection(currentPopulation, selectionCoverageMethods);
        LinkedList<Individuo> newPopulationAfterCruzas = cruzaManager.doCruzas(currentPopulation, cruzaCoverageMethods);
        LinkedList<Individuo> newPopulationAfterMutations = mutatorManager.doMutation(currentPopulation, mutationsCoverageMethods);
        //destroy the preivous population
        currentPopulation.clear();
        currentPopulation.addAll(newPopulationAfterCruzas);
        currentPopulation.addAll(newPopulationAfterSelection);
        currentPopulation.addAll(newPopulationAfterMutations);
        //increment the age
        age++;
    }

    @Override
    public void run() {
        
        try {
            currentPopulation = PoblacionFactory.getInstance().createInitialRandomPopulation(maximumPopulation, materiasPrimas);
        } catch (NoMateriaPrimaAddedException ex) {
           logguer.logError(this, ex.getMessage(), ex);
        }

        setRunning(true);

        logguer.logInfo(" Starting Simulation ");
        logguer.logInfo("Max Age " + maximumAge);
        logguer.logInfo("CurrentPopulation " + maximumPopulation);


        updateUIChart(age, currentPopulation);
        while (age < maximumAge) {
            if (isRunning()) {
                dataManager.saveToExternalFile(age, currentPopulation);
                evolve();
                updateUIChart(age, currentPopulation);
                try {
                    Thread.sleep(100);
                } catch (InterruptedException ex) {
                    Logger.getLogger(Poblacion.class.getName()).log(Level.SEVERE, null, ex);
               }
            }
        }

        //first 5
        int five = 5;
        for (Individuo individuo : currentPopulation) {
            if (five != 0){
                logguer.logInfo(individuo.toString());
                five--;
            }
        }

    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getMaximumAge() {
        return maximumAge;
    }

    public void setMaximumAge(int maximumAge) {
        this.maximumAge = maximumAge;
    }

    public boolean isRunning() {
        return running;
    }

    public void setRunning(boolean running) {
        this.running = running;
    }

    public void setCoverageMethod() {
    }

    private void updateUIChart(int age, LinkedList<Individuo> currentPopulation) {
        LinkedList<Double> newElements = new LinkedList<Double>();
        for (Individuo individuo : currentPopulation) {
            newElements.add(individuo.getFitnessValue());
        }
        Collections.sort(newElements);
        this.controller.updateChart(newElements, age);
    }

    @Override
    public void interrupt() {
        super.interrupt();
        //dispose elements here
    }

    public LinkedList<Integer> getMateriasPrimas() {
        return materiasPrimas;
    }

    public void setMateriasPrimas(LinkedList<Integer> materiasPrimas) {
        this.materiasPrimas = materiasPrimas;
    }

    public void pause() {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    public void rewind(int i) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    public int getMaximumPopulation() {
        return maximumPopulation;
    }

    public void setMaximumPopulation(int maximumPopulation) {
        this.maximumPopulation = maximumPopulation;
    }



}
