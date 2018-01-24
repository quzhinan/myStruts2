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
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.WeekService;

@ParentPackage("ies-json-default")
@Results({ @Result(name = UserAction.SUCCESS, type = "json", params = { "root", "action", "includeProperties",
		"result, message", "excludeProperties", "" }) })
public class UserAction extends AbstractAction implements ModelDriven<User>, Preparable {

	private static final long serialVersionUID = 4825569876651715754L;

	private static final Log log = LogFactory.getLog(UserAction.class);

	@Autowired
	private UserService userService;

	private User user;
	private String result;
	private String message;

	@Override
	public User getModel() {
		return user;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	@JSON(name = "user")
	public User getUser() {
		return user;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (user == null) {
			user = new User();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "user", user));
	}

	public String changeLock() throws Exception {
		log.info(userActionStart(log, "changeLock"));

		User dbUser = userService.findById(user.getId());
		if (dbUser != null) {
			dbUser.setIsLocked(user.getIsLocked());
			dbUser.setLoginTryTimes(0);
			userService.update(dbUser);
			message = "ロック解除";
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "save", SUCCESS, "result", result, "user", user, "message", message));
		return SUCCESS;
	}

	public String changeActive() throws Exception {
		log.info(userActionStart(log, "changeActive"));

		User dbUser = userService.findById(user.getId());
		if (dbUser != null) {
			dbUser.setActive(user.getActive());
			if (user.getActive() == 0) {
				weekService.deleteBlockUser(dbUser);
			}
			
			userService.update(dbUser);
			message = "ロック解除";
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "changeActive", SUCCESS, "result", result, "user", dbUser, "message", message));
		return SUCCESS;
	}
	
	@Autowired
	private WeekService weekService;
}
