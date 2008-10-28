package com.prolog.sokoban;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;

public class Prolog {

	static boolean stopProgress = false;
	public static final int NB_MAX_COUPS = 42;

	public static void main(String[] args) {

		if (args.length < 4) {
			System.err
					.println("$1 = SWIPL path, $2 = .pl INPUT FILE, $3 = OUTPUT_FILE, $4 = LEVEL_FILE");
			return;
		}

		// params
		String output_file = args[2];
		String swipl = args[0];
		String input_file = args[1];
		String level_file = args[3];

		// read level
		BufferedReader is = null;
		DataOutputStream os = null;
		try {
			is = new BufferedReader(new FileReader(level_file));
			LevelMaker lm = new LevelMaker(is);
			System.out.println(lm.level.toString());
			// expecting .level file output .pl file
			level_file = level_file.replace(".level", ".pl");
			os = new DataOutputStream(new FileOutputStream(level_file));
			os.writeBytes(":-include('"+input_file+"').");
			os.writeByte('\n');
			
			lm.level.write(os);
			
			// append position caisse, position perso, predicat and co
			os.writeByte('\n');
			os.writeBytes("sokoban(ChSol):-sokoban(gd,["+lm.level.caisses+"],["+lm.level.cibles+"],[],"+NB_MAX_COUPS+",ChSol).");
			os.writeByte('\n');
			os.writeBytes(":- open('"+output_file+"',write,OS), sokoban(ChSol), write(OS,ChSol), halt.");
			os.writeByte('\n');

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

		// progress bar thread
		Thread progressBar = new Thread() {
			public void run() {
				while (!stopProgress) {
					System.out.println("Working...");
					try {
						Thread.sleep(2000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		};
		progressBar.start();

		// prolog
		try {
			Process prologProcess = Runtime.getRuntime().exec(
					swipl + " -f " + level_file);
			prologProcess.waitFor();
			stopProgress = true;
		} catch (Exception xx) {
			System.out.println(xx);
		}

		// read solution
		BufferedReader is2 = null;
		try {
			is2 = new BufferedReader(new FileReader(output_file));
			String s = is2.readLine();
			System.out.println("Solution is : ");
			System.out.println(new Solution(s));
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is2 != null)
				try {
					is2.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		System.out.println("End !");

	}

}
