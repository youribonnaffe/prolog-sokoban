package com.prolog.sokoban;


import java.io.BufferedReader;
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
    private Integer persoX;
    private Integer persoY;
    
    
    
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
                                case LevelMaker.PERSO:   cases.get(cases.size()-1).add(PERSO);  persoY = i; persoX = cases.size()-1; break;
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
    
    public void getPerso(int x, int y){
        x = persoX;
        y = persoY;
    }
    
    public void setPerso(int x, int y){
        persoX = x;
        persoY = y;
    }
    
    public void update(Step move){
        //move perso
        int oldX = persoX.intValue();
        int oldY = persoY.intValue();
        persoX = stringToInt(move.perso.charAt(0));
        persoY = stringToInt(move.perso.charAt(1));
        cases.get(oldX).set(oldY, VIDE);
        cases.get(persoX.intValue()).set(persoY.intValue(), PERSO);
        //move each barrel
        for(int i =0; i<move.getCaisses().size();i++){
            int x = stringToInt(move.getCaisses().get(i).charAt(0));
            int y = stringToInt(move.getCaisses().get(i).charAt(1));
            cases.get(x).set(y, CAISSE);
        }
    }
    
    private int stringToInt(char c){
           return (c-'a');
    }
            
}
