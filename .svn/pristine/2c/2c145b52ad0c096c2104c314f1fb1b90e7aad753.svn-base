package jp.iesolutions.ienursing.actions;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;
import jp.iesolutions.ienursing.util.SQLUtils;

import java.util.ArrayList;
import java.util.List;

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
@Results(value = { @Result(name = CustomerListAction.LIST, location = "customer-list.jsp") })
public class CustomerListAction extends AbstractPageAction<Customer> implements ModelDriven<Customer>, Preparable {

	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;

	private static final long serialVersionUID = 3023001393962546580L;

	private static final Log log = LogFactory.getLog(CustomerListAction.class);

	@Autowired
	private CustomerService customerService;

	private Customer searchCustomer;

	public void validate() {

	}

	@Autowired
	private OfficeService officeService;

	private List<Office> offices;

	public List<Office> getOffices() {
		return offices;
	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare"));

		super.prepare();
		searchCustomer = (Customer) getSearchCondition();
		if (searchCustomer == null) {
			searchCustomer = new Customer();
		}

		if (getUserFromSession().getRoleType() == 2) {
			offices = officeService.loadAll();
		} else {
			offices = new ArrayList<Office>();
			offices.add(officeService.findByProperty("officeCode", getUserFromSession().getOfficeCode()));
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "startIndex", startIndex));
	}

	@Override
	public Customer getModel() {
		return searchCustomer;
	}

	public String execute() throws Exception {

		log.info(userActionStart(log, "execute", "pageSize", PAGESIZE, "startIndex", startIndex));

		refreshList();
		log.info(userActionEnd(log, "execute", LIST, "pagination", this.pagination));
		return LIST;
	}

	public String search() throws Exception {
		log.info(userActionStart(log, "search", "pageSize", PAGESIZE, "startIndex", startIndex, "searchCustomer",
				searchCustomer));
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", LIST, "pagination", this.pagination));
		return LIST;
	}

	private Long[] ids;

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null & user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";
		if (officeCode.equals("administrator") && searchCustomer.getOfficeCode() != null
				&& searchCustomer.getOfficeCode().length() > 1) {
			officeCode = searchCustomer.getOfficeCode();
		}
		(new SQLUtils()).makePropertiesSafe(searchCustomer, null);

		this.pagination = customerService.loadPage(PAGESIZE, startIndex, searchCustomer, officeCode);
		saveSearchCondition(searchCustomer);
		saveStartIndex(pagination.getOffset());
	}

	public String bulkDelete() throws Exception {
		log.info(userActionStart(log, "bulkDelete", "ids", ids, "startIndex", startIndex, "pageSize", PAGESIZE));

		try {
			customerService.bulkDelete(getUserFromSession(), ids);
			// addActionMessage(getText("messages.customer.delete.success"));
		} catch (ServiceException e) {
			printLog(log, e);
			// addActionError(getText(e.getMessage()));
		}
		refreshList();

		log.info(userActionEnd(log, "bulkDelete", LIST, "pagination", this.pagination));
		return LIST;
	}
}
