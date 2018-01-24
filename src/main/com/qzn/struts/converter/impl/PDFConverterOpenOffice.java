package com.qzn.struts.converter.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ConnectException;

import com.artofsolving.jodconverter.DefaultDocumentFormatRegistry;
import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.DocumentFormat;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.qzn.struts.converter.ConverterException;
import com.qzn.struts.converter.PDFConverter;

public class PDFConverterOpenOffice implements PDFConverter {

	private String connectionUrl;
	private int connectionPort;
	private String dotNetAction;
	
	public void setConnectionUrl(String connectionUrl) {
		this.connectionUrl = connectionUrl;
	}
	
	
	public void setConnectionPort(int connectionPort) {
		this.connectionPort = connectionPort;
	}


	public void setDotNetAction(String dotNetAction) {
		this.dotNetAction = dotNetAction;
	}

	@Override
	public String getValidDocumentTypeDescription() {
		return "PDF,TXT,DOC,XLS,PPT";
	}


	@Override
	public boolean validateDocumentType(String extension) {
		boolean result = false;
		
		if (extension != null) {
			String extensionLowerCase = extension.toLowerCase();
			if (extensionLowerCase.equals("pdf") ||
					extensionLowerCase.equals("txt") ||
					extensionLowerCase.equals("doc") ||
					extensionLowerCase.equals("docx") ||
					extensionLowerCase.equals("xls") ||
					extensionLowerCase.equals("xlsx") ||
					extensionLowerCase.equals("ppt") ||
					extensionLowerCase.equals("pptx")) {
				result = true;
			}
		}
		
		return result;
	}


	@Override
	public void convertOfficeToPDF(File inputFile, File outputFile, String extension) 
			throws ConverterException, FileNotFoundException, IOException {
		InputStream inputStream = new FileInputStream(inputFile);
		OutputStream outputStream = new FileOutputStream(outputFile);
		
		convertOfficeToPDF(inputStream, outputStream, extension);
		
		inputStream.close();
		outputStream.close();	
	}


	@Override
	public void convertOfficeToPDF(InputStream inputStream,
			OutputStream outputStream, String extension)
			throws ConverterException, IOException {
		
		if ("pdf".equalsIgnoreCase(extension)) {
			byte buffer[] = new byte[8192];
			int count = 0;
			while((count = inputStream.read(buffer)) > 0) {
				outputStream.write(buffer, 0, count);
			}
		} else {
			DefaultDocumentFormatRegistry formatReg = new DefaultDocumentFormatRegistry(); 
			DocumentFormat pdf = formatReg.getFormatByFileExtension("pdf"); 
			DocumentFormat doc = formatReg.getFormatByFileExtension(extension);
			
			OpenOfficeConnection connection = new SocketOpenOfficeConnection(connectionUrl, connectionPort);
			
			try {
				connection.connect();
			} catch (ConnectException e) {
				throw new ConverterException("connect to server failed");
			}
			
			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
			converter.convert(inputStream, doc, outputStream, pdf);
			
			// close the connection
			connection.disconnect();
		}	
	}
}
