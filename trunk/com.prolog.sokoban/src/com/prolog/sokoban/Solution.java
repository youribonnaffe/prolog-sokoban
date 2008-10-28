package com.prolog.sokoban;

import java.util.ArrayList;
import java.util.Collections;
import java.util.StringTokenizer;

public class Solution {

	class Step {
		String perso;
		ArrayList<String> caisses;
		public Step(){
			perso = "";
			caisses = new ArrayList<String>();
		}
		
		public String toString(){
			return "[Perso="+perso+" Caisses="+caisses.toString()+"]";
		}
	}
	
	ArrayList<Step> steps;
	
	public Solution (String solution) {
		
		// delete begin and end
		solution = solution.replaceAll("^\\[", "");
		solution = solution.replaceAll("\\]$", "");
		
		steps = new ArrayList<Step>();
		solution = solution.replace("]], [", "#");
		StringTokenizer st = new StringTokenizer(solution, "#");
		while(st.hasMoreTokens()) {
			String stringStep = st.nextToken();
			StringTokenizer st2 = new StringTokenizer(stringStep, ",");
			// perso
			Step step = new Step();
			step.perso = st2.nextToken();
			// caisses 
			while(st2.hasMoreTokens()) {
				String elem = st2.nextToken().replace("[", "").replace("]","").trim();
				step.caisses.add(elem);
			}
			steps.add(step);
		}
		
		// right order
		Collections.reverse(steps);
		
	}
	
	public String toString(){
		return steps.toString();
	}
}
