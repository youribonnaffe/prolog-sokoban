package com.prolog.sokoban;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class LevelMaker {

	public static final char CAISSE = '$';
	public static final char CIBLE = '.';
	public static final char PERSO = '@';
	public static final char MUR = '#';
	public static final char VIDE = ' ';

	private static final char WALKABLE = '%';

	Level level;

	public LevelMaker(BufferedReader is) throws IOException {
		int height = 0;
		int width = 0;

		// read characters from stream
		ArrayList<String> al = new ArrayList<String>();
		while (is.ready()) {
			String s = is.readLine();
			if (s != null) {
				if (s.length() > width) {
					width = s.length();
				}
				al.add(s);
				height++;
			}
		}

		// put level into array
		char[][] array = new char[height][width];
		int j = 0;
		for (String s : al) {
			int i;
			for (i = 0; i < s.length(); i++) {
				array[j][i] = s.charAt(i);
			}
			for (; i < width; i++) {
				array[j][i] = ' ';
			}
			j++;
		}

		level = new Level();

		char l = 'a';
		char c;
		for (int i = 0; i < array.length - 1; i++) {
			c = 'a';
			for (j = 0; j < array[i].length - 1; j++) {
				if (array[i][j] == PERSO) {
					level.perso = new String() + l + c;
				}
				if (array[i][j] == CAISSE) {
					level.caisses += (level.caisses.equals("") ? "" : ",")
							+ new String() + l + c;
				}
				if (array[i][j] == CIBLE) {
					level.cibles += (level.cibles.equals("") ? "" : ",")
							+ new String() + l + c;
				}
				c++;
			}
			l++;
		}

		// search for movable block and map all "walkable" piece
		for (int i = 0; i < array.length; i++) {
			for (j = 0; j < array[i].length; j++) {
				if (array[i][j] == CAISSE) {
					// look for walkable space starting from movable object
					// (caisse)
					walk(array, i, j);
				}
			}
		}

		// parse walkable piece, doesn't parse last col, last line
		l = 'a';
		for (int i = 0; i < array.length - 1; i++) {
			c = 'a';
			for (j = 0; j < array[i].length - 1; j++) {
				if (array[i][j] == WALKABLE) {
					if (array[i + 1][j] == WALKABLE) {
						// TODO redo
						level.add(new String() + l + c, new String()
								+ (char) (l + 1) + c);
					}
					if (array[i][j + 1] == WALKABLE) {
						level.add(new String() + l + c, new String() + l
								+ (char) (c + 1));
					}
				}
				c++;
			}
			l++;
		}

	}

	private void walk(char[][] array, int i, int j) {
		if (array[i][j] == CAISSE || array[i][j] == VIDE
				|| array[i][j] == PERSO || array[i][j] == CIBLE) {
			// if piece is walkable, we mark it
			array[i][j] = WALKABLE;
			// recall for others direction
			walk(array, i, j - 1);
			walk(array, i, j + 1);
			walk(array, i + 1, j);
			walk(array, i - 1, j);
		}

	}

	public static void main(String[] args) {
		if (args.length < 1) {
			System.err.println("$1 = level file name");
			return;
		}
		BufferedReader is = null;
		DataOutputStream os = null;
		try {
			is = new BufferedReader(new FileReader(args[0]));
			LevelMaker lm = new LevelMaker(is);
			System.out.println(lm.level.toString());
			// expecting .level file output .pl file
			os = new DataOutputStream(new FileOutputStream(args[0].replace(
					".level", ".pl")));
			lm.level.write(os);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (is != null) {
					is.close();
				}
				if (os != null) {
					os.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
