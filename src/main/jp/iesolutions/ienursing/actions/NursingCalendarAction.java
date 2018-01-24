package jp.iesolutions.ienursing.actions;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = LoginAction.SUCCESS, location = "nursing-calendar.jsp") })
public class NursingCalendarAction extends AbstractAction implements
		ModelDriven<Nursing>, Preparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7230616061601834378L;
	private static final Log log = LogFactory.getLog(NursingCalendarAction.class);

	public final Boolean SHOW_CALENDAR_MAIN_TITLE = true;

	public static final String COLOR_FINISH_CHANGE = "yellow";
	public static final String COLOR_FINISH = "#F7EF8D";
	public static final String COLOR_TODAY_ORDER = "#627EB2";
	public static final String COLOR_UN_DO = "cyan";
	public static final String COLOR_ORDER = "#627EB2";
	public static final String COLOR_SKY = "#89d6fa";
	public static final int DEFAULT_LINE_HEIGHT = 400;
	public static final String ADMIN_CODE = "admin";

	@Autowired
	UserService userService;

	@Autowired
	CustomerService customerService;

	@Autowired
	NursingService nursingService;

	private List<Nursing> nursingList;

	public List<Nursing> getNursingList() {
		return nursingList;
	}

	public void setNursingList(List<Nursing> nursingList) {
		this.nursingList = nursingList;
	}

	private List<List<Nursing>> resultsList;

	public List<List<Nursing>> getResultsList() {
		return resultsList;
	}

	public void setResultsList(List<List<Nursing>> resultsList) {
		this.resultsList = resultsList;
	}

	private String requestDate;

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		clearNursingFromSession();
		log.info(userActionEnd(log, "prepare", SUCCESS));
	}

	@Override
	public String execute() throws Exception {
		log.info(userActionStart(log, "execute"));
		processData();
		log.info(userActionEnd(log, "execute", SUCCESS));
		return SUCCESS;
	}

	private void processData() {
		
		if (requestDate == null || requestDate.length() <= 0) {
			if (getSelectDateFromSession() == null) {
				this.setRequestDate(new java.text.SimpleDateFormat("yyyy-MM-dd")
				.format(new Date()));
			} else {
				requestDate = getSelectDateFromSession();
			}
			
		}
		setSelectDateToSession(requestDate);
		try {
			User user = this.getUserFromSession();
			Map<Object, Object> maps = new HashMap<Object, Object>();
			maps.put("visitDate", requestDate);
			if (user.getUserCode().equals(ADMIN_CODE)) {
				nursingList = nursingService.getListByProperty(maps);
			} else {
			//	maps.put("userCodeService", user.getUserCode());
				maps.put("officeCode", user.getOfficeCode());
				nursingList = nursingService.getListByProperty(maps);
			}

		} catch (Exception e) {
			printLog(log, e);
		}

		resultsList = new ArrayList<List<Nursing>>();

		for (int i = 0; i < nursingList.size(); i++) {
			Nursing nursing = nursingList.get(i);
			if (resultsList.size() > 0) {
				Boolean exist = false;
				for (int j = 0; j < resultsList.size(); j++) {
					List<Nursing> innerList = resultsList.get(j);
					if (!innerList.get(0).getUserCode()
							.equals(nursing.getUserCode())) {
						continue;
					} else {
						innerList.add(nursing);
						exist = true;
						break;
					}
				}

				if (!exist) {
					List<Nursing> newInnerList = new ArrayList<Nursing>();
					newInnerList.add(nursing);
					resultsList.add(newInnerList);
				}
			} else {
				List<Nursing> newInnerList = new ArrayList<Nursing>();
				newInnerList.add(nursing);
				resultsList.add(newInnerList);
			}
		}
	}

	@Override
	public Nursing getModel() {
		return null;
	}

	public String getMainContentHeight() {

		int finalLineHeight = (resultsList.size() * 70 + 20);
		finalLineHeight = finalLineHeight > DEFAULT_LINE_HEIGHT ? finalLineHeight
				: DEFAULT_LINE_HEIGHT;
		return finalLineHeight + "px";
	}

	public String getUserName(String userCode) {
		try {
			User newUser = userService.findByProperty("userCode", userCode);
			return newUser.getUserName();
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return null;
	}

	public String getCustomerName(String customerCode) {
		try {
			Customer customer = customerService.findByProperty("customerCode",
					customerCode);
			return customer.getCustomerName();
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return null;
	}

	public String getCustomerProperty(String customerCode) {
		try {
			Customer customer = customerService.findByProperty("customerCode",
					customerCode);
			return customer.getCustomerName();
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return null;
	}

	public String getTypeTime(String id,int type) {
		try {
			Long nursingID = Long.parseLong(id);
			Nursing nursing = nursingService.findById(nursingID);
			if (type == 0) {
//				return "[" +nursing.getTypeBody()+ "]   " +nursing.getTypeBodyTime();
				return "modify for phase2";
			} else {
//				return "[" +nursing.getTypeLive()+ "]   " +nursing.getTypeLiveTime();
				return "modify for phase2";
			}
			
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return null;
	}

	public String getNowTop(double index) {
		return (index * 70) + "px";
	}

	public String getAbsoluteLeft(Nursing nursing) {
		double start = 142;
		double pxForPerMinute = 1.583;

		String string = nursing.getFromTime();
		String strings[] = string.split(":");
		int minutes = (Integer.parseInt(strings[0]) - 8) * 60;
		minutes = minutes + Integer.parseInt(strings[1]);

		double pxNum = minutes * pxForPerMinute + start;
		return pxNum + "px";
	}

	/**
	 * 
	 * @param nursing
	 * @return background-color 0 未実施 : cyan COLOR_UN_DO 1 終了 : #F7EF8D
	 *         COLOR_FINISH 2 終了変更 : yellow COLOR_FINISH_CHANGE 3 本日予定 : #627EB2
	 *         COLOR_TODAY_ORDER 4 予定 : #627EB2 COLOR_ORDER
	 * 
	 */
	public String getBackgroundColor(Nursing nursing) {
		String returnColorStirng = "";
		switch (nursing.getStatus()) {
		case 0:
			returnColorStirng = COLOR_UN_DO;
			break;
		case 1:
			returnColorStirng = COLOR_FINISH;
			break;
		case 2:
			returnColorStirng = COLOR_FINISH_CHANGE;
			break;
		case 3:
			returnColorStirng = COLOR_TODAY_ORDER;
			break;
		case 4:
			returnColorStirng = COLOR_ORDER;
			break;
		case 7:
			returnColorStirng = COLOR_SKY;
			break;
		default:
			break;
		}
		return returnColorStirng;
	}

	private String finalData;

	public String getFinalData() {
		return finalData;
	}

	public void setFinalData(String finalData) {
		this.finalData = finalData;
	}

	public String refreshNursingData() {
		log.info(userActionStart(log, "refreshNursingData"));
		String[] strings = finalData.split(",");
		if (strings.length > 1) {
			for (int i = 0; i < strings.length; i++) {
				if (i % 2 == 0) {
					try {
						String idString = (String) strings[i];
						Nursing nursing = nursingService.findById(Long
								.parseLong(idString));
						String origionFromTime = nursing.getFromTime();
						String origionStopTime = nursing.getEndTime();
						String secondFromTime = (String) strings[++i];
						if (origionFromTime.equals(secondFromTime)) {
							continue;
						}
						nursing.setFromTime(secondFromTime);
						nursing.setEndTime(getEndTime(origionFromTime,
								origionStopTime, secondFromTime));

						nursingService.update(nursing);
					} catch (ServiceException e) {
						printLog(log, e);
					}
				}
			}
		}

		processData();
		log.info(userActionEnd(log, "refreshNursingData", SUCCESS));
		return SUCCESS;
	}

	private String getEndTime(String origionFromTime, String origionStopTime,
			String secondFromTime) {
		String[] origionFromStrings = origionFromTime.split(":");
		String[] origionEndStrings = origionStopTime.split(":");
		String[] secondFromStrings = secondFromTime.split(":");
		int spacetime = (Integer.parseInt(origionEndStrings[0]) - Integer
				.parseInt(origionFromStrings[0]))
				* 60
				+ (Integer.parseInt(origionEndStrings[1]) - Integer
						.parseInt(origionFromStrings[1]));
		int hours = spacetime / 60;
		int minutes = spacetime % 60;
		hours = hours + Integer.parseInt(secondFromStrings[0]);
		minutes = minutes + Integer.parseInt(secondFromStrings[1]);
		String finalMinuteString = minutes + "00";
		finalMinuteString = finalMinuteString.substring(0, 2);
		return hours + ":" + finalMinuteString;
	}
}
