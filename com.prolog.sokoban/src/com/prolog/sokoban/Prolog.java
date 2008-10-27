package com.prolog.sokoban;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Prolog {

	static boolean stopProgress = false;
	
	public static void main(String[] args) {

		if (args.length < 3) {
			System.err
			.println("$1 = SWIPL path, $2 = .pl INPUT FILE, $3 = OUTPUT_FILE");
			return;
		}

		// params
		String OUTPUT_FILE = args[2];
		String SWIPL = args[0];
		String INPUT_FILE = args[1];

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

		// read level 
		// TODO (je le ferais) call levelmaker and load .pl level file before sokoban.pl
		
		// prolog
		try {
			Process prologProcess = Runtime.getRuntime().exec(
					SWIPL + " -f " + INPUT_FILE);
			prologProcess.waitFor();
			stopProgress = true;
		} catch (Exception xx) {
			System.out.println(xx);
		}

		// read solution
		BufferedReader is = null;
		try {
			is = new BufferedReader(new FileReader(OUTPUT_FILE));
			System.out.println(is.readLine());
			// expecting .level file output .pl file

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		System.out.println("End !");

	}

}
