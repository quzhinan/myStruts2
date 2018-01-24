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
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.services.ServiceService;

@ParentPackage("ies-json-default")
@Results({ @Result(name = ServiceAction.SUCCESS, type = "json", params = { "root", "action", "includeProperties",
		"result, message", "excludeProperties", "" }) })
public class ServiceAction extends AbstractAction implements ModelDriven<Service>, Preparable {

	private static final long serialVersionUID = 4222229876651715754L;

	private static final Log log = LogFactory.getLog(ServiceAction.class);

	@Autowired
	private ServiceService serviceService;

	private Service service;
	private String result;
	private String message;

	@Override
	public Service getModel() {
		return service;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	@JSON(name = "service")
	public Service getService() {
		return service;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (service == null) {
			service = new Service();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "Service", service));
	}

	public String changeActive() throws Exception {
		log.info(userActionStart(log, "changeActive"));

		Service dbService = serviceService.findByProperty("code", service.getCode());
		if (dbService != null) {
			dbService.setActive(service.getActive());

			serviceService.update(dbService);
			message = "ロック解除";
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "changeActive", SUCCESS, "result", result, "Service", dbService, "message",
				message));
		return SUCCESS;
	}
}
