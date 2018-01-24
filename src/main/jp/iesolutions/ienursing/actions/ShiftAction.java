package jp.iesolutions.ienursing.actions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.UserService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = {
		@Result(name=ShiftAction.SUCCESS, location="shift.jsp")
})

public class ShiftAction extends AbstractAction implements
		ModelDriven<EventItem>, Preparable {

	private static final long serialVersionUID = -8741588419801733281L;

//	private static final Log log = LogFactory.getLog(PlanAction.class);

	private static final Log log = LogFactory.getLog(ShiftAction.class);
	
	@Autowired
	private UserService userService;

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
	
	private EventItem searchItem;
	private List<YearMonth> yearMonths;
	private List<User> helpers;
	private List<Customer> customers;
	private List<Event> events;

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

	public List<YearMonth> getYearMonths() {
		return yearMonths;
	}

	public List<User> getHelpers() {
		return helpers;
	}

	public List<Event> getEvents() {
		return events;
	}

	public List<Customer> getCustomers() {
		return customers;
	}
	
	public int getSelectedMonthWeeks() {
		return (int)(selectedMonth.getMaxDays() + selectedMonth.getFirstWeekday() + 6) / 7;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if( this.getClear() ) {
			clearSearchCondition();
		}
		
		loginUser = getUserFromSession();
		
		searchItem = (EventItem)getSearchCondition();
		
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

		Map<Object, Object> searchMap = new HashMap<Object, Object>();
		searchMap.put("active", String.valueOf(1));
		searchMap.put("officeCode", loginUser.getOfficeCode());
		searchMap.put("roleType", String.valueOf(0));
		helpers = userService.getListByProperty(searchMap, "sortNum, userCode");
		log.info(userActionEnd(log, "prepare", SUCCESS, "searchItem", searchItem, "customerId", customerId, "yearMonths", yearMonths, "helpers", helpers));
	}
	
	
	public String execute() throws Exception {
		log.info(userActionStart(log, "execute", "loginUser", loginUser));
		selectedMonth = getYearMonthWithKey(searchItem.getSearchServiceYm());
		prevMonthKey = getPrevYearMonthKeyWithKey(searchItem.getSearchServiceYm());
		nextMonthKey = getNextYearMonthKeyWithKey(searchItem.getSearchServiceYm());

		if (prevMonthKey.compareTo(yearMonths.get(yearMonths.size()-1).getKey()) < 0)  prevMonthKey = "";
		if (nextMonthKey.compareTo(yearMonths.get(0).getKey()) > 0)  nextMonthKey = "";
		
		customers = customerService.loadByOfficeCode(loginUser.getOfficeCode(), searchItem.getSearchCustomerName());
		
		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
		
		if (office != null && customerId > 0) {
//			Map<Object, Object> searchMap = new HashMap<Object, Object>();
//			searchMap.put("office.id", "" + office.getId());
//			searchMap.put("customer.id", "" + customerId);
//			searchMap.put("serviceYm", selectedMonth.getKey());
//			events = eventService.getListByProperty(searchMap, "plan.serviceDate, plan.timeStart");
			events = eventService.loadEventsWithItemInDays(office.getId(), 0, 0, customerId, new Integer[]{EventItem.TYPE_SCHEDULE}, selectedMonth.getKey() + "01", selectedMonth.getKey() + selectedMonth.getMaxDays(), new Integer[]{EventItem.STATUS_COMPLETED});
		}
		
		this.saveSearchCondition(searchItem);
		log.info(userActionEnd(log, "execute", SUCCESS, "selectedMonth", selectedMonth, "customers", customers));
		return SUCCESS;
	}
	
}
