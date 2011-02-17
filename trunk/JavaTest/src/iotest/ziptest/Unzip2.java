package iotest.ziptest;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class Unzip2 {

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		FileInputStream fin = new FileInputStream("book.zip");
	      ZipInputStream zin = new ZipInputStream(fin);
	      ZipEntry ze = null;
	      while ((ze = zin.getNextEntry()) != null) {
	        System.out.println("Unzipping " + ze.getName());
	        FileOutputStream fout = new FileOutputStream(ze.getName());
	        for (int c = zin.read(); c != -1; c = zin.read()) {
	          fout.write(c);
	        }
	        zin.closeEntry();
	        fout.close();
	      }
	      zin.close();
	    }
	}

