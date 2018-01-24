package com.qzn.struts.converter.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.InetAddress;
import java.net.NoRouteToHostException;
import java.net.Socket;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qzn.struts.converter.ConverterException;
import com.qzn.struts.converter.PDFConverter;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;

import sun.misc.BASE64Decoder;

public class PDFConverterMsOffice implements PDFConverter {

	private final Log log = LogFactory.getLog(PDFConverterMsOffice.class);
	
	private static final String SPLITTOKEN = ",";
	
	private String[] connectionUrl;
	private int connectionPort;
	private String dotNetAction;

	public void setConnectionUrl(String connectionUrl) {
		
		if(connectionUrl.indexOf(SPLITTOKEN) == -1) {
			
			this.connectionUrl = new String[1];
			this.connectionUrl[0] = connectionUrl;
		} else {
		
			this.connectionUrl = connectionUrl.split(SPLITTOKEN);
		}
	}
	
	public void setConnectionPort(int connectionPort) {
		this.connectionPort = connectionPort;
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
		InputStream inputStream = new FileInputStream(inputFile);
		OutputStream outputStream = new FileOutputStream(outputFile);
		
		convertOfficeToPDF(inputStream, outputStream, extension);
		
		inputStream.close();
		outputStream.close();	
		
	}


	@Override
	public void convertOfficeToPDF(InputStream inputStream,
			OutputStream outputStream, String extension)
			throws ConverterException, IOException, Base64DecodingException {

		OutputStream out = null;
		BufferedReader outString = null;
		Socket socket = null;
		
		if ("pdf".equalsIgnoreCase(extension)) {
			byte buffer[] = new byte[8192];
			int count = 0;
			while((count = inputStream.read(buffer)) > 0) {
				outputStream.write(buffer, 0, count);
			}
		}else{

			String connect = null;
			
	        for(int i=0;i<connectionUrl.length;i++) {
	        	
	        	try{
		        	InetAddress addr = InetAddress.getByName(connectionUrl[i]);
		        	socket = new Socket(addr, connectionPort);	
		        	connect = connectionUrl[i];
		        	break;
	        	  
	        	}catch (ConnectException e) {
					
	        		if(i>= connectionUrl.length-1) {
	        			throw e;
	        		}
	        		
	        		continue;
				}catch (NoRouteToHostException e) {
					
	        		if(i>= connectionUrl.length-1) {
	        			throw e;
	        		}
	        		
	        		continue;
				}
	        }

	        out = socket.getOutputStream();
	        
	        InputStream in = socket.getInputStream();  
	        
	        outString = new BufferedReader(new InputStreamReader(in));
	        
	        StringBuffer sb =new StringBuffer();  
	        sb.append("POST ").append(dotNetAction).append(" HTTP/1.1\r\n").append("Host: ").append(connect).append(":").append(connectionPort).append("\r\n")
	          .append("Content-Length: ").append(String.valueOf(inputStream.available())).append("\r\n")
	          .append("Content-Type: ").append(extension).append("\r\n")
	          .append("Accept-Language: zh-cn,zh;q=0.5\r\n").append("Accept-Encoding: gzip, deflate\r\n")
	          .append("Accept-Charset: GB2312,utf-8;q=0.7,*;q=0.7\r\n")
	          //.append("Connection: keep-alive\r\n")
	          .append("\r\n"); 	
	        
			int bytesRead=0;	
			
			byte[] buffer=new byte[131072];	
			
			out.write(sb.toString().getBytes());
			
			while((bytesRead=inputStream.read(buffer))!=-1){	
				
				out.write(buffer,0,bytesRead);
			} 

	        out.flush();
	        
		       String line = null;     
		       int contentLength = 0; 
		       if(contentLength == 0){ 
			       while((line = outString.readLine()) != null){
			    	   if(line.length()!= 0){//
				    	   String[] strs = line.split(":");   
				           if(strs != null && strs.length !=0 && strs[0].equals("Content-Length")){  	   	   
				        	   String fileCountStr = strs[1].trim();	        	    
				        	   if(Integer.parseInt(fileCountStr) != 0){
				        		   contentLength = Integer.parseInt(fileCountStr);
					        	   break;
				        	   }//end if
				           }// end if
			    	   }//end if(line.length()!= 0)
			      }//end while((line = rd.readLine()) != null)
		      }//end if(contentLength == 0) 
		       
			String headerEndLine;
	
			while((headerEndLine = outString.readLine()) != null){
			    	  
			   if(headerEndLine.length() == 0){
			       break;
			     }
			 }
			
		      if(contentLength != 0){
		    	  
		  		  StringBuilder base64Sb = new StringBuilder(10*1024*1024);
			      
			      int len;
			      char[] c = new char[131072];
			      while((len = outString.read(c)) != -1){
			    	  base64Sb.append(c, 0, len);
			      }
			      BASE64Decoder decoder = new BASE64Decoder();
			     
			      byte[] newBytes = decoder.decodeBuffer(base64Sb.toString());
			      
			      outputStream.write(newBytes);
			      outputStream.flush();

		      }else{
		    	  
		    	  throw new ConverterException("errors.meeting.document.converter.failed");
		      }
		      outString.close();
		      out.close();
		      socket.close();
		}
	}
}
