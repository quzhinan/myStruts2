package jp.iesolutions.ienursing.actions;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CommentService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.util.SQLUtils;

/*
 * Add for Comment
 */
@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = CommentListAction.SUCCESS, location = "comment-list.jsp"),
		@Result(name = CommentListAction.LIST, location = "comment-list.ies?${ietoken}", type = "redirect") })
public class CommentListAction extends AbstractPageAction<Customer> implements ModelDriven<Customer>, Preparable {

	private static final long serialVersionUID = 1L;

	private static final Log log = LogFactory.getLog(CommentListAction.class);

	@Autowired
	private CommentService commentService;

	private Customer searchCustomer;

	@Override
	public Customer getModel() {
		return searchCustomer;
	}

	@Autowired
	private OfficeService officeService;

	private List<Office> offices;

	public List<Office> getOffices() {
		return offices;
	}

	private Long[] ids;

	public void setIds(Long[] ids) {
		this.ids = ids;
	}

	public void validate() {

	}

	@Override
	public void prepare() throws Exception {

		log.info(userActionStart(log, "prepare"));

		super.prepare();
		searchCustomer = (Customer) getSearchCondition();
		if (searchCustomer == null) {
			searchCustomer = new Customer();
		}

		if (getUserFromSession().getRoleType() == 2) {
			offices = officeService.loadAll();
		} else {
			offices = new ArrayList<Office>();
			offices.add(officeService.findByProperty("officeCode", getUserFromSession().getOfficeCode()));
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "startIndex", startIndex));
	}

	public String execute() throws Exception {

		log.info(userActionStart(log, "execute", "pageSize", PAGESIZE, "startIndex", startIndex));

		refreshList();
		log.info(userActionEnd(log, "execute", SUCCESS, "pagination", this.pagination));
		return SUCCESS;
	}

	public String search() throws Exception {
		log.info(userActionStart(log, "search", "pageSize", PAGESIZE, "startIndex", startIndex, "searchCustomer",
				searchCustomer));
		clearStartIndex();
		refreshList();
		log.info(userActionEnd(log, "search", SUCCESS, "pagination", this.pagination));
		return SUCCESS;
	}

	private void refreshList() throws Exception {
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null & user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";
		if (officeCode.equals("administrator") && searchCustomer.getOfficeCode() != null
				&& searchCustomer.getOfficeCode().length() > 1) {
			officeCode = searchCustomer.getOfficeCode();
		}
		Timestamp finalUpdateFrom = null;
		if (StringUtils.isNotEmpty(searchCustomer.getCommentUpdateFrom())) {
			String commentUpdateFrom = searchCustomer.getCommentUpdateFrom().replaceAll("/", "-") + " 00:00:00";
			finalUpdateFrom = Timestamp.valueOf(commentUpdateFrom);
		}
		Timestamp finalUpdateTo = null;
		if (StringUtils.isNotEmpty(searchCustomer.getCommentUpdateTo())) {
			String commentUpdateTo = searchCustomer.getCommentUpdateTo().replaceAll("/", "-") + " 23:59:59";
			finalUpdateTo = Timestamp.valueOf(commentUpdateTo);
		}
		(new SQLUtils()).makePropertiesSafe(searchCustomer, null);

		this.pagination = commentService.loadPage(PAGESIZE, startIndex, searchCustomer, officeCode, finalUpdateFrom,
				finalUpdateTo);
		saveSearchCondition(searchCustomer);
		saveStartIndex(pagination.getOffset());
	}

	public String commentCommit() throws Exception {
		log.info(userActionStart(log, "commentCommit", "ids", ids, "commentCommitFrom",
				searchCustomer.getCommentCommitFrom(), "commentCommitTo", searchCustomer.getCommentCommitTo()));

		String commentCommitFromString = "";
		if (StringUtils.isNotEmpty(searchCustomer.getCommentCommitFrom())) {
			commentCommitFromString = searchCustomer.getCommentCommitFrom().replaceAll("/", "");
		}
		String commentCommitToString = "";
		if (StringUtils.isNotEmpty(searchCustomer.getCommentCommitTo())) {
			commentCommitToString = searchCustomer.getCommentCommitTo().replaceAll("/", "");
		}
		try {
			commentService.commentCommit(commentCommitFromString, commentCommitToString, ids);
		} catch (Exception e) {
			printLog(log, e);
		}

		log.info(userActionEnd(log, "commentCommit", LIST, "pagination", this.pagination));
		return LIST;
	}

}
