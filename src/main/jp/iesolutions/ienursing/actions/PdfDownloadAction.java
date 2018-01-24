package jp.iesolutions.ienursing.actions;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.ServiceUnitTotal;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.pdf.CustomerMonthNursingPDFData;
import jp.iesolutions.ienursing.pdf.CustomerMonthNursingPDFGenerator;
import jp.iesolutions.ienursing.pdf.CustomerMonthShiftPDFData;
import jp.iesolutions.ienursing.pdf.CustomerMonthShiftPDFGenerator;
import jp.iesolutions.ienursing.pdf.CustomerNursingRecordPDFData;
import jp.iesolutions.ienursing.pdf.CustomerNursingRecordPDFGenerator;
import jp.iesolutions.ienursing.pdf.HelperMonthShiftPDFData;
import jp.iesolutions.ienursing.pdf.HelperMonthShiftPDFGenerator;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.UserService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
public class PdfDownloadAction extends AbstractAction {

	private static final long serialVersionUID = 552990884209038434L;
	private static final Log log = LogFactory.getLog(PdfDownloadAction.class);

	@Autowired
	private UserService userService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private NursingService nursingService;

	@Autowired
	private OfficeService officeService;
	@Autowired
	private EventService eventService;

	@Autowired
	private CustomerMonthNursingPDFGenerator customerMonthNursingPDFGenerator;

	@Autowired
	private CustomerMonthShiftPDFGenerator customerMonthShiftPDFGenerator;

	@Autowired
	private CustomerNursingRecordPDFGenerator customerNursingRecordPDFGenerator;

	@Autowired
	private HelperMonthShiftPDFGenerator helperMonthShiftPDFGenerator;

	private long helperId;
	private long customerId;
	private String customerCode;
	private String selectedYM;
	private String fromDate;
	private String toDate;
	// Modify for Comment - start
	private int downloadOption;
	// Modify for Comment - end

	public void setHelperId(long helperId) {
		this.helperId = helperId;
	}

