/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package iapractica.views.popups;

import com.frre.cemami.utils.DefaultLogguer;
import java.awt.Component;
import javax.swing.JOptionPane;

/**
 *
 * @author Justo Vargas
 */
public class PopUpFactory {

    static DefaultLogguer logguer = DefaultLogguer.getLogger();

    public static void showErrorPopUP(Component parent, String message){
          JOptionPane.showMessageDialog(parent, message,
                   "IA - General Error - CEMAMI", 0);
          logguer.logError(parent, message);
    }

    public static void showConfirmPopUP(Component parent, String message){
          JOptionPane.showMessageDialog(parent, message,
                   "IA - Informacion - CEMAMI", 1);
          logguer.logError(parent, message);
    }
}
