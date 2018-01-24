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
import jp.iesolutions.ienursing.util.SQLUtils;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = UserListAction.LIST, location = "user-list.jsp") })
public class UserListAction extends AbstractPageAction<User> implements ModelDriven<User>, Preparable {

	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;

	private static final long serialVersionUID = 1783663731095952633L;

	private static final Log log = LogFactory.getLog(UserListAction.class);

	@Autowired
	private UserService userService;
	
	@Autowired
	private OfficeService officeService;

	private User userSearch;
	
	private List<Office> offices;

	public List<Office> getOffices() {
		return offices;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		super.prepare();
		userSearch = (User) getSearchCondition();
		if (userSearch == null) {
			userSearch = new User();
			userSearch.setRoleType(-1);
		}
		
		if (getUserFromSession().getRoleType() == 2) {
			offices = officeService.loadAll();
		} else {
			offices = new ArrayList<Office>();
			offices.add(officeService.findByProperty("officeCode", getUserFromSession().getOfficeCode()));
		}
		
		
		log.info(userActionEnd(log, "prepare", SUCCESS, "userSearch", userSearch));
	}

	@Override
	public User getModel() {
		return userSearch;
	}

	public String execute() throws Exception {
		log.info(userActionStart(log, "execute", "pageSize", PAGESIZE, "startIndex", startIndex));
		refreshList();
		log.info(userActionEnd(log, "execute", LIST, "pagination", this.pagination));
		return LIST;
	}

	public String search() throws Exception {
		log.info(userActionStart(log, "search", "userSearch", userSearch, "pageSize", PAGESIZE, "startIndex",
				startIndex));
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", LIST, "pagination", this.pagination));
		return LIST;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null & user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";
		if (officeCode.equals("administrator") && userSearch.getOfficeCode() != null && userSearch.getOfficeCode().length() > 1) {
			officeCode = userSearch.getOfficeCode();
		}
		(new SQLUtils()).makePropertiesSafe(userSearch, null);
		this.pagination = userService.loadPage(user, PAGESIZE, startIndex, userSearch, officeCode);
		saveSearchCondition(userSearch);
		saveStartIndex(pagination.getOffset());
	}

	public int getAdminRoleType() {
		return User.SUPER_ADMIN_NAME;
	}

	private Long[] ids;

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public String bulkDelete() throws Exception {
		log.info(userActionStart(log, "bulkDelete", "ids", ids));
		boolean existSelf = false;
		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				long id = ids[i];
				if (id == getUserFromSession().getId()) {
					existSelf = true;
				}
			}
		}

		if (existSelf) {
			this.addActionError(getText("errors.delete.self"));
		} else {
			userService.bulkDelete(getUserFromSession(), ids);
		}

		refreshList();
		log.info(userActionEnd(log, "bulkDelete", LIST, "pagination", this.pagination));
		return LIST;
	}
}
