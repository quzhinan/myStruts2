package com.qzn.struts.converter.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import com.qzn.struts.converter.ConverterException;
import com.qzn.struts.converter.PDFConverter;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;

public class PDFConverterMsAndOpenOffice implements PDFConverter {

	private String openConnectionUrl;
	private int openConnectionPort;
	private String msConnectionUrl;
	private int msConnectionPort;
	private String dotNetAction;

	
	public void setOpenConnectionUrl(String openConnectionUrl) {
		this.openConnectionUrl = openConnectionUrl;
	}
	public void setOpenConnectionPort(int openConnectionPort) {
		this.openConnectionPort = openConnectionPort;
	}
	public void setMsConnectionUrl(String msConnectionUrl) {
		this.msConnectionUrl = msConnectionUrl;
	}
	public void setMsConnectionPort(int msConnectionPort) {
		this.msConnectionPort = msConnectionPort;
	}
	public void setDotNetAction(String dotNetAction) {
		this.dotNetAction = dotNetAction;
	}
	@Override
	public String getValidDocumentTypeDescription() {
		return "PDF,DOC,XLS,PPT,XDW";
	}

	@Override
	public boolean validateDocumentType(String extension) {
		boolean result = false;
		
		if (extension != null) {
			String extensionLowerCase = extension.toLowerCase();
			if (extensionLowerCase.equals("pdf") ||
					extensionLowerCase.equals("doc") ||
					extensionLowerCase.equals("docx") ||
					extensionLowerCase.equals("xls") ||
					extensionLowerCase.equals("xlsx") ||
					extensionLowerCase.equals("ppt") ||
					extensionLowerCase.equals("pptx")||
					extensionLowerCase.equals("xdw")) {
				result = true;
			}
		}
		
		return result;
	}

	@Override
	public void convertOfficeToPDF(File inputFile, File outputFile,
			String extension) throws ConverterException, FileNotFoundException,
			IOException, Base64DecodingException {
		String extensionLowerCase = extension.toLowerCase();
		if (extensionLowerCase.equals("xdw")) {
			PDFConverterMsOffice pdfConverterMsOffice = new PDFConverterMsOffice();
			pdfConverterMsOffice.setConnectionUrl(msConnectionUrl);
			pdfConverterMsOffice.setConnectionPort(msConnectionPort);
			pdfConverterMsOffice.setDotNetAction(dotNetAction);
			pdfConverterMsOffice.convertOfficeToPDF(inputFile, outputFile, extension);
		} else {
			PDFConverterOpenOffice pdfConverterOpenOffice = new PDFConverterOpenOffice();
			pdfConverterOpenOffice.setConnectionUrl(openConnectionUrl);
			pdfConverterOpenOffice.setConnectionPort(openConnectionPort);
			pdfConverterOpenOffice.convertOfficeToPDF(inputFile, outputFile, extension);
		}
	}

	@Override
	public void convertOfficeToPDF(InputStream inputStream,
			OutputStream outputStream, String extension)
			throws ConverterException, IOException, Base64DecodingException {
		String extensionLowerCase = extension.toLowerCase();
		if (extensionLowerCase.equals("xdw")) {
			PDFConverterMsOffice pdfConverterMsOffice = new PDFConverterMsOffice();
			pdfConverterMsOffice.setConnectionUrl(msConnectionUrl);
			pdfConverterMsOffice.setConnectionPort(msConnectionPort);
			pdfConverterMsOffice.setDotNetAction(dotNetAction);
			pdfConverterMsOffice.convertOfficeToPDF(inputStream, outputStream, extension);
		} else {
			PDFConverterOpenOffice pdfConverterOpenOffice = new PDFConverterOpenOffice();
			pdfConverterOpenOffice.setConnectionUrl(openConnectionUrl);
			pdfConverterOpenOffice.setConnectionPort(openConnectionPort);
			pdfConverterOpenOffice.convertOfficeToPDF(inputStream, outputStream, extension);
		}
	}
}
