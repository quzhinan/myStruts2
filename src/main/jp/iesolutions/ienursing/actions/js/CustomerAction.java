package jp.iesolutions.ienursing.actions.js;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.WeekService;

@ParentPackage("ies-json-default")
@Results({ @Result(name = CustomerAction.SUCCESS, type = "json", params = { "root", "action", "includeProperties",
		"result, message", "excludeProperties", "" }) })
public class CustomerAction extends AbstractAction implements ModelDriven<Customer>, Preparable {

	private static final long serialVersionUID = 4825569876651715754L;

	private static final Log log = LogFactory.getLog(CustomerAction.class);

	@Autowired
	private CustomerService customerService;

	private Customer customer;
	private String result;
	private String message;

	@Override
	public Customer getModel() {
		return customer;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	@JSON(name = "customer")
	public Customer getUser() {
		return customer;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (customer == null) {
			customer = new Customer();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "user", customer));
	}

	public String changeActive() throws Exception {
		log.info(userActionStart(log, "changeActive"));

		Customer dbcustomer = customerService.findById(customer.getId());
		if (dbcustomer != null) {
			dbcustomer.setActive(customer.getActive());
			if (customer.getActive() == 0) {
				weekService.deleteBlockCustomer(dbcustomer);
			}
			customerService.update(dbcustomer);
			message = "ロック解除";
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "changeActive", SUCCESS, "result", result, "customer", customer, "message",
				message));
		return SUCCESS;
	}

	@Autowired
	private WeekService weekService;
}
