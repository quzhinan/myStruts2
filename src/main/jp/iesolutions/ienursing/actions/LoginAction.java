package jp.iesolutions.ienursing.actions;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.AuthenticationException;
import jp.iesolutions.ienursing.services.exceptions.PermissionsException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = {
		@Result(name = LoginAction.INPUT, location = "welcome.jsp"),
		@Result(name = LoginAction.SUCCESS, location = "home.ies?menuid=" + LoginAction.MENU_ID_SYS_HOME, type = "redirect") })
public class LoginAction extends AbstractAction {

	private static final long serialVersionUID = 3686706616069420772L;

	private static final Log log = LogFactory.getLog(LoginAction.class);
	
	private static final Log log_access = LogFactory.getLog("accessLog");

	private UserService userService;

	private String usercode;

	private String password;

	private String key;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void validate() {
		log.info(userActionStart(log, "validate"));
		if (key == null || StringUtils.isEmpty(key)) {
			if (StringUtils.isEmpty(this.usercode) == true) {
				addFieldError("usercode",
						getText("errors.login.usercode.required"));
				log.error(userActionEnd(log, "validate", ERROR));
			}
			if (StringUtils.isEmpty(this.password) == true) {
				addFieldError("password",
						getText("errors.login.password.required"));
				log.error(userActionEnd(log, "validate", ERROR));
			}
		}
	}

	public String execute() throws Exception {
		
		log.info(userActionStart(log, "execute"
				, "usercode", usercode
				, "password", "******"));
		
		
		clearActionErrors();
		clearUserFromSession();
		User user = null;
		try {
			user = userService.authenticate(usercode, password);
			if (!user.isAllowLogin()) {
				throw new AuthenticationException("errors.login.failed");
			} else if (user.getIsLocked() == 1) {
				throw new AuthenticationException("errors.login.locked");
			} else if (user.getRoleType() == 0) {
				throw new PermissionsException("errors.permissions.roletype.error");
			}
			setUserToSession(user);
			log_access.info(getText("logs.web.login.successed",
					new String[] { usercode }));
			if (user != null) {

				log.info(userActionEnd(log, "execute", SUCCESS
				));
				return SUCCESS;
			}
		} catch (AuthenticationException ae) {
			log_access.info(getText("logs.web.login.failed",
					new String[] { usercode }));
			addActionError(getText(ae.getMessage()));

		} catch (Exception e) {
			printLog(log, e);
		}
		
		log.info(userActionEnd(log, "execute", INPUT));
		return INPUT;
	}
}
