/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.prolog.sokoban;

import java.util.ArrayList;

/**
 *
 * @author loktor
 */
public class Step {
        String perso;
        ArrayList<String> caisses;
        public Step(){
                perso = "";
                caisses = new ArrayList<String>();
        }

        public String toString(){
                return "[Perso="+perso+" Caisses="+caisses.toString()+"]";
        }
        
        public String getPerso(){
            return perso;
        }
        
        public ArrayList<String> getCaisses(){
            return caisses;
        }
}
