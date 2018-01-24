package jp.iesolutions.ienursing.actions;

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

import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.ServiceService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = ServiceAction.INPUT, location = "service-edit.jsp"),
		@Result(name = ServiceAction.LIST, location = "service-list.ies?${ietoken}", type = "redirect") })
public class ServiceAction extends AbstractPageAction<Service> implements ModelDriven<Service>, Preparable {

	private static final long serialVersionUID = 5371969431896953359L;

	private static final Log log = LogFactory.getLog(ServiceAction.class);

	@Autowired
	private ServiceService serviceService;

	private Service service;

	private String code;

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public Service getModel() {
		return service;
	}

	@Autowired
	private OfficeService officeService;

	private List<Office> officeList;

	public List<Office> getOfficeList() {
		return officeList;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));

		this.checkRoleAction("service");
		
		User user = getUserFromSession();
		if (user.getRoleType() == 2 && user.getOfficeCode().equals("0")) {
			this.officeList = this.officeService.loadAll();
		} else {
			this.officeList = new ArrayList<>();
			this.officeList.add(this.officeService.findByProperty("officeCode", user.getOfficeCode()));
		}

		if (service == null && code != null && code.length() > 0) {
			service = serviceService.findByProperty("code", new String(code.getBytes("ISO-8859-1"), "utf-8"));
		} else {
			service = new Service();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "service", service));
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

	public String update() throws Exception {
		log.info(userActionStart(log, "update"));
		service.setCode(service.getTypeCode() + service.getItemCode());
		try {
			serviceService.update(service);
		} catch (Exception e) {
			printLog(log, e);
			service.setCode(null);
			addActionError(getText("errors.service.exist"));
			return INPUT;
		}
		log.info(userActionEnd(log, "update", LIST, "service", service));
		return LIST;
	}

	public String save() {
		log.info(userActionStart(log, "save", "service", service));
		service.setCode(service.getTypeCode() + service.getItemCode());
		service.setActive(1);
		try {
			serviceService.save(service);
		} catch (Exception e) {
			printLog(log, e);
			service.setCode(null);
			addActionError(getText("errors.service.exist"));
			return INPUT;
		}
		log.info(userActionEnd(log, "save", LIST));
		return LIST;
	}

	public String delete() throws Exception {
		log.info(userActionStart(log, "delete", "service", service));
		serviceService.deleteById(new String(code.getBytes("ISO-8859-1"), "utf-8"));
		log.info(userActionEnd(log, "delete", LIST));
		return LIST;
	}

	public String cancel() throws Exception {
		log.info(userActionStart(log, "cancel"));
		log.info(userActionEnd(log, "cancel", LIST));
		return LIST;
	}
}
