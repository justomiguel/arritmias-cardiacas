/*
 * IAPracticaApp.java
 */
package iapractica;

import com.frre.cemami.utils.DefaultLogguer;
import genetics.individuos.Poblacion;
import org.jdesktop.application.Application;
import org.jdesktop.application.SingleFrameApplication;

/**
 * The main class of the application.
 */
public class IAPracticaApp extends SingleFrameApplication {

    public static DefaultLogguer logguer = DefaultLogguer.getLogger();

    /**
     * At startup create and show the main frame of the application.
     */
    @Override
    protected void startup() {
        show(new IAPracticaView(this));
    }

    /**
     * This method is to initialize the specified window by injecting resources.
     * Windows shown in our application come fully initialized from the GUI
     * builder, so this additional configuration is not needed.
     */
    @Override
    protected void configureWindow(java.awt.Window root) {
    }

    /**
     * A convenient static getter for the application instance.
     * @return the instance of IAPracticaApp
     */
    public static IAPracticaApp getApplication() {
        return Application.getInstance(IAPracticaApp.class);
    }

    /**
     * Main method launching the application.
     */
    public static void main(String[] args) {

        logguer.logInfo(IAPracticaApp.getInstance(), "App started");
        launch(IAPracticaApp.class, args);
    }
}
