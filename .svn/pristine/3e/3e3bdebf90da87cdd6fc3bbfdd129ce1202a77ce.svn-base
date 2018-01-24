package jp.iesolutions.ienursing.actions;

import jp.iesolutions.ienursing.data.helper.MasterHelper;
import jp.iesolutions.ienursing.models.Master;
import jp.iesolutions.ienursing.services.MasterService;

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
@Results(value = {
		@Result(name=MasterAction.INPUT, location="master.jsp")
})

public class MasterAction extends AbstractPageAction<Master> implements
ModelDriven<Master>, Preparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6833794231351824708L;
	private static final Log log = LogFactory.getLog(MasterAction.class);
	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;
	private Master master;
	
	@Autowired
	private MasterService masterService;

	@Override
	public Master getModel() {
		// TODO Auto-generated method stub
		return master;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));

		this.checkRoleAction("master");
		
		if (master == null) {
			try {
				master = masterService.findByProperty("id", 1);
			} catch (Exception e) {
				printLog(log, e);
			}
		}
		
		log.info(userActionEnd(log, "prepare", SUCCESS, "master", master));
	}

	public String update() throws Exception{
		log.info(userActionStart(log, "update"));
		
		try {
			masterService.update(master);
			MasterHelper.get().refresh();
		} catch (Exception e) {
			printLog(log, e);
		}
		
		log.info(userActionEnd(log, "update", INPUT, "master", master));
		return INPUT;
	}
	
	public String save() throws Exception {
		log.info(userActionStart(log, "save"));
		log.info(userActionEnd(log, "save", INPUT, "master", master));
		return INPUT;
	}
	
	public Boolean showManageItems() {
		log.info(userActionStart(log, "showManageItems"));
		log.info(userActionEnd(log, "showManageItems", SUCCESS));
		return true;
	}
}
