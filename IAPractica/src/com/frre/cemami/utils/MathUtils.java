/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.frre.cemami.utils;

/**
 *
 * @author Justo Vargas
 */
public class MathUtils {

    public static int getRandomNumber(int from, int to) {
        return from + (int)(Math.random() * ((to - from) + 1));
    }

    public static int getRandomNumberExcludeOne(int from, int to, int exclude) {
        int number = 0;
        do {
            number = from + (int)(Math.random() * ((to - from) + 1));
        } while (number == exclude);
        return number;
    }
}
