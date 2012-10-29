/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package iapractica.controllers;

import genetics.individuos.Poblacion;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import iapractica.drawers.DataDrawer;
import iapractica.views.MainPanelView;
import java.util.LinkedList;

/**
 *
 * @author Justo Vargas
 */
public class MainPanelController extends GenericController{
    
    private Poblacion population;
    private DataDrawer drawer;
    private LinkedList<Integer> materiasPrimas = new LinkedList<Integer>();

    public MainPanelController(){
        super(new MainPanelView());
    }

    @Override
    public void init() {
        
    }

    @Override
    public void show() {
        MainPanelView panel = (MainPanelView) view;
        this.view.reset();
        population = new Poblacion(this, materiasPrimas);
        drawer = new DataDrawer(panel);
        this.view.setVisible(true);
    }

    public void startSimulation() throws NoMateriaPrimaAddedException{

        if (materiasPrimas.isEmpty()){
            throw new NoMateriaPrimaAddedException("No Materia was added");
        }
        population.setMateriasPrimas(materiasPrimas);
        population.start();
    }
    

    public void pauseSimulation(){
        population.pause();
    }

    public void getBackOneAge(){
        population.rewind(1);
    }

    public void stopSimulation(){
        population.rewind(-1);
    }

    public void destroyCurrentSimulation(){
        if (population!= null){
            this.population.interrupt();
        }
        population = null;
    }

    @Override
    public void dispose() {
        destroyCurrentSimulation();
    }

    public void updateChart(LinkedList<Double> newElements, int age, double average) {
        MainPanelView panel = (MainPanelView) this.view;
        panel.updateChart(average, age, newElements);
    }

    public void addMateriaPrima(int[] materiasPrimas) {
        int size = materiasPrimas.length;
        for (int i = 0; i < size; i++) {
            this.materiasPrimas.add(materiasPrimas[i]);
        }
    }

    public void setMaximumAge(int maximumAge) {
        population.setMaximumAge(maximumAge);
    }

    public void setMaximumPopulation(int maximumPopulation) {
        population.setMaximumPopulation(maximumPopulation);
    }

    public void setSimulationVelocity(int value) {
        population.setSimulationVelocity(value);
    }

    public void updateProgress(int progress) {
        ((MainPanelView) view).updateProgress(progress);
    }

   
}
