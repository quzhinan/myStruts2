package com.qzn.struts.helper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qzn.struts.models.Environment;
import com.qzn.struts.services.EnvironmentService;

public class SystemOptionsHelper {

	/** Log Recorder */
	private static final Log log = LogFactory.getLog(SystemOptionsHelper.class);

	/* System Parameter List */
	private static Map<String, Environment> options = new HashMap<String, Environment>();
	/* System Parameter List End */

	/** Helper Instance */
	private static SystemOptionsHelper instance;
	public static SystemOptionsHelper getInstance() { return instance; }
	public void setInstance(SystemOptionsHelper _instance) { instance = _instance; }

	/* Auto Set Service */
	private EnvironmentService environmentService;
	public void setEnvironmentService(EnvironmentService environmentService) { this.environmentService = environmentService; }
	/* Auto Set Service End */
	
	public void refresh() {
		options.clear();
		try {
			List<Environment> list = environmentService.loadAll();
			for (Environment environment : list) {
				options.put(environment.getKey(), environment);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(e);
		}
	}
	
	public static Environment getOption(String key) {
		if (options.size() == 0) {
			instance.refresh();
		}
		return options.get(key);
	}
	
	public static int getOption(String key, int defaultValue) {
		Environment environment = getOption(key);
		if (environment != null && environment.getValue() != null) {
			return Integer.parseInt(environment.getValue());
		}
		return defaultValue;
	}

	public static boolean getOption(String key, boolean defaultValue) {
		Environment environment = getOption(key);
		if (environment != null && environment.getValue() != null) {
			if (environment.getValue().length() == 0 || environment.getValue().equals("0")) {
				return false;
			} else {
				return true;
			}
		}

		return defaultValue;
	}
	
	public static String getOption(String key, String defaultValue) {
		Environment environment = getOption(key);
		if (environment != null && environment.getValue() != null) {
			return environment.getValue();
		}
		return defaultValue;
	}
}
