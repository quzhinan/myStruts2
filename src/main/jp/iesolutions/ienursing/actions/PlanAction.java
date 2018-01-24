package jp.iesolutions.ienursing.actions;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;

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
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.PlanActual;
import jp.iesolutions.ienursing.models.ServiceUnitTotal;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.OfficeService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = PlanAction.SUCCESS, location = "plan.jsp"),
		@Result(name = PlanAction.LIST, location = "plan.ies?${ietoken}", type = "redirect"),
		@Result(name = "list2", location = "plan.ies?deleteSize=-1&${ietoken}", type = "redirect") })

public class PlanAction extends AbstractAction implements ModelDriven<EventItem>, Preparable {

	private static final long serialVersionUID = -5636640845121024027L;

	private static final Log log = LogFactory.getLog(PlanAction.class);

	@Autowired
	private CustomerService customerService;

	@Autowired
	private EventService eventService;

	@Autowired
	private OfficeService officeService;

	private User loginUser;

	private long customerId;
	private String customerName;
	private YearMonth selectedMonth;
	private String prevMonthKey;
	private String nextMonthKey;

	private ServiceUnitTotal total;
	private EventItem searchItem;
	private List<YearMonth> yearMonths;
	private List<YearMonth> yearMonthsCSV;
	private List<Customer> customers;
	private List<PlanActual> achievements;

	private boolean planActualDifference;

	private String[] keys;

	@Override
	public EventItem getModel() {
		return searchItem;
	}

	public long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public YearMonth getSelectedMonth() {
		return selectedMonth;
	}

	public String getPrevMonthKey() {
		return prevMonthKey;
	}

	public String getNextMonthKey() {
		return nextMonthKey;
	}

	public ServiceUnitTotal getTotal() {
		return total;
	}

	public List<YearMonth> getYearMonths() {
		return yearMonths;
	}

	public List<YearMonth> getYearMonthsCSV() {
		return yearMonthsCSV;
	}

	public List<Customer> getCustomers() {
		return customers;
	}

	public List<PlanActual> getAchievements() {
		return achievements;
	}

	public void setKeys(String[] keys) {
		this.keys = keys;
	}

	public boolean getPlanActualDifference() {
		return planActualDifference;
	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare", "customerId", customerId));

		if (this.getClear()) {
			clearSearchCondition();
		}

		loginUser = getUserFromSession();

		searchItem = (EventItem) getSearchCondition();

		if (searchItem == null) {

			searchItem = new EventItem();
			searchItem.setSearchServiceYm(getCurrMonthKey());
		}

		if (customerId > 0) {
			searchItem.setSearchCustomerId(customerId);
		}

		customerId = searchItem.getSearchCustomerId();

		Customer customer = customerService.findById(customerId);
		if (customer != null) {
			customerName = customer.getCustomerName();
		}

		yearMonths = getRecentlyMonths(false);
		yearMonthsCSV = getRecentlyMonths(true);

		log.info(userActionEnd(log, "prepare", SUCCESS, "searchItem", searchItem, "customerId", customerId,
				"customerName", customerName, "yearMonths", yearMonths, "yearMonthsCSV", yearMonthsCSV));

	}

	public String execute() throws Exception {

		log.info(userActionStart(log, "execute", "searchItem", searchItem, "yearMonths", yearMonths, "officeCode",
				loginUser.getOfficeCode()));

		selectedMonth = getYearMonthWithKey(searchItem.getSearchServiceYm());
		prevMonthKey = getPrevYearMonthKeyWithKey(searchItem.getSearchServiceYm());
		nextMonthKey = getNextYearMonthKeyWithKey(searchItem.getSearchServiceYm());

		if (prevMonthKey.compareTo(yearMonths.get(yearMonths.size() - 1).getKey()) < 0)
			prevMonthKey = "";
		if (nextMonthKey.compareTo(yearMonths.get(0).getKey()) > 0)
			nextMonthKey = "";

		customers = customerService.loadByOfficeCode(loginUser.getOfficeCode(), searchItem.getSearchCustomerName());

		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());

		if (office != null) {
			if (customerId > 0) {
				achievements = eventService.loadPlanActual(office.getId(), customerId, selectedMonth.getKey());
				planActualDifference = eventService.checkPlanActualHasDifference(achievements);
			}
			total = eventService.loadServiceUnitTotal(office.getId(), customerId, selectedMonth.getKey());
		}

		this.saveSearchCondition(searchItem);

		log.info(userActionEnd(log, "execute", SUCCESS, "selectMonth", selectedMonth, "nextMonthKey", nextMonthKey,
				"prevMonthKey", prevMonthKey, "planActualDifference", planActualDifference, "total", total, "customers",
				customers));
		return SUCCESS;
	}

	public String jikannhennkou() throws Exception {
		this.execute();
		return LIST;
	}

	private int startDay;
	private int stopDay;

	public int getStartDay() {
		return startDay;
	}

	public void setStartDay(int startDay) {
		this.startDay = startDay;
	}

	public int getStopDay() {
		return stopDay;
	}

	public void setStopDay(int stopDay) {
		this.stopDay = stopDay;
	}

	private int deleteSize = -2;

	public int getDeleteSize() {
		return deleteSize;
	}
	
	public void setDeleteSize(int deleteSize) {
		this.deleteSize = deleteSize;
	}

	public String bulkDelete() throws Exception {
		log.info(userActionStart(log, "bulkDelete", "officeCode", loginUser.getOfficeCode(), "customerId", customerId,
				"keys", keys, "YM", searchItem.getSearchServiceYm()));

		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());

		if (office != null && customerId > 0) {
			deleteSize = eventService.deleteByServiceTimeKeysAndTime(office.getId(), customerId, searchItem.getSearchServiceYm(),
					keys, startDay, stopDay);
		}

		log.info(userActionEnd(log, "bulkDelete", LIST));
		if (deleteSize == -1) {
			return "list2";
		}
		return LIST;
	}

	public boolean getChoooseYM() {

		return true;
	}

	public String getDefaultCSVYM() {

		String systemYM = "";
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		if (month == 12) {
			systemYM = (year + 1) + "01";
		} else {
			month++;
			if (month > 9) {
				systemYM = year + "" + month;
			} else {
				systemYM = year + "0" + month;
			}

		}
		return systemYM;

	}

	public List<MonthDay> getMonthDayList() {
		List<MonthDay> monthDays = new ArrayList<MonthDay>();

		Calendar cal = new GregorianCalendar();

		/** 设置date **/
		SimpleDateFormat oSdf = new SimpleDateFormat("", Locale.JAPANESE);
		oSdf.applyPattern("yyyyMM");
		try {
			cal.setTime(oSdf.parse(searchItem.getSearchServiceYm()));
		} catch (Exception e) {
			printLog(log, e);
		}

		/** 开始用的这个方法获取实际月的最大天数 **/
		int num2 = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		for (int i = 1; i <= num2; i++) {
			monthDays.add(new MonthDay(i, i + ""));
		}

		return monthDays;
	}

	class MonthDay {
		int key;
		String value;

		public MonthDay(int key, String value) {
			this.key = key;
			this.value = value;
		}

		public int getKey() {
			return key;
		}

		public void setKey(int key) {
			this.key = key;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}

	}

}
