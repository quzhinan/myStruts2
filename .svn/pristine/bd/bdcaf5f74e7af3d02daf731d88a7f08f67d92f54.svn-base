package jp.iesolutions.ienursing.actions;

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

import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.services.UserService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = ScheduleAction.SUCCESS, location = "schedule.jsp") })
public class ScheduleAction extends AbstractAction implements ModelDriven<EventItem>, Preparable {

	private static final long serialVersionUID = -7977825353311544153L;

	private static final Log log = LogFactory.getLog(ScheduleAction.class);

	@Autowired
	private UserService userService;

	private User loginUser;

	private YearMonth selectedMonth;
	private String prevMonth;
	private String prevDay;
	private String nextMonth;
	private String nextDay;

	private EventItem searchItem;
	private List<YearMonth> yearMonths;
	private List<User> helpers;

	private int view;

	@Override
	public EventItem getModel() {
		return searchItem;
	}

	public YearMonth getSelectedMonth() {
		return selectedMonth;
	}

	public List<YearMonth> getYearMonths() {
		return yearMonths;
	}

	public String getPrevMonth() {
		return prevMonth;
	}

	public String getPrevDay() {
		return prevDay;
	}

	public String getNextMonth() {
		return nextMonth;
	}

	public String getNextDay() {
		return nextDay;
	}

	public List<User> getHelpers() {
		return helpers;
	}

	public int getHelperCount() {
		return (helpers == null ? 0 : helpers.size());
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}
	
	private long lineHelperId;
	
	public void setLineHelperId(long lineHelperId) {
		this.lineHelperId = lineHelperId;
	}
	
	private float scrollOffset;
	
	public float getScrollOffset() {
		return scrollOffset;
	}

	public String getSystemOption(String key) {

		if (key.equals("work.time.drag.start")) {
			if (view < 0) {
				return "0";
			} else if (view > 0) {
				return super.getSystemOption("work.time.drag.end");
			} else {
				return super.getSystemOption("work.time.drag.start");
			}
		} else if (key.equals("work.time.drag.end")) {
			if (view < 0) {
				return super.getSystemOption("work.time.drag.start");
			} else if (view > 0) {
				return "24";
			} else {
				return super.getSystemOption("work.time.drag.end");
			}
		} else {
			return super.getSystemOption(key);
		}
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (this.getClear()) {
			clearSearchCondition();
		}

		loginUser = getUserFromSession();

		searchItem = (EventItem) getSearchCondition();

		if (searchItem == null) {

			searchItem = new EventItem();
			searchItem.setSearchServiceYm(getCurrMonthKey());
			searchItem.setSearchServiceDay(getCurrDay());
		}

		yearMonths = getRecentlyMonths(false);

		Map<Object, Object> searchMap = new HashMap<Object, Object>();
		searchMap.put("active", String.valueOf(1));
		searchMap.put("officeCode", loginUser.getOfficeCode());
		searchMap.put("roleType", String.valueOf(0));
		helpers = userService.getListByProperty(searchMap, "sortNum, userCode");
		
		scrollOffset = 0;
		for(int i = 0; i < helpers.size(); i++) {
			User helper = helpers.get(i);
			if (helper.getId() == lineHelperId) {
				this.scrollOffset = 52 * i;
			}
		}

		log.info(userActionEnd(log, "prepare", SUCCESS, "searchItem", searchItem, "yearMonths", yearMonths, "helpers",
				helpers));
	}

	public String execute() throws Exception {

		log.info(userActionStart(log, "execute", "searchItem", searchItem));

		selectedMonth = getYearMonthWithKey(searchItem.getSearchServiceYm());

		if (searchItem.getSearchServiceDay() == null || searchItem.getSearchServiceDay().length() == 0
				|| Integer.parseInt(searchItem.getSearchServiceDay()) > selectedMonth.getMaxDays()) {
			searchItem.setSearchServiceDay("1");
		}

		int currDay = Integer.parseInt(searchItem.getSearchServiceDay());
		if (currDay == 1) {
			String prevMonthKey = getPrevYearMonthKeyWithKey(searchItem.getSearchServiceYm());
			if (prevMonthKey.compareTo(yearMonths.get(yearMonths.size() - 1).getKey()) < 0) {
				prevMonth = "";
				prevDay = "";
			} else {
				prevMonth = prevMonthKey;
				prevDay = "" + getYearMonthWithKey(prevMonthKey).getMaxDays();
			}
			nextMonth = searchItem.getSearchServiceYm();
			nextDay = "" + (currDay + 1);
		} else if (currDay == selectedMonth.getMaxDays()) {
			String nextMonthKey = getNextYearMonthKeyWithKey(searchItem.getSearchServiceYm());
			if (nextMonthKey.compareTo(yearMonths.get(0).getKey()) > 0) {
				nextMonth = "";
				nextDay = "";
			} else {
				nextMonth = nextMonthKey;
				nextDay = "1";
			}
			prevMonth = searchItem.getSearchServiceYm();
			prevDay = "" + (currDay - 1);
		} else {
			prevMonth = searchItem.getSearchServiceYm();
			prevDay = "" + (currDay - 1);
			nextMonth = searchItem.getSearchServiceYm();
			nextDay = "" + (currDay + 1);
		}

		this.saveSearchCondition(searchItem);

		log.info(userActionEnd(log, "execute", SUCCESS, "selectedMonth", selectedMonth, "currentDay", currDay));

		return SUCCESS;
	}
}
