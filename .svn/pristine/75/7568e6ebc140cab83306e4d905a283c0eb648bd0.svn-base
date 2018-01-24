package jp.iesolutions.ienursing.actions.js;

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

import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = EventPageAction.SUCCESS, location = "event-edit.jsp") })
public class EventPageAction extends AbstractAction implements Preparable {

	private static final long serialVersionUID = 67364104132895398L;

	private static final Log log = LogFactory.getLog(EventPageAction.class);

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private ServiceService serviceService;

	@Autowired
	private EventService eventService;

	private User loginUser;

	private long id;
	private int type;
	private Event event;
	private EventItem item;
	private boolean achievementExist;
	// Modify for Comment - start
	private long defaultCustomerId;
	// Modify for Comment - end

	private List<YearMonth> yearMonths;
	private List<Service> services;
	private List<Customer> customers;
	private List<User> helpers;

	public void setId(long id) {
		this.id = id;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Event getEvent() {
		return event;
	}

	public EventItem getItem() {
		return item;
	}

	public boolean getAchievementExist() {
		return achievementExist;
	}
	
	// Modify for Comment - start
	public long getDefaultCustomerId() {
		return defaultCustomerId;
	}

	public void setDefaultCustomerId(long defaultCustomerId) {
		this.defaultCustomerId = defaultCustomerId;
	}
	// Modify for Comment - end

	public List<YearMonth> getYearMonths() {
		return yearMonths;
	}

	public List<User> getHelpers() {
		return helpers;
	}

	public List<Customer> getCustomers() {
		return customers;
	}

	public List<Service> getServices() {
		return services;
	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare", "id", id));

		loginUser = getUserFromSession();

		// Office office = officeService.findByProperty("officeCode",
		// loginUser.getOfficeCode());
		Map<Object, Object> searchMap = new HashMap<Object, Object>();
		searchMap.put("active", "1");
		if (id > 0) {
			event = eventService.findById(id);
		} else {
			event = new Event();
			event.setPlan(new EventItem(EventItem.TYPE_PLAN));
			event.setSchedule(new EventItem(EventItem.TYPE_SCHEDULE));
			event.setAchievement(new EventItem(EventItem.TYPE_ACHIEVEMENT));
		}
		searchMap.put("officeCode", loginUser.getOfficeCode());

		yearMonths = getRecentlyMonths(false);
		services = serviceService.loadAllProperService(loginUser.getOfficeCode());
		Map<Object, Object> searchMapCustomer = new HashMap<>(searchMap);
		if (id > 0) {
			searchMapCustomer.remove("active");
		}
		customers = customerService.getListByProperty(searchMapCustomer, "customerNameKana, customerName");

		searchMap.put("roleType", String.valueOf(0));
		helpers = userService.getListByProperty(searchMap, "sortNum, userCode");
		
		switch (type) {
		case EventItem.TYPE_PLAN:
			item = event.getPlan();
			break;
		case EventItem.TYPE_SCHEDULE:
			item = event.getSchedule();
			break;
		case EventItem.TYPE_ACHIEVEMENT:
			item = event.getAchievement();
			break;
		}
		
		this.achievementExist = event.getAchievement().getStatus() != 0;

		if (id > 0 && item != null) {
			if(item.getHelper() != null && item.getHelper().getId() > 0){
				User usingUse = userService.getUserById(loginUser, item.getHelper().getId());
				if(usingUse != null && usingUse.getActive() == 0) {
					helpers.add(0, usingUse);
				}
			}
			
			if(item.getFollower() != null && item.getFollower().getId() > 0){
				User usingUseFollow = userService.getUserById(loginUser, item.getFollower().getId());
				if(usingUseFollow != null && usingUseFollow.getActive() == 0) {
					helpers.add(0, usingUseFollow);
				}
			}

			if(item.getService() != null && item.getService().getCode() != null){
				Service service = serviceService.findById(item.getService().getCode());
				if (service != null && service.getActive() == 0) {
					services.add(0, service);
				}
			}
		}
		
		log.info(userActionEnd(log, "prepare", SUCCESS, "yearMonths", yearMonths, "services", services, "customers",
				customers, "helpers", helpers, "item", item));
	}

	public String execute() throws Exception {

		return SUCCESS;
	}
}
