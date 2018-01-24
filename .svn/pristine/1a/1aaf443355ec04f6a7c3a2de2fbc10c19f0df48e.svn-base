package jp.iesolutions.ienursing.actions;

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
import jp.iesolutions.ienursing.util.SQLUtils;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = CustomerListAction.LIST, location = "office-list.jsp") })
public class OfficeListAction extends AbstractPageAction<Office> implements
		ModelDriven<Office>, Preparable {

	public final Boolean SHOW_DATA_MANAGER_ITEMS = true;

	private static final long serialVersionUID = -7074783720070102932L;
	private static final Log log = LogFactory.getLog(OfficeListAction.class);

	@Autowired
	private OfficeService officeService;

	private Office searchOffice;

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));

		this.checkRoleAction("office");
		
		super.prepare();
		searchOffice = (Office) getSearchCondition();
		if (searchOffice == null) {
			searchOffice = new Office();
		}
		
		log.info(userActionEnd(log,"prepare",SUCCESS,"startIndex",startIndex));
	}

	@Override
	public Office getModel() {
		return searchOffice;
	}

	public String execute() throws Exception {
		
		log.info(userActionStart(log, "execute","pageSize",PAGESIZE,"startIndex",startIndex));
		
		refreshList();
		log.info(userActionEnd(log, "execute",  LIST,"pagination",this.pagination));
		return LIST;
	}

	public String search() throws Exception {
		
		log.info(userActionStart(log, "search","searchOffice",searchOffice,"pageSize",PAGESIZE,"startIndex",startIndex));
		
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", LIST,"pagination",this.pagination));
		return LIST;
	}

	private Long[] ids;

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null
				& user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";
		(new SQLUtils()).makePropertiesSafe(searchOffice, null);
		this.pagination = officeService.loadPage(PAGESIZE, startIndex,
				searchOffice, officeCode);
		saveSearchCondition(searchOffice);
		saveStartIndex(pagination.getOffset());
	}

	public String bulkDelete() throws Exception {
		
		log.info(userActionStart(log, "bulkDelete","ids",ids,"startIndex",startIndex,"pageSize",PAGESIZE));
		
		officeService.bulkDelete(getUserFromSession(), ids);
		refreshList();
		log.info(userActionEnd(log, "bulkDelete", LIST,"pagination",this.pagination));
		return LIST;
	}
}
