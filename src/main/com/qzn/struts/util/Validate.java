package com.qzn.struts.util;

public class Validate {

	public static boolean checkEmail(String text) {
		
		if ( text.matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$")) {

			return true;
		}	
		return false;
	}
	
	public static boolean checkEnglish(String text) {

		for (int i = 0; i < text.length(); i++) {
			
			if( ! ( (text.charAt(i) >= 48 && text.charAt(i) <= 57) ||
					(text.charAt(i) >= 65 && text.charAt(i) <= 90) ||
					(text.charAt(i) >= 97 && text.charAt(i) <= 122)
				  ) )
			{
				return false;
			}
		}
		
		return true;
	}
	
	public static boolean checkID( String text ) {
		
		text = text.replace("-", "").replace("_", "");
		
		return checkEnglish(text);
	}
}
