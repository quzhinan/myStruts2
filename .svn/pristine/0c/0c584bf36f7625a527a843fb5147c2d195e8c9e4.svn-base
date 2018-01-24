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

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.Week;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.WeekService;
import jp.iesolutions.ienursing.util.PaginationSupport;
import jp.iesolutions.ienursing.util.SQLUtils;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = WeekListAction.LIST, location = "week-list.jsp") })
public class WeekListAction extends AbstractPageAction<Week> implements ModelDriven<Week>, Preparable {

	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;

	private static final long serialVersionUID = 3023001387649546580L;

	private static final Log log = LogFactory.getLog(WeekListAction.class);

	@Autowired
	private WeekService weekService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private UserService userService;

	private Week searchWeek;

	public void validate() {

	}

	private List<Customer> customers;
	private List<User> helpers;

	public List<User> getHelpers() {
		return helpers;
	}

	public List<Customer> getCustomers() {
		return customers;
	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare"));

		super.prepare();
		searchWeek = (Week) getSearchCondition();
		if (searchWeek == null) {
			searchWeek = new Week();
		}
		Map<Object, Object> searchMap = new HashMap<Object, Object>();
		searchMap.put("officeCode", getUserFromSession().getOfficeCode());
		searchMap.put("active", "1");
		customers = customerService.getListByProperty(searchMap, "customerNameKana, customerName");
		searchMap.put("roleType", String.valueOf(0));
		helpers = userService.getListByProperty(searchMap, "sortNum, userName");

		log.info(userActionEnd(log, "prepare", SUCCESS, "startIndex", startIndex));
	}

	@Override
	public Week getModel() {
		return searchWeek;
	}

	public String execute() throws Exception {
		log.info(userActionStart(log, "execute", "pageSize", PAGESIZE, "startIndex", startIndex));

		refreshList();
		log.info(userActionEnd(log, "execute", LIST, "pagination", this.pagination));
		return LIST;
	}

//	
//	public String searchCustomer() throws Exception {
//		log.info(userActionStart(log, "searchCustomer"));
//		clearStartIndex();
//		refreshList();
//		log.info(userActionEnd(log, "searchCustomer", LIST));
//		return LIST;
//	}
	private int tab;
	
	public int getTab() {
		return tab;
	}

	public void setTab(int tab) {
		this.tab = tab;
	}

	public String search() throws Exception {
		log.info(userActionStart(log, "search", "pageSize", PAGESIZE, "startIndex", startIndex, "searchWeek",
				searchWeek));
		if (searchWeek.getCustomerCode() != null && searchWeek.getCustomerCode().length() > 0) {
			Customer customer = customerService.findByProperty("customerCode", searchWeek.getCustomerCode());
			if (customer != null) {
				searchWeek.setCustomerId(customer.getId());
			}
			
		}
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", LIST, "pagination", this.pagination));
		return LIST;
	}

	private Long[] ids;

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	private Long[] active;

	public void setActive(Long[] active) {
		this.active = active;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null & user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";

		(new SQLUtils()).makePropertiesSafe(searchWeek, null);
		try {
			if (this.tab == 1 && (searchWeek.getCustomerCode() == null || searchWeek.getCustomerCode().length() <= 0)) {
				this.pagination = new PaginationSupport<Week>();
			} else {
				if (tab == 1) {
					String code = searchWeek.getCustomerCode();
					
					searchWeek = new Week();
					if (code != null && code.length() > 0) {
						Customer customer = customerService.findByProperty("customerCode", code);
						if (customer != null) {
							searchWeek.setCustomerId(customer.getId());
						}
						
					}
					
					searchWeek.setCustomerCode(code);
					
				}
				this.pagination = weekService.loadPage(PAGESIZE, startIndex, searchWeek, officeCode);
			}
		} catch (Exception e) {
			printLog(log, e);
		}

		saveSearchCondition(searchWeek);
		saveStartIndex(pagination.getOffset());
	}

	public String bulkDelete() throws Exception {
		log.info(userActionStart(log, "bulkDelete", "ids", ids, "startIndex", startIndex, "pageSize", PAGESIZE));

		weekService.bulkDelete(getUserFromSession(), ids);
		refreshList();

		log.info(userActionEnd(log, "bulkDelete", LIST, "pagination", this.pagination));
		return LIST;
	}

	public String seperateTime(String origionTime) {
		String resultTime = origionTime;
		try {
			String timeHour = origionTime.substring(0, 2);
			String timeMinutes = origionTime.substring(2, 4);
			resultTime = timeHour + ":" + timeMinutes;
		} catch (Exception e) {
			printLog(log, e);
		}

		return resultTime;
	}
}
