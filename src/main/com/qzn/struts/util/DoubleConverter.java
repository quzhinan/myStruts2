package com.qzn.struts.util;

import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

public class DoubleConverter extends StrutsTypeConverter {

	@Override
	public Object convertFromString(Map arg0, String[] arg1, Class arg2) {
		String string = "0";
		if (Double.class == arg2) {
			string = arg1[0];	
		}
		return Double.parseDouble(string);
	}

	@Override
	public String convertToString(Map arg0, Object arg1) {
		return arg1.toString();
	}
}
