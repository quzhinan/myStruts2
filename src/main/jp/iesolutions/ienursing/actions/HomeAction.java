package jp.iesolutions.ienursing.actions;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@ParentPackage("ies-webapp-default")
@Results(value = {
		@Result(name = HomeAction.SUCCESS, location = "home.jsp") })
public class HomeAction extends AbstractAction {

	private static final long serialVersionUID = -8302100940992582475L;

	private static final Log log = LogFactory.getLog(HomeAction.class);
	
	public String execute() throws Exception {
		log.info(userActionStart(log, "execute"));
		log.info(userActionEnd(log, "execute", SUCCESS));
		return SUCCESS;
	}
}
