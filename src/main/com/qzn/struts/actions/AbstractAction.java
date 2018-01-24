/*
 * Copyright 2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.qzn.struts.actions;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.qzn.struts.helper.SystemOptionsHelper;
import com.qzn.struts.models.User;
import com.qzn.struts.models.YearMonth;
import com.qzn.struts.services.AuthService;
import com.qzn.struts.services.MasterService;
import com.qzn.struts.services.exceptions.PermissionsException;
import com.qzn.struts.services.exceptions.ServiceException;
import com.qzn.struts.util.AuthenticateUtil;
import com.qzn.struts.util.PropertiesUtil;
import com.qzn.struts.web.filter.TokenFilter;

import flexjson.JSONSerializer;

public abstract class AbstractAction extends ActionSupport implements
		SessionAware {

	private static final long serialVersionUID = 1571640435103636538L;
	private static final Log log = LogFactory.getLog(AbstractAction.class);

	public final String SESSION_SEARCH_CONDITION = "search_condition_list_" + this.getClass().getSimpleName();
	
	public static final String VIEW = "view";

	public static final String LIST = "list";

	public static final String EDIT = "edit";

	public static final String INPUT = "input";

	private boolean bClearSession = false;
	
	public String getIetoken() {
		String token = (String) session.get(TokenFilter.SESSINO_KEY_TOKEN);
		if (token == null) token = "";
		return TokenFilter.SESSINO_KEY_TOKEN + "=" + token;
	}

	public void setClear(boolean bClear) {
		this.bClearSession = bClear;
	}
	
	public boolean getClear() {
		return bClearSession;
	}
	
	public static final int MENU_ID_SYS_HOME = 1;
	public static final int MENU_ID_MGR_PLAN = 101;
	public static final int MENU_ID_MGR_SHIFT = 102;
	public static final int MENU_ID_MGR_SCHEDULE = 103;
	public static final int MENU_ID_MGR_ACHIEVEMENT = 104;
	public static final int MENU_ID_MGR_WEEK = 105;
	// Modify for Comment - start
	public static final int MENU_ID_MGR_COMMENT = 106;
	// Modify for Comment - end
	public static final int MENU_ID_MST_CUSTOMER = 901;
	public static final int MENU_ID_MST_USER = 902;
	public static final int MENU_ID_MST_OFFICE = 903;
	public static final int MENU_ID_MST_MASTER = 904;
	public static final int MENU_ID_MST_SERVICE = 905;
	
	
	
	public static int getMenuIdSysHome() {
		return MENU_ID_SYS_HOME;
	}

	public static int getMenuIdMgrPlan() {
		return MENU_ID_MGR_PLAN;
	}

	public static int getMenuIdMgrShift() {
		return MENU_ID_MGR_SHIFT;
	}

	public static int getMenuIdMgrSchedule() {
		return MENU_ID_MGR_SCHEDULE;
	}

	public static int getMenuIdMgrAchievement() {
		return MENU_ID_MGR_ACHIEVEMENT;
	}
	
	public static int getMenuIdMgrWeek() {
		return MENU_ID_MGR_WEEK;
	}
	
	// Modify for Comment - start
	public static int getMenuIdMgrComment() {
		return MENU_ID_MGR_COMMENT;
	}
	// Modify for Comment - end

	public static int getMenuIdMstCustomer() {
		return MENU_ID_MST_CUSTOMER;
	}

	public static int getMenuIdMstUser() {
		return MENU_ID_MST_USER;
	}

	public static int getMenuIdMstOffice() {
		return MENU_ID_MST_OFFICE;
	}

	public static int getMenuIdMstMaster() {
		return MENU_ID_MST_MASTER;
	}
	
	public static int getMenuIdMstService() {
		return MENU_ID_MST_SERVICE;
	}

	public boolean isSystemMenu() {
		int menuid = getMenuIdFromSession();
		return (menuid > 0 && menuid < 100);
	}

	public boolean isManageMenu() {
		int menuid = getMenuIdFromSession();
		return (menuid > 100 && menuid < 200);
	}

	public boolean isMasterMenu() {
		int menuid = getMenuIdFromSession();
		return (menuid > 900 && menuid < 1000);
	}

	public String appURL;

	private int menuId;

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	protected Map<String, Object> session;

	@Autowired
	protected AuthService authService;

	@Autowired
	protected MasterService masterService;

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public User getUserFromSession() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		return (User)session.getAttribute(AuthenticateUtil.SESSION_USER);
	}

	public void setUserToSession(User User) {
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute(AuthenticateUtil.SESSION_USER, User);
	}
	
	public void setSelectDateToSession(String date) {
		session.put("requestDate", date);
	}

	public String getSelectDateFromSession() {
		return (String)session.get("requestDate");
	}
	
	public void setSortConditionToSession(String condition) {
		session.put("sortCondition", condition);
	}
	
	public String getSortConditionFromSession() {
		return (String)session.get("sortCondition");
	}
	
	public void setListTypeToSession(int listType) {
		session.put("listType", listType);
	}
	
	public Integer getListTypeFromSession() {
		return (Integer)session.get("listType");
	}

	public int getMenuIdFromSession() {

		Integer v = (Integer) this.session.get("menuid");

		if (v != null) {

			return v;
		} else {
			return 0;
		}

	}

	public void setMenuIdToSession(Integer menuId) {
		session.put("menuid", menuId);
	}

	public void clearMenuIdFromSession() {
		session.remove("menuid");
	}

	public void clearUserFromSession() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.invalidate();
	}
	
	public void clearNursingListFromSession() {
		session.remove(AuthenticateUtil.NURSING_LIST);
	}
	
	public void clearNursingFromSession() {
		session.remove("searchNursing");
	}
	
	public void clearSelectDateFromSession() {
		session.remove("requestDate");
	}
	
	public void clearListTypeFromSession() {
		session.remove("listType");
	}

	public String getAppURL() {
		return appURL;
	}

	public void setAppURL(String appURL) {
		this.appURL = appURL;
	}

	public String toLowerCase(String value) {
		String result = null;
		if (value != null) {
			result = value.toLowerCase();
		}
		return result;
	}

	public List<String> getErrorsList() {
		Map<String, List<String>> fieldErrors = super.getFieldErrors();
		Collection<List<String>> values = fieldErrors.values();
		List<String> errors = new ArrayList<String>();
		for (List<String> value : values) {
			errors.addAll(value);
		}
		errors.addAll(getActionErrors());
		return errors;
	}

	public boolean checkExistId(long id, long[] ids) {
		boolean result = false;
		if (id != 0 && ids != null && ids.length > 0) {
			for (int i = 0; i < ids.length; i++) {
				if (ids[i] == id) {
					result = true;
					break;
				}
			}
		}
		return result;
	}

	public boolean allowUserManage() {

		return authService.allowUserManage(getUserFromSession());
	}

	public void saveSearchCondition(Object search) {
		session.put(SESSION_SEARCH_CONDITION, search);
	}
	
	public Object getSearchCondition() {
		return session.get(SESSION_SEARCH_CONDITION);
	}
	
	public void clearSearchCondition() {
		session.remove(SESSION_SEARCH_CONDITION);
	}

	public String getWelcomeInfo() {

		User User = this.getUserFromSession();

		return this.getText("messages.welcome").replace("<username>",
				User.getUserName());
	}

	public String getAppVersion() {
		String version = "";
		try {
			version = masterService.getUsingAppVersion();
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return version;
	}

	public String getIpadAppURL() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		appURL = "itms-services://?action=download-manifest&url=" + basePath;
		// String basePath = systemEnvirService.applicationURL() + path + "/";
		// appURL = "itms-services://?action=download-manifest&url=" + basePath
		// + "appPlist.plist";
		return appURL;
	}
	
	public boolean isToday(String ym, int day) {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String date = ym + (day < 10 ? "0"+day : "" + day);
		return date.equals(format.format(new Date()));
	}

	public String getCurrMonthKey() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		return format.format(new Date());
	}
	
	public String getCurrMonthValue() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy年MM月");
		return format.format(new Date());
	}

	public String getCurrDay() {
		SimpleDateFormat format = new SimpleDateFormat("d");
		return format.format(new Date());
	}

	public String getPrevYearMonthKeyWithKey(String key) {
		int year = Integer.parseInt(key.substring(0, 4));
		int month = Integer.parseInt(key.substring(4, 6));
		if (month == 1) {
			year--;
			month = 12;
		} else {
			month--;
		}
		return "" + year + (month < 10 ? "0" : "") + month;
	}

	public String getNextYearMonthKeyWithKey(String key) {
		int year = Integer.parseInt(key.substring(0, 4));
		int month = Integer.parseInt(key.substring(4, 6));
		if (month == 12) {
			year++;
			month = 1;
		} else {
			month++;
		}
		return "" + year + (month < 10 ? "0" : "") + month;
	}
	
	public YearMonth getYearMonthWithKey(String key) {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		
		try {
			calendar.setTime(format.parse(key + "01"));
		} catch (ParseException e) {
			printLog(log, e);
		}

		SimpleDateFormat keyFormat = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat lblFormat = new SimpleDateFormat(this.getText("labels.date.ym.format"));
		
		YearMonth month = new YearMonth();
		month.setKey(keyFormat.format(calendar.getTime()));
		month.setLabel(lblFormat.format(calendar.getTime()));
		month.setFirstWeekday(calendar.get(Calendar.DAY_OF_WEEK)-1);
		calendar.roll(Calendar.DATE, -1);
		month.setMaxDays(calendar.get(Calendar.DATE));
		return month;
	}
	
	public List<YearMonth> getRecentlyMonths(boolean isCSV) {
		SimpleDateFormat keyFormat = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat lblFormat = new SimpleDateFormat(this.getText("labels.date.ym.format"));
		Calendar calendar = Calendar.getInstance();
		List<YearMonth> result = new ArrayList<YearMonth>();
		calendar.add(Calendar.MONTH, 1);
		for (int i=0; i<(isCSV?2:12); i++) {
			YearMonth month = new YearMonth();
			month.setKey(keyFormat.format(calendar.getTime()));
			month.setLabel(lblFormat.format(calendar.getTime()));
			result.add(month);
			calendar.add(Calendar.MONTH, -1);
		}
		return result;
	}
	
	public String convertToVerticalHtml(Object obj) {
		if (obj != null) {
			StringBuffer result = new StringBuffer();
			String val = obj.toString();
			if (val.length() > 0) {
				result.append(val.substring(0, 1));
				for (int i=1; i<val.length(); i++) {
					result.append("<br/>" + val.substring(i, i+1));
				}
			}
			return result.toString();
		} else {
			return "";
		}
	}

	/** System Options Helper - Get System Options by Key */
    public String getSystemOption(String key) {
    	return SystemOptionsHelper.getOption(key, "");
    }

	/** System Options Helper - Get System Options by Key */
    public String[] getSystemOptionValues(String key) {
    	return SystemOptionsHelper.getOption(key, "").split(",");
    }

	protected String userActionStart(Log log, String actionName, Object... args) {
		StringBuffer logBuffer = new StringBuffer();
		
		logBuffer.append("User Action [" + actionName + " - start]    ");
		User loginUser = getUserFromSession();
		if (loginUser != null) {
			logBuffer.append("user_code = [" + loginUser.getUserCode() + "]    ");
		}
		HttpServletRequest httpServletRequest = ServletActionContext.getRequest();
		String sessionId = httpServletRequest.getSession().getId();;
		logBuffer.append("SessionID = [" + sessionId + "]    ");
		if (log != null && log.isInfoEnabled()) {
			try {
				Boolean hasArgs = false;
				long userId = 0;
				String username = "nobody";
				String officecode = "none";

				// user info
				User user = this.getUserFromSession();
				if (user != null) {
					userId = user.getId();
					username = user.getUserCode();
					officecode = user.getOfficeCode();
				}

				// args info
				logBuffer.append(" (user id=" + userId + ", user code=" + username
						+ ", office code=" + officecode + ", args ");
				if (args == null || args.length == 0) {
					logBuffer.append("none");
				} else if (args.length % 2 == 1) {
					logBuffer.append("count wrong");
				} else {
					hasArgs = true;
					logBuffer.append("count " + (args.length / 2));
				}
				logBuffer.append(")");

				// args detail info
				if (hasArgs) {
					for (int i = 0; i < args.length; i = i + 2) {
						Object argObj = args[i + 1];
						if (argObj != null) {
							if (argObj instanceof Object[]) {
								argObj = StringUtils.join((Object[]) argObj,
										", ");
							} else if (argObj instanceof Iterator) {
								argObj = StringUtils.join((Iterator) argObj,
										", ");
							}
						}
						logBuffer.append("\r\n           " + args[i] + ": "
								+ argObj);
					}
				}
			} catch (Exception e) {
				printLog(log, e);
				logBuffer.append(" (args log error)");
			}
		}
		return cleanLog(logBuffer.toString());
	}

	protected String userActionEnd(Log log, String actionName, String result,
			Object... args) {
		StringBuffer logBuffer = new StringBuffer();
		logBuffer.append("User Action [" + actionName + " - end]");
		if (log != null && log.isInfoEnabled()) {
			try {
				Boolean hasArgs = false;
				long userId = 0;
				String username = "nobody";
				String officecode = "none";

				// user info
				User user = this.getUserFromSession();
				if (user != null) {
					userId = user.getId();
					username = user.getUserCodeShort();
					officecode = user.getOfficeCode();
				}

				// args info
				logBuffer.append(" (user id=" + userId + ", user code=" + username
						+ ", office code=" + officecode + ", result=" + result
						+ ", vals ");
				if (args == null || args.length == 0) {
					logBuffer.append("none");
				} else if (args.length % 2 == 1) {
					logBuffer.append("count wrong");
				} else {
					hasArgs = true;
					logBuffer.append("count " + (args.length / 2));
				}
				logBuffer.append(")");

				// args detail info
				if (hasArgs) {
					for (int i = 0; i < args.length; i = i + 2) {
						Object argObj = args[i + 1];
						if (argObj != null) {
							argObj = (new JSONSerializer()).serialize(argObj);
						}
						logBuffer.append("\r\n           " + args[i] + ": "
								+ argObj);
					}
				}
			} catch (Exception e) {
				printLog(log, e);
				logBuffer.append(" (vals log error)");
			}
		}
		return cleanLog(logBuffer.toString());
	}
	
	public void printLog(Log log, Exception e){
		//e.printStackTrace();
		log.error(e.getStackTrace());
	}
	
	private String cleanLog(String string) {
		boolean shouldoutput = Boolean.parseBoolean(PropertiesUtil.getPropertiesValue("system.properties", "log.private.info.output"));
		
		if (shouldoutput) {
			return string;
		}
		
		String[] items = {"userName", "userNameKaNa", "customerName", "customerNameKana", "address", "address2", "email", "phoneNumber", "userNameOffline", "userNameFollow", "userNameFollowOffline", "customerNameOffline"};
		for (int i = 0; i < items.length; i++) {
			string = cleanStr(string, "\"" + items[i] + "\"");
		}
		return string;
	}
	
	private String cleanStr(String string, String cleanStr) {
		string = string.replace(":null", ":\"null\"");
		int a = string.indexOf(cleanStr);
		if (a == -1) {
			return string;
		}
		String string1 = string.substring(a);
		String str = string.substring(0, a);
		
		int b = string1.indexOf("\",");
		String string2 = string1;
		if (b == -1) {
			int c = string1.indexOf("\"}");
			if (c != -1) {
				string2 = string1.substring(c + 1);
			}
		} else {
			string2 = string1.substring(b + 2);
		}
		
		String newStr = str + string2;
		return cleanStr(newStr, cleanStr);
	}

	public boolean canDoAction(String action) {
		
		// user.getRoleType() == 0 ヘルパー, == 1 サービス提供責任者, == 2 管理者
		// user.getOfficeCode() == 0 Administrator
		
		boolean result = false;
		if (!StringUtils.isEmpty(action)) {
			User user = getUserFromSession();
			int roleType = user.getRoleType();
			boolean isAdmin = (roleType == 2 && "0".equals(user.getOfficeCode()));
			
			String[] actionPair = action.split("\\.");
			
			String menu = "";
			if (actionPair.length > 0) {
				menu = actionPair[0];
			}
			String method = "";
			if (actionPair.length > 1) {
				method = actionPair[1];
			}
			
			if ("office".equals(menu)) {
				if (isAdmin) {
					result = true;
				}
			} else if ("master".equals(menu)) {
				if (isAdmin) {
					result = true;
				}
			} else if ("service".equals(menu)) {
				if (roleType == 2) {
					result = true;
				}
			} else if ("week".equals(menu)) {
				if (!isAdmin) {
					result = true;
				} else {
					if ("".equals(method)) {
						result = true;
					}
				}
			} else if ("comment".equals(menu)) { // Modify for Comment - start
				if (roleType == 1 || roleType == 2) {
					result = true;
				}
				// Modify for Comment - end
			} else {
				result = true;
			}
		}
		
		return result;
	}
	
	public void checkRoleAction(String action) throws PermissionsException {
		if (!canDoAction(action)) {
			throw new PermissionsException();
		}
	}
}
