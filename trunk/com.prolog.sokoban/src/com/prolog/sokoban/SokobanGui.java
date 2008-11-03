/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.prolog.sokoban;


import javax.swing.JFrame;

/**
 *
 * @author loktor
 */
public class SokobanGui{ 
    
    public SokobanGui(Map map, Solution sol){    
        JFrame frame = new JFrame("Sokoban Solver");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setBounds(200, 100, 500, 500);

        //Display the window.
        MapWidget mapWid = new MapWidget(map, sol);
        frame.getContentPane().add(mapWid);
        frame.setVisible(true);
        frame.pack();
        
    }
}
