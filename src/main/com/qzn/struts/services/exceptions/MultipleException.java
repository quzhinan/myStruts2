package com.qzn.struts.services.exceptions;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.LocalizedTextUtil;

public class MultipleException extends ServiceException {
	
	private static final long serialVersionUID = -3550962042073379539L;
	
	private Map<String,Map<String,String>> map = new HashMap<String,Map<String,String>>();

	public MultipleException() {
		
	}

	public MultipleException(String message) {
		super(message);
		
	}

	public MultipleException(String message, Throwable cause) {
		super(message, cause);
		
	}

	public MultipleException(Throwable cause) {
		super(cause);
		
	}
	
	public MultipleException(String message,String msgKey, Map<String,String>args) {
		super(message);
		map.put(msgKey, args);
	}
	
	public MultipleException(String message,Piece piece) {
		super(message);
		map.put(piece.msgKey, piece.args);
	}
	
	public void addMsgPiece( String msgKey, Map<String,String> args ) {
		map.put(msgKey, args);
	}
	
	public void addMsgPiece( Piece piece ) {
		map.put(piece.msgKey, piece.args);
	}
	
	public static Piece createMsgPiece( String msgKey ) {
		return new Piece(msgKey);
	}
	
	public static class Piece {
		
		public String msgKey;
		
		public Map<String,String> args = new HashMap<String,String>(); 
		
		public Piece( String msgKey ) {
			this.msgKey = msgKey;
		}
		
		public Piece addArg(String argKey, String value) {
			args.put(argKey, value);
			return this;
		}
		
		public Piece addArg(String argKey, int value) {
			args.put(argKey, ((Integer)value).toString());
			return this;
		}
		
		public Piece addArg(String argKey, long value) {
			args.put(argKey, ((Long)value).toString());
			return this;
		}
	}
	
	@Override
	public String getMessage() {
		
		return getMessage( null );
	}
	
	public String getMessage( ActionSupport action ) {
		
		String msg = super.getMessage();
		
		Locale locale;
		
		if( action == null ) {
			
			locale = new Locale("ja_JP");//zh_CN
			
		}else {
			
			locale = action.getLocale();
			
			if( locale == null ) //Action context not initialized
				locale = new Locale("ja_JP");
		}
		
		
		Iterator<Entry<String,Map<String,String>>> iter = map.entrySet().iterator();
		
		while( iter.hasNext() ) {
			
			Entry<String,Map<String,String>> next = iter.next();
			
			String msgKey = next.getKey();
			
			String msgKeyBak = msgKey;
			
			if( msgKey.indexOf("<")==0 || msgKey.indexOf("{") == 0 )
				msgKey = msgKey.substring(1);
			
			if( msgKey.lastIndexOf(">")==(msgKey.length()-1) || msgKey.lastIndexOf("}")==(msgKey.length()-1) )
				msgKey = msgKey.substring(0, msgKey.length()-1);
			
			String subMsg;
			
			if( action == null )
				subMsg = LocalizedTextUtil.findDefaultText(msgKey, locale);
			else
				subMsg = LocalizedTextUtil.findText(action.getClass(), msgKey, locale);
			
			if( StringUtils.isEmpty(subMsg) )
				continue;
			
			Map<String,String> argsMap = next.getValue();
			
			Iterator<Entry<String,String>> iter2 = argsMap.entrySet().iterator();
			
			while( iter2.hasNext() ) {
				
				Entry<String,String> arg = iter2.next();
				
				String argName = arg.getKey();
				
				String argValue = arg.getValue();
				
				subMsg = subMsg.replace(argName, argValue);
			}
			
			msg = msg.replace(msgKeyBak, subMsg);
		}
		
		return msg;
	}
}
