package com.qzn.struts.util;

import org.apache.commons.lang3.StringUtils;

public class SQLUtils extends ClassUtils {
	
	public void makePropertiesSafe( Object obj, String [] excludeProperties ) {
		
		enumStringProperties(obj,excludeProperties);
	}
	
	@Override
	protected String onEnumString( String PropertyName, String originalValue ) {
		
		if( ! StringUtils.isEmpty(originalValue) ) {
			
			originalValue = originalValue.trim();
			
			originalValue = originalValue.replace("'", "");
			
			originalValue = originalValue.replace("\"", "");
		}
			
		return originalValue;
	}
}
