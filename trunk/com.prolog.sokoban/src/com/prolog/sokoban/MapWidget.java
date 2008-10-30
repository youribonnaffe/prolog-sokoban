/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.prolog.sokoban;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
/**
 *
 * @author loktor
 */
public class MapWidget extends Canvas implements MouseListener{
    Map map;
    Solution sol;
    int currentSol;
    static final private int TAILLE_IMG = 32;
    
    public MapWidget(Map m, Solution s){
        super();
        map = m;
        sol = s;
        currentSol = 1;
        setBackground(new Color(250,250,130));
        addMouseListener(this);
    }
    
    public void paint(Graphics g){
        super.paint(g);
        Image imgMur = getToolkit().getImage("mur.png");
        Image imgPerso = getToolkit().getImage("perso.png");
        Image imgCible = getToolkit().getImage("cible.png");
        Image imgCaisse = getToolkit().getImage("caisse.png");
        for(int i=0; i< map.getCases().size(); i++){
            for(int j=0; j<map.getCases().get(i).size(); j++){
                if(map.getCases().get(i).get(j) == Map.MUR){
                    g.drawImage(imgMur, j*TAILLE_IMG, i*TAILLE_IMG, TAILLE_IMG,TAILLE_IMG, this);
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
            
    
    public void mousePressed(MouseEvent e) {
        if( currentSol < sol.moveCount()-1){
            System.out.println(sol.getStep(currentSol).toString());
            map.update(sol.getStep(currentSol));
            repaint();
            currentSol++;
        }
        else{
            System.out.println("No more moves !");
        }
    }
    
    /*
     *Fuck le Java et ses interfaces de merde
     *@author Java_Killer
     *
     */
    
    public void mouseReleased(MouseEvent e) {
        
    }
    
    public void mouseEntered(MouseEvent e) {
        
    }
    
    public void mouseExited(MouseEvent e) {
        
    }
    
    public void mouseClicked(MouseEvent e) {
        
    }


}
