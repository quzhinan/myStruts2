package jp.iesolutions.ienursing.actions;

import java.util.ArrayList;
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
import org.springframework.dao.DataAccessException;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.Week;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.WeekService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = WeekAction.INPUT, location = "week-edit.jsp"),
		@Result(name = WeekAction.LIST, location = "week-list.ies?tab=${tab}&${ietoken}", type = "redirect"),
		@Result(name = "list2", location = "week-list2.jsp") })
public class WeekAction extends AbstractPageAction<Week> implements ModelDriven<Week>, Preparable {

	private static final long serialVersionUID = -5422759728844269284L;

	private static final Log log = LogFactory.getLog(WeekAction.class);

	@Autowired
	private WeekService weekService;

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private ServiceService serviceService;

	private Week week;

	public Week getWeek() {
		return this.week;
	}

	public void setWeek(Week week) {
		this.week = week;
	}
	
	public int getTab() {
		return Integer.parseInt(session.get("week_tab").toString());
	}

	public void setTab(int tab) {
		session.put("week_tab", tab);
	}
	private Long id;

	private List<YearMonth> yearMonths;
	private List<Service> services;
	private List<Customer> customers;
	private List<User> helpers;

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
	public Week getModel() {
		return week;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Autowired
	private OfficeService officeService;

	private List<Office> officeList;

	public List<Office> getOfficeList() {
		return officeList;
	}

	public void setOfficeList(List<Office> officeList) {
		this.officeList = officeList;
	}

	@Override
	public void prepare() throws Exception {
		User user = getUserFromSession();
		if (user.getRoleType() == 2 && user.getOfficeCode().equals("0")) {
			this.officeList = this.officeService.loadAll();
		} else {
			this.officeList = new ArrayList<>();
			this.officeList.add(this.officeService.findByProperty("officeCode", user.getOfficeCode()));
		}
		Map<Object, Object> searchMap = new HashMap<Object, Object>();
		searchMap.put("officeCode", user.getOfficeCode());
		searchMap.put("active", "1");
		// yearMonths = getRecentlyMonths(false);
		services = serviceService.loadAllProperService(user.getOfficeCode());
		customers = customerService.getListByProperty(searchMap, "customerNameKana, customerName");

		searchMap.put("roleType", String.valueOf(0));
		helpers = userService.getListByProperty(searchMap, "sortNum, userCode");

		log.info(userActionStart(log, "prepare", "id", id));

		if (week == null && id != null && id.longValue() != 0) {
			week = weekService.findById(id);
		} else {
			week = new Week();
		}

		if (week.getService() != null && week.getService().getCode() != null) {
			Service service = serviceService.findById(week.getService().getCode());
			if (service != null && service.getActive() == 0) {
				services.add(0, service);
			}
		}
		
		log.info(userActionEnd(log, "prepare", SUCCESS, "Week", week));
	}

	public String add() throws Exception {
		log.info(userActionStart(log, "add"));
		log.info(userActionEnd(log, "add", INPUT));
		return INPUT;
	}

	public String edit() throws Exception {
		log.info(userActionStart(log, "edit"));
		log.info(userActionEnd(log, "edit", INPUT));
		return INPUT;
	}

	private String result = INPUT;

	public String save() throws Exception {
		log.info(userActionStart(log, "save", "wek", week));
		try {
			boolean saveResult = weekService.saveWeek(week, false);
			if (saveResult) {
				result = LIST;
			} else {
				result = INPUT;
				addActionError(getText("messages.js.plan.time.same.other"));
			}
		} catch (ServiceException e) {
			printLog(log, e);
		} catch (DataAccessException e) {
			printLog(log, e);
			result = INPUT;
		}

		log.info(userActionEnd(log, "save", LIST, "Week", "Week"));
		return result;
	}

	public String update() throws Exception {
		log.info(userActionStart(log, "update", "Week", week));
		try {
			boolean saveResult = weekService.saveWeek(week, true);
			if (saveResult) {
				result = LIST;
			} else {
				result = INPUT;
				addActionError("担当が他のサービス時間と重複しています。");
			}
		} catch (Exception e) {
			printLog(log, e);
		}

		log.info(userActionEnd(log, "update", LIST, "Week", week));
		return result;
	}

	public String delete() throws Exception {
		log.info(userActionStart(log, "delete", "WeekId", week.getId()));
		weekService.deleteById(week.getId());

		log.info(userActionEnd(log, "delete", LIST));
		return LIST;
	}

	public String cancel() throws Exception {
		log.info(userActionStart(log, "cancel"));
		log.info(userActionEnd(log, "cancel", LIST));
		return LIST;
	}

	public Boolean showManageItems() {
		return true;
	}

	public long customerId;

	public long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public String goToList2() {
		return "list2";
	}
}
