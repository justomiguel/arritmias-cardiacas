/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package genetics.cromosomas.external;

import com.frre.cemami.utils.Constants;
import com.frre.cemami.utils.DefaultLogguer;
import com.thoughtworks.xstream.XStream;
import genetics.individuos.Individuo;
import genetics.individuos.IndividuosFactory;
import genetics.productos.exceptions.NoMateriaPrimaAddedException;
import genetics.productos.exceptions.ProductCreationException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Justo Vargas
 */
public class ExternalDataHandler {

     static DefaultLogguer logguer = DefaultLogguer.getLogger();

     //parser to xml
    private XStream parserXml;


    public ExternalDataHandler(){
        parserXml = new XStream();
    }

     public void saveToExternalFile(int age, LinkedList<Individuo> currentPopulation) {

        String name = Constants.EXTERNAL_HISTORY_FOLDER + Constants.FILE_SEPARATOR + Constants.EXTERNAL_XML_FILE + age + ".xml";
        FileOutputStream file = null;
        try {
            file = new FileOutputStream(name);
            LinkedList<ExternalData> dataToSave = getInternalDataToSave(currentPopulation);
            parserXml.toXML(dataToSave, file);
            file.close();
        } catch (IOException ex) {
            logguer.logError(this, "No pude Crear el archivo para guardar poblacion previa", ex);
        }
    }

    public LinkedList<Individuo> getFromExternalFile(int age) {
        LinkedList<Individuo> population = null;
        try {
            String name = Constants.EXTERNAL_HISTORY_FOLDER + Constants.FILE_SEPARATOR + Constants.EXTERNAL_XML_FILE + age + ".xml";
            FileInputStream file = new FileInputStream(name);
            population = restorePopulationFromExternalData((LinkedList<ExternalData>) parserXml.fromXML(file));
            file.close();
        } catch (FileNotFoundException e) {
            logguer.logError(this, "Can get Population from Disk ", e);
        } finally {
            return population;
        }
    }

    public LinkedList<Double> getFromExternalFileForDrawing(int age) {
        LinkedList<Double> data = new LinkedList<Double>();
        try {
            String name = Constants.EXTERNAL_HISTORY_FOLDER + Constants.FILE_SEPARATOR + Constants.EXTERNAL_XML_FILE + age + ".xml";
            FileInputStream file = new FileInputStream(name);
            LinkedList<ExternalData> myData = (LinkedList<ExternalData>) parserXml.fromXML(file);
            LinkedList<Individuo> population = restorePopulationFromExternalData(myData);
            for (Individuo individuo : population) {
                data.add(individuo.getFitnessValue());
            }
            file.close();
        } catch (FileNotFoundException e) {
            logguer.logError(this, "Can get Population from Disk ", e);
        } finally {
            return data;
        }
    }

    public LinkedList<ExternalData> getInternalDataToSave(LinkedList<Individuo> population){
        LinkedList<ExternalData> externalData = new LinkedList<ExternalData>();
        for (Individuo individuo : population) {
            externalData.add(new ExternalData(individuo));
        }
        return externalData;
    }

       public LinkedList<Individuo> restorePopulationFromExternalData(LinkedList<ExternalData> data) throws ProductCreationException{
        LinkedList<Individuo> population = new LinkedList<Individuo>();
        for (ExternalData myData : data) {
            Individuo ind;
            try {
                ind = IndividuosFactory.getInstance().createIndividuo(myData.getProductS());
                population.add(ind);
            } catch (NoMateriaPrimaAddedException ex) {
                logguer.logError(this, ex.getMessage(), ex);
            }
        }
        return population;
    }

}
