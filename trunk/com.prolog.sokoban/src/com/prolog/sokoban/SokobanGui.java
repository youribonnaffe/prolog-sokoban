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
    
    public SokobanGui(Map map){    
        JFrame frame = new JFrame("HelloWorldSwing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setBounds(200, 100, 500, 500);

        //Display the window.
        frame.pack();
        MapWidget mapWid = new MapWidget(map);
        frame.getContentPane().add(mapWid);
        frame.setVisible(true);
        
    }
}
