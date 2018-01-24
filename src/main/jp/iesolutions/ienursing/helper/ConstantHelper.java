package jp.iesolutions.ienursing.helper;

import java.util.ArrayList;
import java.util.List;

import jp.iesolutions.ienursing.models.Constant;
import jp.iesolutions.ienursing.services.ConstantService;

public class ConstantHelper {

	/* System Parameter List */
	private static List<Constant> options = null;
	/* System Parameter List End */
	

	/** Helper Instance */
	private static ConstantHelper instance;
	public static ConstantHelper getInstance() { return instance; }
	public void setInstance(ConstantHelper constantHelper) throws Exception {
		instance = constantHelper;
		instance.refresh();
	}

	/* Auto Set Service */
	private ConstantService constantService;
	public void setConstantService(ConstantService constantService) { this.constantService = constantService; }
	/* Auto Set Service End */
	
	public synchronized void refresh() throws Exception {
		if (options != null) {
			options.clear();
		}
		options = constantService.loadAll();
	}
	
	public static List<Constant> getOptions(String code) {
		List<Constant> list = new ArrayList<Constant>();
		for (Constant constant : options) {
			if (constant.getCode().equals(code)) {
				list.add(constant);
			}
		}
		return list;
	}
	
	public static String getLabel(String code, String value) {
		return getLabel(code, value, "");
	}
	
	public static String getLabel(String code, String value, String defaultValue) {
		for (Constant constant : options) {
			if (constant.getCode().equals(code) && constant.getValue().equals(value)) {
				return constant.getLabel();
			}
		}
		return defaultValue;
	}

	public static String getRemark(String code, String value) {
		for (Constant constant : options) {
			if (constant.getCode().equals(code) && constant.getValue().equals(value)) {
				return constant.getRemark();
			}
		}
		return "";
	}
	
	public static final List<Constant> all() {
		return options;
	}

}
