/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package iapractica.controllers;

import iapractica.views.GenericView;
import javax.swing.JFrame;

/**
 *
 * @author Justo Vargas
 */
public abstract class GenericController {

    protected GenericView view;

    public GenericController(GenericView view){
        this.view = view;
        setController();
        init();
    }

    public abstract void init();
    public abstract void show();
    public abstract void dispose();

    private void setController() {
        this.view.setController(this);
    }

}
