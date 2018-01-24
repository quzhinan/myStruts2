package jp.iesolutions.ienursing.actions;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = {
		@Result(name=OfficeAction.INPUT, location="office-edit.jsp"),
		@Result(name=OfficeAction.LIST, location="office-list.ies?${ietoken}", type="redirect")
})

public class OfficeAction extends AbstractPageAction<Office> implements
		ModelDriven<Office>, Preparable {

	private static final long serialVersionUID = -141393821277805804L;
	
	private static final Log log = LogFactory.getLog(OfficeAction.class);

	@Autowired
	private OfficeService officeService;
	
	private Office office;
	
	private Long id;

	@Override
	public Office getModel() {
		return office;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare","id",id));
		
		this.checkRoleAction("office");
		
		if (office == null && id != null && id.longValue() != 0) {
			office = officeService.findById(id);
		} else {
			office = new Office();
		}
		log.info(userActionEnd(log,"prepare",SUCCESS,"office",office));
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
	
	public String update() throws Exception{
		
		log.info(userActionStart(log, "update","office",office));
		
		try {
			officeService.update(office);
		} catch (ServiceException e) {
			printLog(log, e);
		}
		log.info(userActionEnd(log, "update",LIST,"office",office));
		return LIST;
	}
	
	public String save() throws Exception {
		
		log.info(userActionStart(log, "save","office",office));
		
		try {
			office.setAddress2("");
			officeService.save(office);
		} catch (ServiceException e) {
			printLog(log, e);
			this.addActionError(getText(e.getMessage()));
			return INPUT;
		} catch (DataAccessException e) {
			printLog(log, e);
			this.addActionError("入力した事業所番号は既に存在します。");
			return INPUT;
		}
		log.info(userActionEnd(log, "save",LIST,"office",office));
		return LIST;
	}

	public String delete() throws Exception {
		log.info(userActionStart(log, "delete","office","office"));
		try {
			officeService.deleteById(office.getId());
		} catch (Exception e) {
			printLog(log, e);
			throw new DataIntegrityViolationException("user is using");
		}
		log.info(userActionEnd(log, "delete", LIST,"office",office));
		return LIST;
	}
	
	public String cancel() throws Exception {
		log.info(userActionStart(log, "cancel"));
		log.info(userActionEnd(log, "cancel", LIST));
		return LIST;
	}
	
	public Boolean showManageItems() {

		log.info(userActionStart(log, "showManageItems"));
		log.info(userActionEnd(log, "showManageItems", SUCCESS));
		return true;
	}
}
