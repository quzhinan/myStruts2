package jp.iesolutions.ienursing.actions.js;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
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

/*
 * Add for Comment - start
 */
@ParentPackage("ies-json-default")
@Results({ @Result(name = CommentAction.SUCCESS, type = "json", params = { "root", "action", "includeProperties",
		"result, comment", "excludeProperties", "" }) })
public class CommentAction extends AbstractAction implements ModelDriven<Customer>, Preparable {

	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(CommentAction.class);

	@Autowired
	private CustomerService customerService;

	private Customer customer;
	private String result;

	@Override
	public Customer getModel() {
		return customer;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}
	
	@JSON(name = "comment")
	public String getComment() {
		return customer == null ? "" : customer.getCommentContent();
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (customer == null) {
			customer = new Customer();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "user", customer));
	}

	public String saveComment() throws Exception {
		log.info(userActionStart(log, "saveComment"));

		Customer dbcustomer = customerService.findById(customer.getId());
		if (dbcustomer != null) {
			dbcustomer.setCommentContent(customer.getCommentContent());
			dbcustomer.setCommentUpdateDatetime(new Date());
			if (dbcustomer.getCommentCreateDatetime() == null && !StringUtils.isEmpty(customer.getCommentContent())) {
				dbcustomer.setCommentCreateDatetime(new Date());
			}
			customerService.update(dbcustomer);
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "saveComment", SUCCESS, "result", result, "customer", customer));
		return SUCCESS;
	}
	
	public String getCustomerComment() throws Exception {
		log.info(userActionStart(log, "getCustomerComment"));
		
		customer = customerService.findById(customer.getId());
		if (customer != null) {
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "getCustomerComment", SUCCESS, "result", result, "customer", customer));
		return SUCCESS;
	}

}
