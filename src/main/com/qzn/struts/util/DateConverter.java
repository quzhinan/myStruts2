package com.qzn.struts.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.opensymphony.xwork2.conversion.impl.DefaultTypeConverter;

public class DateConverter extends DefaultTypeConverter{
	private static final String[] FORMAT = {
		"HH", // 2
		"yyyy", // 4
		"HH:mm", // 5
		"yyyy-MM", // 7
		"HH:mm:ss", // 8
		"yyyy-MM-dd", // 10
		"yyyy-MM-dd HH", // 13
		"yyyy-MM-dd HH:mm", // 16
		"yyyy-MM-dd HH:mm:ss" // 19
	};

	private static final DateFormat[] ACCEPT_DATE_FORMATS = new DateFormat[FORMAT.length];

	static {
		for (int i = 0; i < FORMAT.length; i++) {
			ACCEPT_DATE_FORMATS[i] = new SimpleDateFormat(FORMAT[i]);
		}
	}

	public Object convertValue(Map context, Object value, Class toType) {
		
		//convert string to date when client->server
		if (toType == Date.class) {

			String[] params = (String[]) value;
			
			String dateString = params[0];
			
			int len = dateString != null ? dateString.length() : 0;
			
			int index = -1;

			if (len > 0) {
				
				for (int i = 0; i < FORMAT.length; i++) {
					
					if (len == FORMAT[i].length()) {
						
						index = i;
						
						break;
						
					}
				}
			}

			if (index >= 0) {
				
				try {
					
					return ACCEPT_DATE_FORMATS[index].parse(dateString);
					
				} catch (ParseException e) {
					return null;
				}
			}
			
			return null;
			
		} else if (toType == String.class) {
			//convert date to string when server->client

			Date date = (Date) value;

			return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		}

		return null;
	}
}
