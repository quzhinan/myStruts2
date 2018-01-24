package com.qzn.struts.converter.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import com.qzn.struts.converter.ConverterException;
import com.qzn.struts.converter.PDFConverter;

public class PDFConverterInvalid implements PDFConverter {

	@Override
	public String getValidDocumentTypeDescription() {
		return "PDF";
	}

	@Override
	public boolean validateDocumentType(String extension) {
		boolean result = false;
		if (extension != null && extension.equalsIgnoreCase("pdf")) {
			result = true;
		}
		return result;
		
	}
	
	@Override
	public void convertOfficeToPDF(File inputFile, File outputFile, String extension) throws ConverterException, FileNotFoundException, IOException {

		InputStream inputStream = new FileInputStream(inputFile);
		OutputStream outputStream = new FileOutputStream(outputFile);
		
		convertOfficeToPDF(inputStream, outputStream, extension);
		
		inputStream.close();
		outputStream.close();
	}

	@Override
	public void convertOfficeToPDF(InputStream inputStream, OutputStream outputStream, String extension) throws ConverterException, IOException {

		byte buffer[] = new byte[8192];
		int count = 0;
		
		while((count = inputStream.read(buffer)) > 0) {
			outputStream.write(buffer, 0, count);
		}
	}
}
