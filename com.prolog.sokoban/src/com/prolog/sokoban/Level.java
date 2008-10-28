package com.prolog.sokoban;

import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;

public class Level {
	public static final int SIZE_LIAISON = 2;

	public static int[] asciiToIntCoord(String coord) {
		int[] ret = {0,0};
		if(coord.length()>=2) {
			ret[0] = coord.charAt(0) - 'a';
			ret[1] = coord.charAt(1) - 'a';
		}
		return ret;
	}
	
	ArrayList<String[]> liaisons;
	String caisses = "";
	String perso = "";
	String cibles = "";

	public Level() {
		liaisons = new ArrayList<String[]>();
	}

	public void add(String piece1, String piece2) {
		String[] liaison = { piece1, piece2 };
		liaisons.add(liaison);
	}

	public void write(DataOutputStream os) throws IOException {
		for (String[] liaison : liaisons) {
			os.writeBytes("liaison(" + liaison[0] + "," + liaison[1] + ").");
			os.writeByte('\n');
		}
	}

	public String toString() {
		String s = "";
		for (String[] liaison : liaisons) {
			s += "liaison(" + liaison[0] + "," + liaison[1] + ").";
			s += '\n';
		}
		s += "\n";
		s += "Caisses : " + caisses;
		s += "\n";
		s += "Cibles : " + cibles;
		s += "\n";
		s += "Perso : " + perso;
		return s;
	}
}