	public void setCustomerId(long customerId) {
		this.customerId = customerId;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public void setSelectedYM(String selectedYM) {
		this.selectedYM = selectedYM;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	// Modify for Comment - start
	public void setDownloadOption(int downloadOption) {
		this.downloadOption = downloadOption;
	}
	// Modify for Comment - end

	/**
	 * 利用者別月間記録表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String customerMonthNursing() throws Exception {

		log.info(userActionStart(log, "customerMonthNursing", "customerCode", customerCode, "selectedYM", selectedYM));

		if (this.customerCode != null && this.selectedYM != null) {

			User loginUser = getUserFromSession();
			Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
			String officeName = office.getOfficeName();

			HttpServletResponse response = ServletActionContext.getResponse();

			Customer customer = this.customerService.findByProperty("customerCode", customerCode);

			String visitMonth = selectedYM.substring(0, 4) + "-" + selectedYM.substring(4, 6);
			String startDate = visitMonth + "-01";
			String toDate = visitMonth + "-31";
			Nursing nursing = new Nursing();
			nursing.setCustomerCode(customerCode);
			nursing.setStatus(-1);
			nursing.setUserCodeService("0");
			if ("0".equals(loginUser.getOfficeCode())) {
				loginUser.setOfficeCode(null);
			}
			nursing.setOfficeCode(loginUser.getOfficeCode());
			List<Nursing> nursingList = nursingService.searchNursingByCondition(startDate, toDate, null, nursing, null);

			CustomerMonthNursingPDFData data = new CustomerMonthNursingPDFData();
			data.setCustomer(customer);
			data.setOfficeName(officeName);
			data.setNursingList(nursingList);
			data.setVisitMonth(visitMonth);
			String fileName = "月間記録_" + customer.getCustomerName() + "_" + selectedYM + ".pdf";
			customerMonthNursingPDFGenerator.downloadPDF(response, fileName, data);
		}
		log.info(userActionEnd(log, "customerMonthNursing", SUCCESS));
		return null;
	}

	/**
	 * 利用者別月間シフト
	 * 
	 * @return
	 * @throws Exception
	 */
	public String customerMonthShift() throws Exception {

		log.info(userActionStart(log, "customerMonthShift", "customerId", customerId, "selectedYM", selectedYM));

		User loginUser = getUserFromSession();
		Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
		HttpServletResponse response = ServletActionContext.getResponse();
		String officeName = office.getOfficeName();

		Customer customer = this.customerService.findById(customerId);

		String customerUser = "";
		ServiceUnitTotal total = null;
		List<Event> eventList = null;
		if (office != null && customer != null) {
			total = eventService.loadServiceUnitTotal(office.getId(), customerId, selectedYM);
			eventList = eventService.loadAchievementEvents(office.getId(), 0, 0, customerId, selectedYM,
					selectedYM + "31");

			if (!StringUtils.isEmpty(customer.getUserCode())) {
				User user = userService.findByProperty("userCode", customer.getUserCode());
				if (user != null && !StringUtils.isEmpty(user.getUserName())) {
					customerUser = user.getUserName();
				}
			}
		}

		if (customer != null && total != null) {

			CustomerMonthShiftPDFData data = new CustomerMonthShiftPDFData();
			data.setVisitMonth(selectedYM.substring(0, 4) + "-" + selectedYM.substring(4, 6));
			data.setCustomer(customer);
			data.setServiceUserName(customerUser);
			data.setServiceUnitTotal(total);
			data.setEvents(eventList);
			data.setOfficeName(officeName);
			String fileName = "予定表_" + customer.getCustomerName() + "_" + selectedYM + ".pdf";
			customerMonthShiftPDFGenerator.downloadPDF(response, fileName, data);
		}

		log.info(userActionEnd(log, "customerMonthShift", SUCCESS));

		return null;
	}

	/**
	 * 介護記録票
	 * 
	 * @return
	 * @throws Exception
	 */
	public String customerNursingRecord() throws Exception {

		log.info(userActionStart(log, "customerNursingRecord", "customerCode", customerCode, "fromDate", fromDate,
				"toDate", toDate));

		String customerUser = " ";
		List<Nursing> nursingList = new ArrayList<Nursing>();
		Customer customer = this.customerService.findByProperty("customerCode", customerCode);
		if (this.customerCode != null && fromDate.length() == 10 && toDate.length() == 10) {
			if (Integer.parseInt(
					fromDate.substring(0, 4) + fromDate.substring(5, 7) + fromDate.substring(8, 10)) <= Integer
							.parseInt(toDate.substring(0, 4) + toDate.substring(5, 7) + toDate.substring(8, 10))) {
				// from日期必须在to日期之前
				User loginUser = getUserFromSession();
				Office office = officeService.findByProperty("officeCode", loginUser.getOfficeCode());
				String officeName = office.getOfficeName();

				Nursing nursing = new Nursing();
				nursing.setCustomerCode(customerCode);
				// Modify for Comment - start
				nursing.setStatus(-2);
				// Modify for Comment - end
				nursing.setUserCodeService("0");
				List<Nursing> nursingList_blank = nursingService.searchNursingByCondition(fromDate, toDate,
						customerCode, nursing, null);
				for (int i = 0; i < nursingList_blank.size(); i++) {
					nursing = nursingService.findById(nursingList_blank.get(i).getId());
					nursing.setServiceName(nursingList_blank.get(i).getServiceName());
					nursing.setServiceNameFull(nursingList_blank.get(i).getServiceNameFull());
					nursing.setUserName(nursingList_blank.get(i).getUserName());
					nursing.setUserNameFollow(nursingList_blank.get(i).getUserNameFollow());
					nursingList.add(nursing);
				}
				HttpServletResponse response = ServletActionContext.getResponse();
				String fileName = "記録票_" + customer.getCustomerName() + "_" + fromDate + "_" + toDate + ".pdf";
				CustomerNursingRecordPDFData data = new CustomerNursingRecordPDFData();
				if (!StringUtils.isEmpty(customer.getUserCode())) {
					User user = userService.findByProperty("userCode", customer.getUserCode());
					if (user != null && !StringUtils.isEmpty(user.getUserName())) {
						customerUser = user.getUserName();
					}
				}
				data.setOfficeName(officeName);
				data.setServiceUserName(customerUser);
				data.setNursingList(nursingList);
				data.setCustomer(customer);
				// Modify for Comment - start
				data.setDownloadOption(downloadOption);
				// Modify for Comment - end
				customerNursingRecordPDFGenerator.downloadPDF(response, fileName, data);
			}
		}
		log.info(userActionEnd(log, "customerNursingRecord", SUCCESS));
		return null;
	}

	/**
	 * 職員別月間シフト
	 * 
	 * @return
	 * @throws Exception
	 */
	public String helperMonthShift() throws Exception {

		log.info(userActionStart(log, "helperMonthShift", "helperId", helperId, "selectedYM", selectedYM));

		User loginUser = getUserFromSession();
		HttpServletResponse response = ServletActionContext.getResponse();
		User user = userService.findById(helperId);
		ServiceUnitTotal total = null;
		List<Event> events = null;
		List<Event> events_follower = null; // 是同行者的情况
		HelperMonthShiftPDFData data = new HelperMonthShiftPDFData();
		List<String> serviceNameStrings = new ArrayList<String>();
		List<String> serviceNameStrings2 = new ArrayList<String>();
		String officeName = " ";

		if (helperId == 0 && loginUser.getId() != 0) { // 只能其他用户不能下载admin的数据
			return null;
		}
		if (selectedYM.length() == 6) { // 输入进来的年月必须为6位
			Office office = officeService.findByProperty("officeCode", user.getOfficeCode());
			officeName = office.getOfficeName();
			total = eventService.loadHelperServiceUnitTotal(office.getId(), helperId, selectedYM);
			events = eventService.loadAchievementEvents(office.getId(), helperId, 0, 0, selectedYM, selectedYM + "31");

			events_follower = eventService.loadAchievementEvents(office.getId(), 0, helperId, 0, selectedYM,
					selectedYM + "31");

			for (int i = 0; i < events.size(); i++) {
				Customer customer = this.customerService.findByProperty("customerCode",
						events.get(i).getCustomer().getCustomerCode());
				String customerUser = " ";
				if (!StringUtils.isEmpty(customer.getUserCode())) {
					User userget = userService.findByProperty("userCode", customer.getUserCode());
					if (userget != null && !StringUtils.isEmpty(userget.getUserName())) {
						customerUser = userget.getUserName();
					}
				}
				serviceNameStrings.add(customerUser);
			}
			for (int i = 0; i < events_follower.size(); i++) {
				Customer customer = this.customerService.findByProperty("customerCode",
						events_follower.get(i).getCustomer().getCustomerCode());
				String customerUser2 = " ";
				if (!StringUtils.isEmpty(customer.getUserCode())) {
					User userget = userService.findByProperty("userCode", customer.getUserCode());
					if (userget != null && !StringUtils.isEmpty(userget.getUserName())) {
						customerUser2 = userget.getUserName();
					}
				}
				serviceNameStrings2.add(customerUser2);
			}
		}
		data.setHelperName(user.getUserName());
		data.setEvents(events);
		data.setEvents2(events_follower);
		data.setVisitMonth(selectedYM);
		data.setServiceName(serviceNameStrings);
		data.setServiceName2(serviceNameStrings2);
		data.setServiceUnitTotal(total);
		data.setOfficeName(officeName);
		String fileName = "シフト_" + user.getUserName() + "_" + selectedYM + ".pdf";
		helperMonthShiftPDFGenerator.downloadPDF(response, fileName, data);

		log.info(userActionEnd(log, "helperMonthShift", SUCCESS));

		return null;
	}
}
