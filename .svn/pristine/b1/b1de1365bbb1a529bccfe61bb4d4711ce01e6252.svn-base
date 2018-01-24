package jp.iesolutions.ienursing.actions;

import jp.iesolutions.ienursing.models.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

@ParentPackage("ies-webapp-default")
@Results(value = {
		@Result(name = LogoutAction.SUCCESS, location="index.jsp", type="redirect")
})
public class LogoutAction extends AbstractAction {
	
	private static final long serialVersionUID = -4009841594868540286L;
	
	private static final Log log = LogFactory.getLog(LogoutAction.class);
	
	private static final Log log_access = LogFactory.getLog("accessLog");

	public String execute() throws Exception {
				
		clearActionErrors();
				
		User user = this.getUserFromSession();
		
		log.info(userActionStart(log, "execute", "user", user));
		
		clearNursingFromSession();
		clearSelectDateFromSession();
		clearMenuIdFromSession();
		clearListTypeFromSession();
		
		session.clear();

		clearUserFromSession();
		
		String usercode = "";
		
		if( user != null ) {
			
			usercode = user.getUserCode();
		
			log_access.info(getText("logs.web.logout.successed", new String[]{usercode}));
		}
		
		log.info(userActionEnd(log, "execute", SUCCESS));
		
		return SUCCESS;
	}
}
