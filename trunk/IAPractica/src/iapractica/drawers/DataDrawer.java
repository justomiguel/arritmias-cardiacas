/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package iapractica.drawers;

import com.frre.cemami.utils.DefaultLogguer;
import genetics.cromosomas.external.ExternalDataHandler;
import iapractica.views.MainPanelView;
import java.util.LinkedList;

import org.jfree.data.xy.XYDataset;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 *
 * @author Justo Vargas
 */
public class DataDrawer extends Thread {

    private MainPanelView myPanel;
    private boolean running;
    private ExternalDataHandler dataGetter;
    private int currentAgeShowing;
    /** The data. */
     private float[][] data = new float[2][600];
    private int maxFitnessValue;
    static DefaultLogguer logguer = DefaultLogguer.getLogger();


    public DataDrawer(MainPanelView myPanel) {
        this.myPanel = myPanel;
        dataGetter = new ExternalDataHandler();
        this.running = false;
        reset();
    }

    @Override
    public void run() {
        running = true;
        while (running) {
            //try to get the new File
            LinkedList<Double> externalData = dataGetter.getFromExternalFileForDrawing(currentAgeShowing);
            if (!externalData.isEmpty()){
                populateData(externalData);
                //myPanel.setData(this.data);
                currentAgeShowing++;
            }
            try {
                Thread.sleep(100);
            } catch (InterruptedException ex) {
                logguer.logError(this, "Can not put Thread To Sleep", ex);
            }
        }
    }

     /**
     * Populates the data array with random values.
     */
    private void populateData(LinkedList<Double> myData) {

        int size = myData.size();
        for (int i = 0; i < size; i++) {
            final float y = myData.get(i).floatValue();
            this.data[0][i] = i;
            this.data[1][i] = y;
        }

    }

    public void reset() {
        this.currentAgeShowing = 1;
       
    }

    public int getCurrentAgeShowing() {
        return currentAgeShowing;
    }

    public void setCurrentAgeShowing(int currentAgeShowing) {
        this.currentAgeShowing = currentAgeShowing;
    }

    public void dipose() {
        this.interrupt();
    }
}
