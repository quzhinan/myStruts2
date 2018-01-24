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
import jp.iesolutions.ienursing.util.SQLUtils;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = CustomerListAction.LIST, location = "service-list.jsp") })
public class ServiceListAction extends AbstractPageAction<Service> implements ModelDriven<Service>, Preparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 975918433701155422L;

	private static final Log log = LogFactory.getLog(ServiceListAction.class);

	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;

	@Autowired
	private ServiceService serviceService;

	private Service searchService;

	public void validate() {

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
		super.prepare();

		this.checkRoleAction("service");
		
		User user = getUserFromSession();
		if (user.getRoleType() == 2 && user.getOfficeCode().equals("0")) {
			this.officeList = this.officeService.loadAll();
		} else {
			this.officeList = new ArrayList<>();
			this.officeList.add(this.officeService.findByProperty("officeCode", user.getOfficeCode()));
		}

		searchService = (Service) getSearchCondition();
		if (searchService == null) {
			searchService = new Service();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "searchService", searchService));
	}

	@Override
	public Service getModel() {
		return searchService;
	}

	public String execute() throws Exception {
		User user = getUserFromSession();
		log.info(userActionStart(log, "execute", "pageSize", PAGESIZE, "startIndex", startIndex));
		try {
			(new SQLUtils()).makePropertiesSafe(searchService, null);
			this.pagination = serviceService.loadPage(user, PAGESIZE, startIndex, searchService);
		} catch (Exception e) {
			printLog(log, e);
		}
		saveStartIndex(pagination.getOffset());
		log.info(userActionEnd(log, "execute", LIST, "pagination", this.pagination));
		return LIST;
	}

	public String search() throws Exception {
		log.info(userActionStart(log, "search", "pageSize", PAGESIZE, "searchService", searchService));
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", LIST, "pagination", this.pagination));
		return LIST;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		(new SQLUtils()).makePropertiesSafe(searchService, null);
		this.pagination = serviceService.loadPage(user, PAGESIZE, 0, searchService);
		saveSearchCondition(searchService);
		saveStartIndex(pagination.getOffset());
	}

	private String[] codes;

	public void setCodes(String[] codes) {
		this.codes = codes;
	}

	public String bulkDelete() throws Exception {
		log.info(userActionStart(log, "bulkDelete", "codes", codes));
		serviceService.bulkDelete(getUserFromSession(), codes);
		refreshList();
		log.info(userActionEnd(log, "bulkDelete", LIST, "pagination", this.pagination));
		return LIST;
	}

	public String getDisplayByOfficeCode(String officeCode) throws Exception {
		String returnString = "すべて";
		Office office = officeService.findByProperty("officeCode", officeCode);
		if (office != null) {
			returnString = office.getOfficeName();
		}
		return returnString;
	}
}
