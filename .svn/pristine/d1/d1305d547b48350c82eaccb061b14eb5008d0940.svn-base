package jp.iesolutions.ienursing.actions;

import java.io.File;
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
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = {
		@Result(name = CustomerAction.INPUT, location = "customer-edit.jsp"),
		@Result(name = CustomerAction.LIST, location = "customer-list.ies?${ietoken}", type = "redirect") })
public class CustomerAction extends AbstractPageAction<Customer> implements
		ModelDriven<Customer>, Preparable {

	private static final long serialVersionUID = -5422730762844269284L;

	private static final Log log = LogFactory.getLog(CustomerAction.class);

	@Autowired
	private CustomerService customerService;

	@Autowired
	private UserService userService;

	private Customer customer;

	private Long id;

	private File pdfNurse;

	private File medicalContact;

	private File amentityPdf;

	public File getAmentityPdf() {
		return amentityPdf;
	}

	public void setAmentityPdf(File amentityPdf) {
		this.amentityPdf = amentityPdf;
	}

	public File getPdfNurse() {
		return pdfNurse;
	}

	public void setPdfNurse(File pdfNurse) {
		this.pdfNurse = pdfNurse;
	}

	public File getMedicalContact() {
		return medicalContact;
	}

	public void setMedicalContact(File medicalContact) {
		this.medicalContact = medicalContact;
	}

	@Override
	public Customer getModel() {
		return customer;
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
		
		log.info(userActionStart(log,"prepare","id",id));
		
		if (customer == null && id != null && id.longValue() != 0) {
			customer = customerService.findById(id);
		} else {
			customer = new Customer();
			if (getUserFromSession().getRoleType() == 1) {
				customer.setOfficeCode(getUserFromSession().getOfficeCode());
			}
		}
		log.info(userActionEnd(log,"prepare",SUCCESS,"customer",customer));
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

	public String save() throws Exception {
		
		log.info(userActionStart(log,"save","pdfNurse",pdfNurse,"medicalContact",medicalContact,"amentityPdf",amentityPdf,"customer",customer));
		
		try {
			customerService.uploadPdfFiles(pdfNurse, medicalContact,
					amentityPdf, customer);
			customer.setAddress2("");
			customer.setActive(1);
			// Modify for Comment - start
			customer.setCommentContent("");
			// Modify for Comment - end
			customerService.save(customer);
		} catch (ServiceException e) {
			printLog(log, e);
		} catch (DataAccessException e) {
			printLog(log, e);
			addActionError(getText("labels.customer.usercode.exist"));
			return INPUT;
		}
		
		log.info(userActionEnd(log,"save",LIST,"customer","customer"));
		return LIST;
	}

	public String update() throws Exception {
		
		
		log.info(userActionStart(log,"update","pdfNurse",pdfNurse,"medicalContact",medicalContact,"amentityPdf",amentityPdf,"customer",customer));
		
		try {
			customerService.uploadPdfFiles(pdfNurse, medicalContact,
					amentityPdf, customer);
			// Modify for Comment - start
			customer.setCommentContent("");
			// Modify for Comment - end
			customerService.update(customer);
		} catch (Exception e) {
			printLog(log, e);
		}
		log.info(userActionEnd(log,"update",LIST,"customer",customer));
		return LIST;
	}

	public String delete() throws Exception {
		
		log.info(userActionStart(log,"delete","customerId",customer.getId()));
		
		customerService.deleteById(customer.getId());
		
		log.info(userActionEnd(log,"delete",LIST));
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

	public List<User> getUserList() {
		List<User> userList = null;
		Map<Object, Object> maps = new HashMap<Object, Object>();
		maps.put("roleType", "1");
		if (getUserFromSession().getRoleType() >= 1) {
			maps.put("officeCode", getUserFromSession().getOfficeCode());
		}
		try {
			userList = userService.getListByProperty(maps);
		} catch (ServiceException e) {
			printLog(log, e);
		}
		return userList;
	}
}
