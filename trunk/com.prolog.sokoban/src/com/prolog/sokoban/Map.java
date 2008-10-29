package com.prolog.sokoban;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author loktor
 */
public class Map {        
    
    public static final int CAISSE = 1;
    public static final int CIBLE = 2;
    public static final int PERSO = 3;
    public static final int MUR = 4;
    public static final int VIDE = 5;
    
        
    private ArrayList<ArrayList<Integer>> cases;
    private int persoX;
    private int persoY;
    
    
    
    public Map (String file){
        BufferedReader is = null;
        cases = new ArrayList<ArrayList<Integer>>();
        try{
            is = new BufferedReader(new FileReader(file));
            while (is.ready()) {
                int ligne = 0;
                String s = is.readLine();
                if (s != null) {
                        cases.add( new ArrayList<Integer>());
                        for(int i=0; i<s.length(); i++){
                            switch(s.charAt(i)){
                                case LevelMaker.CAISSE:   cases.get(cases.size()-1).add(CAISSE); break;
                                case LevelMaker.CIBLE:   cases.get(cases.size()-1).add(CIBLE); break;
                                case LevelMaker.PERSO:   cases.get(cases.size()-1).add(PERSO);  persoX = i; persoY = cases.size()-1; break;
                                case LevelMaker.MUR:   cases.get(cases.size()-1).add(MUR); break;
                                case LevelMaker.VIDE:   cases.get(cases.size()-1).add(VIDE); break;
                                default: cases.get(cases.size()).add(MUR); break;
                            }    
                        }
                }
		}
        }
        catch( Exception ex){
                ex.printStackTrace();
        }finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
    }
    
    
    public String toString() {
            return cases.toString();
    }
    
    public ArrayList<ArrayList<Integer>> getCases(){
        return cases;
    }
            
}
