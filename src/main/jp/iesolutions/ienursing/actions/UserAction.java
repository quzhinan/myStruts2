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
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.MultipleException;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = UserAction.INPUT, location = "user-edit.jsp"),
		@Result(name = UserAction.LIST, location = "user-list.ies?${ietoken}", type = "redirect"),
		@Result(name = "list_last_page", location = "user-list.ies?clear=true&golast=true&${ietoken}", type = "redirect") })
public class UserAction extends AbstractPageAction<User> implements ModelDriven<User>, Preparable {

	private static final long serialVersionUID = -9188347329650601022L;

	private static final Log log = LogFactory.getLog(UserAction.class);

	@Autowired
	private UserService userService;

	private User user;

	private Long id;

	private String modifyPassword;


	@Override
	public User getModel() {
		return user;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getModifyPassword() {
		return modifyPassword;
	}

	public void setModifyPassword(String modifyPassword) {
		this.modifyPassword = modifyPassword;
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
		log.info(userActionStart(log, "prepare"));
		user = getUserFromSession();
		if (user.getRoleType() == 2 && user.getOfficeCode().equals("0")) {
			this.officeList = this.officeService.loadAll();
		} else {
			this.officeList = new ArrayList<>();
			this.officeList.add(this.officeService.findByProperty("officeCode", user.getOfficeCode()));
		}
		
		if (id == null || id.longValue() == 0 || user == null) {
			user = new User();
			user.setPassword("");
			if (getUserFromSession().getRoleType() == 1) {
				user.setOfficeCode(getUserFromSession().getOfficeCode());
			}
		} else {
			user = userService.getUserById(user, id);
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "user", user));
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
		log.info(userActionStart(log, "save", "userCode", user.getUserCode(), "userName", user.getUserName(), "password", user.getPassword(), "address", user.getAddress(), "phoneNumber", user.getPhoneNumber(), "appleID", user.getAppleID(), "email", user.getEmail(), "officeCode", user.getOfficeCode()));
		try {
			user.setActive(1);
			userService.saveUser(getUserFromSession(), user, (modifyPassword != null));
		} catch (MultipleException e) {
			printLog(log, e);
			this.addActionError(e.getMessage(this));
			return INPUT;
		} catch (ServiceException e) {
			printLog(log, e);
			this.addActionError(getText(e.getMessage()));
			return INPUT;
		}
		if (user.getId() == 0) {
			log.info(userActionEnd(log, "save", "list_last_page", "id", user.getId()));
			return "list_last_page";
		} else {
			log.info(userActionEnd(log, "save", LIST, "id", user.getId()));
			return LIST;
		}
	}

	public String update() throws Exception {
		log.info(userActionStart(log, "update"));
		userService.saveUser(getUserFromSession(), user, (modifyPassword != null));
		log.info(userActionEnd(log, "update", LIST, "user", user));
		return LIST;
	}

	public String delete() throws Exception {
		log.info(userActionStart(log, "delete", "userCode", user.getUserCode(), "userName", user.getUserName(), "password", user.getPassword(), "address", user.getAddress(), "phoneNumber", user.getPhoneNumber(), "appleID", user.getAppleID(), "email", user.getEmail(), "officeCode", user.getOfficeCode()));
		if (id == getUserFromSession().getId()) {
			this.addActionError(getText("errors.delete.self"));
		} else {
			userService.deleteById(getUserFromSession(), id);
		}
		
		log.info(userActionEnd(log, "delete", LIST));
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
