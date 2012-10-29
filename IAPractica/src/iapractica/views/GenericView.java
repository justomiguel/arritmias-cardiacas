/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package iapractica.views;

import com.frre.cemami.utils.DefaultLogguer;
import iapractica.controllers.GenericController;
import javax.swing.JFrame;

/**
 *
 * @author Justo Vargas
 */
public abstract class GenericView extends JFrame{

    private GenericController controller;

    static DefaultLogguer logguer = DefaultLogguer.getLogger();

    public GenericView(){
    }

    public GenericController getController() {
        return controller;
    }

    public void setController(GenericController controller) {
        this.controller = controller;
    }

    public static DefaultLogguer getLogguer() {
        return logguer;
    }

    @Override
    public void dispose() {
        super.dispose();
        if (controller != null){
            controller.dispose();
        } else {
            logguer.logError(this, "NO Controller Attached to this view ");
        }
    }

    public abstract void reset();


}
