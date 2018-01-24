package com.qzn.struts.converter;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;

public interface PDFConverter {

	String getValidDocumentTypeDescription();
	
	boolean validateDocumentType(String extension);
	
	void convertOfficeToPDF(File inputFile, File outputFile, String extension) throws ConverterException, FileNotFoundException, IOException, Base64DecodingException;
	
	void convertOfficeToPDF(InputStream inputStream, OutputStream outputStream, String extension) throws ConverterException, IOException, Base64DecodingException;
}
