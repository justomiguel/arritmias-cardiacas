/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.frre.cemami.utils;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 *
 * @author Justo Vargas
 */
public class DefaultLogguer {

    private static DefaultLogguer logggerInstance;
    private static Logger theLogger = Logger.getLogger(DefaultLogguer.class);
    private StringBuilder msgBuilder = new StringBuilder();

    private DefaultLogguer() {
        PropertyConfigurator.configure(Constants.EXTERNAL_CONFIG_FOLDER + "/log4j.properties");
    }

    public static DefaultLogguer getLogger() {
        if (logggerInstance == null) {
            logggerInstance = new DefaultLogguer();
        }
        return logggerInstance;
    }

    public void logError(Object classOwner, String message, Exception e) {
        makeBody(classOwner, message);
        msgBuilder.append(" Stack: ");
        theLogger.error(msgBuilder.toString());
        StackTraceElement[] stack = e.getStackTrace();
        for (StackTraceElement stackTraceElement : stack) {
            theLogger.error(stackTraceElement);
        }

    }

    public void logError(Object classOwner, String message) {
        makeBody(classOwner, message);
        theLogger.error(msgBuilder.toString());
    }

    public void logError(String message) {
        makeBody(this, message);
        theLogger.error(msgBuilder.toString());
    }

    public void logWarning(Object classOwner, String message) {
        makeBody(classOwner, message);
        theLogger.warn(msgBuilder.toString());
    }

    public void logWarning(String message) {
        makeBody(this, message);
        theLogger.warn(msgBuilder.toString());
    }

    public void logInfo(Object classOwner, String message) {
        makeBody(classOwner, message);
        theLogger.info(msgBuilder.toString());
    }

    public void logInfo(String message) {
        makeBody(this, message);
        theLogger.info(msgBuilder.toString());
    }

    private void makeBody(Object classOwner, String message) {
        msgBuilder.delete(0, msgBuilder.length());
        String className = classOwner.getClass().getCanonicalName();
        if (!className.equalsIgnoreCase(this.getClass().getCanonicalName())) {
            msgBuilder.append(" className:");
            msgBuilder.append(className);
        }
        msgBuilder.append(" ");
        msgBuilder.append(message);
    }
}
