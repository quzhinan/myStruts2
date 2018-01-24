package com.qzn.struts.util;

import java.io.IOException;
import java.util.Properties;

public class PropertiesUtil {

	public static String getPropertiesValue(String fileName, String key) {
		String value = "";
		Properties prop = new Properties();
		try {
			prop.load(PropertiesUtil.class.getClassLoader().getResourceAsStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		value = (String) prop.get(key);
		return value;
	}

	public static String getPropertiesValue(String key) {
		return getPropertiesValue("system.properties", key);
	}
}
