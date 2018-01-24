package jp.iesolutions.ienursing.actions.js;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.Week;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.WeekService;
import jp.iesolutions.ienursing.services.exceptions.ServiceException;

@ParentPackage("ies-json-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results({
		@Result(name = WeekAction.SUCCESS, type = "json", params = { "root", "action", "contentType", "text/html",
				"includeProperties", "result, message", "excludeProperties", "" }),
		@Result(name = WeekAction.INPUT, type = "json", params = { "root", "action", "contentType", "text/html",
				"includeProperties", "result, message", "excludeProperties", "" }),
		@Result(name = WeekAction.LIST, type = "json", params = { "root", "action", "contentType", "text/html",
				"includeProperties", "result, message, customerName, weekList.*", "excludeProperties", "" }) })
public class WeekAction extends AbstractAction implements ModelDriven<Week>, Preparable {

	private static final long serialVersionUID = -3555768889827672252L;
	private final Log apLog = LogFactory.getLog("apLog");
	private static final Log log = LogFactory.getLog(WeekAction.class);

	@Override
	public Week getModel() {
		return week;
	}

	@Autowired
	UserService userService;

	@Autowired
	CustomerService customerService;

	@Autowired
	OfficeService officeService;

	@Autowired
	NursingService nursingService;

	@Autowired
	ServiceService serviceService;

	@Autowired
	WeekService weekService;

	private String customerCode;

	private String fromDay;

	private String toDay;

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public void setFromDay(String fromDay) {
		this.fromDay = fromDay;
	}

	public void setToDay(String toDay) {
		this.toDay = toDay;
	}

	private Week week;
	private String result = INPUT;
	private String message;

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	private String force;

	public void setForce(String force) {
		this.force = force;
	}

	@Override
	public void prepare() throws Exception {
		log.info(userActionStart(log, "prepare"));
		if (week == null) {
			week = new Week();
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "week", week));
	}

	@Override
	public String execute() {
		log.info(userActionStart(log, "execute", "customerCode", customerCode, "fromDay", fromDay, "toDay", toDay));
		try {
			Office office = officeService.findByProperty("officeCode", getUserFromSession().getOfficeCode());
			Customer customer = customerService.findByProperty("customerCode", this.customerCode);
			boolean monthExist = weekService.checkMonthExistEvent(office.getId(), this.fromDay, this.toDay);
			if (monthExist && !"isForce".equals(force)) {
				message = "<br><br>今月に既存イベント。";
			} else {
				Map<String, Integer> resutMap = weekService.saveWeekLoopInMonth(office, customer, this.fromDay, this.toDay);
				if (resutMap.get("achievementItemsExist") > 0) {
					message = "実績データがあるので、処理を中止しました。ご確認ください。<br><br>";
				} else {
					message = "利用者 " + resutMap.get("totalCustomer") + " 名<br>";
					message += "一括作成が正常に完了しました。";
				}
				result = SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = "<br>週間取込は失敗しました。";
		}

		apLog.info("　　　　" + message);

		log.info(userActionEnd(log, "execute", INPUT, "result", result, "message", message));
		return result;
	}

	public String changeActive() throws Exception {
		log.info(userActionStart(log, "changeActive"));

		Week dbWeek = weekService.findById(week.getId());
		if (dbWeek != null) {
			dbWeek.setActive(week.getActive());
			weekService.update(dbWeek);
			message = "ロック解除";
			result = SUCCESS;
		} else {
			result = INPUT;
		}

		log.info(userActionEnd(log, "save", SUCCESS, "result", result, "week", week, "message", message));
		return SUCCESS;
	}

	private List<Week> weekList;

	@JSON(name = "weekList")
	public List<Week> getWeekList() {
		return weekList;
	}

	private String customerName;

	@JSON(name = "customerName")
	public String getCustomerName() {
		return customerName;
	}

	public String loadCustomerWeekList() throws ServiceException {
		Customer customer = customerService.findById(week.getId());
		weekList = this.weekService.loadWeekByCustomerId(week.getId());
		if (customer != null)
			customerName = customer.getCustomerName();

		message = "ロック解除";
		result = SUCCESS;
		return LIST;
	}
}
