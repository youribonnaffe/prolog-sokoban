/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.prolog.sokoban;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
/**
 *
 * @author loktor
 */
public class MapWidget extends Canvas{
    Map map;
    static final private int TAILLE_IMG = 32;
    
    public MapWidget(Map m){
        super();
        map = m;
        setBackground(new Color(250,250,130));
    }
    
    public void paint(Graphics g){
        super.paint(g);
        Image imgMur = getToolkit().getImage("mur.png");
        Image imgPerso = getToolkit().getImage("perso.png");
        Image imgCible = getToolkit().getImage("cible.png");
        Image imgCaisse = getToolkit().getImage("caisse.png");
        for(int i=0; i< map.getCases().size(); i++){
            for(int j=0; j<map.getCases().get(i).size(); j++){
                //System.out.println( (new Integer(i)).toString()+"   "+(new Integer(j)).toString());
                if(map.getCases().get(i).get(j) == Map.MUR){
                    g.drawImage(imgMur, j*TAILLE_IMG, i*TAILLE_IMG, TAILLE_IMG,TAILLE_IMG, this);
                    //System.out.println( "====>"+(new Integer(i)).toString()+"   "+(new Integer(j)).toString());
                } else if(map.getCases().get(i).get(j) == Map.CAISSE){
                    g.drawImage(imgCaisse, j*TAILLE_IMG, i*TAILLE_IMG, TAILLE_IMG,TAILLE_IMG, this);
                } else if(map.getCases().get(i).get(j) == Map.CIBLE){
                    g.drawImage(imgCible, j*TAILLE_IMG, i*TAILLE_IMG, TAILLE_IMG,TAILLE_IMG, this);
                } else if(map.getCases().get(i).get(j) == Map.PERSO){
                    g.drawImage(imgPerso, j*TAILLE_IMG, i*TAILLE_IMG, TAILLE_IMG,TAILLE_IMG, this);
                }
                     
            }
        }
    }
            

}
