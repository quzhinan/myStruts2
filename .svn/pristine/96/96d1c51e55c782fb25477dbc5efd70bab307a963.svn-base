package jp.iesolutions.ienursing.actions.ws;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;


import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Master;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.Nursing.OrderType;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.DeviceService;
import jp.iesolutions.ienursing.services.MailService;
import jp.iesolutions.ienursing.services.MasterService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.AuthenticationException;

@ParentPackage("ies-json-default")
@Results({ @Result(name = "nursing", type = "json", params = { "includeProperties",
		"result,errors.*, nursingList.*,user.*,zippassword", "excludeProperties",
		"nursingList.*\\.typePrevent," + "nursingList.*\\.typeDisabilityBody,"
				+ "nursingList.*\\.typeDisabilityHousework," + "nursingList.*\\.typeDisabilityHospital,"
				+ "nursingList.*\\.typeDisabilityHeavy," + "nursingList.*\\.typeDisabilityAccompanying,"
				+ "nursingList.*\\.typeDisabilityMove," + "nursingList.*\\.typeInsuranceOutService,"
				+ "nursingList.*\\.baseServicePrepare," + "nursingList.*\\.baseHealthCheck,"
				+ "nursingList.*\\.baseEnvirWork," + "nursingList.*\\.badeNursing," + "nursingList.*\\.baseRecord,"
				+ "nursingList.*\\.addingFirst," + "nursingList.*\\.addingUrgency," + "nursingList.*\\.bodyExcretionwc,"
				+ "nursingList.*\\.bodyExcretionPortablewc," + "nursingList.*\\.bodyExcretionDiaper,"
				+ "nursingList.*\\.bodyExcretionPants," + "nursingList.*\\.bodyExcretionPat,"
				+ "nursingList.*\\.bodyExcretionClean," + "nursingList.*\\.bodyExcretionObserve,"
				+ "nursingList.*\\.bodyEatHelp," + "nursingList.*\\.bodyEatObserve," + "nursingList.*\\.bodyEatWater,"
				+ "nursingList.*\\.bodyEatSpecial," + "nursingList.*\\.bodyCleanAll,"
				+ "nursingList.*\\.bodyCleanShower," + "nursingList.*\\.bodyCleanPart,"
				+ "nursingList.*\\.bodyCleanGown," + "nursingList.*\\.bodyCleanHair,"
				+ "nursingList.*\\.bodyCleanMouse," + "nursingList.*\\.bodyCleanFace,"
				+ "nursingList.*\\.bodyMoveChange," + "nursingList.*\\.bodyMoveErrorHelp,"
				+ "nursingList.*\\.bodyMoveMoveHelp," + "nursingList.*\\.bodyMoveOut," + "nursingList.*\\.bodyMoveDay,"
				+ "nursingList.*\\.bodyMoveHostipal," + "nursingList.*\\.bodyGetupHelp,"
				+ "nursingList.*\\.bodyGetupSleep," + "nursingList.*\\.bodyMedicalSure,"
				+ "nursingList.*\\.bodyMedicalApp," + "nursingList.*\\.bodyMedicalOther,"
				+ "nursingList.*\\.bodySelfCook," + "nursingList.*\\.bodySelfClean," + "nursingList.*\\.bodycopyWash,"
				+ "nursingList.*\\.liveCleanHouse," + "nursingList.*\\.liveCleanTrash,"
				+ "nursingList.*\\.liveWashWash," + "nursingList.*\\.liveWashDra,"
				+ "nursingList.*\\.liveWashIncorporating," + "nursingList.*\\.liveWashReceipt,"
				+ "nursingList.*\\.liveWashIron," + "nursingList.*\\.liveWashLaunderette,"
				+ "nursingList.*\\.liveClothOrg," + "nursingList.*\\.liveClothRepair," + "nursingList.*\\.liveBuyFood,"
				+ "nursingList.*\\.liveBuyDaily," + "nursingList.*\\.liveBuyOther," + "nursingList.*\\.liveCookMise,"
				+ "nursingList.*\\.liveCookNormal," + "nursingList.*\\.liveCookZen," + "nursingList.*\\.liveCookClean,"
				+ "nursingList.*\\.todayStateSweat," + "nursingList.*\\.todayStateCrossponding,"
				+ "nursingList.*\\.todayStateColor," + "nursingList.*\\.todayStateAppetite,"
				+ "nursingList.*\\.todayStateSleep," + "nursingList.*\\.nursingRecord,"
				+ "nursingList.*\\.officeRecord," + "nursingList.*\\.bodySelfWash," + "nursingList.*\\.bodySelfClean,"
				+ "nursingList.*\\.photoOne," + "nursingList.*\\.photoTwo," + "nursingList.*\\.photoThree,"
				+ "nursingList.*\\.voiceOne," + "nursingList.*\\.voiceTwo," + "nursingList.*\\.voiceThree,"
				+ "nursingList.*\\.scanCustomerCode," + "nursingList.*\\.scanTime," + "nursingList.*\\.scanLongitude,"
				+ "nursingList.*\\.scanLatitude," + "nursingList.*\\.scanStatus," + "nursingList.*\\.userNameService,"
				+ "nursingList.*\\.careRecotdPlanPDF," + "nursingList.*\\.medicalPDF,"
				+ "nursingList.*\\.officeCode" }),
		@Result(name = "nursingRecord", type = "json", params = { "includeProperties",
				"result,errors.*, nursing.*, nursingList.*, serviceList.*\\.code, serviceList.*\\.name, customerList.*\\.customerCode, customerList.*\\.customerName, customerList.*\\.userCode, userList.*\\.userCode, userList.*\\.userName" }),
		@Result(name = "downLaodDocument", type = "json", params = { "includeProperties", "result,errors.*" }),
		@Result(name = "updateNursing", type = "json", params = { "includeProperties",
				"result,errors.*,updateStatus, nursing.*" }),
		@Result(name = "confirmModified", type = "json", params = { "includeProperties", "result,errors.*" }),
		@Result(name = "confirmComment", type = "json", params = { "includeProperties", "result,errors.*" }),
		@Result(name = "officeList", type = "json", params = { "includeProperties", "result,errors.*,officeNameList.*" })})
public class NursingAction extends AbstractAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6404150608353209896L;

	private static final Log log_access = LogFactory.getLog("accessLog");

	private static final Log log = LogFactory.getLog(NursingAction.class);

	@Autowired
	NursingService nursingService;

	@Autowired
	UserService userService;
	
	@Autowired
	MasterService masterService;

	@Autowired
	DeviceService deviceService;

	@Autowired
	CustomerService customerService;

	@Autowired
	MailService mailService;

	@Autowired
	ServiceService serviceService;
	
	@Autowired
	OfficeService officeService;

	private List<Nursing> nursingList;

	private List<Service> serviceList;

	private String userCode;

	private String password;

	private String deviceKey;

	private String result;

	private int orderType;

	private User user;

	private String deviceToken;

	private long nursingId;

	private Nursing nursing;

	private String fileName;

	private int listType;

	private String hqlStr;

	private String updateStatus;

	private int isCarryOut;

	private File photoAndVoice;

	private String customerCode;

	private String sendMail;
	
	private Integer visitRange;
	
	private String[] officeCodeArray;

	private List<String> officeNameList;

	public String getSendMail() {
		return sendMail;
	}

	public void setSendMail(String sendMail) {
		this.sendMail = sendMail;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public File getPhotoAndVoice() {
		return photoAndVoice;
	}

	public void setPhotoAndVoice(File photoAndVoice) {
		this.photoAndVoice = photoAndVoice;
	}

	public int getIsCarryOut() {
		return isCarryOut;
	}

	public void setIsCarryOut(int isCarryOut) {
		this.isCarryOut = isCarryOut;
	}

	@JSON(name = "zippassword")
	public String getZippassword() {
		return nursingService.getZipPassword();
	}
	
	@JSON(name = "updateStatus")
	public String getUpdateStatus() {
		return updateStatus;
	}

	public void setUpdateStatus(String updateStatus) {
		this.updateStatus = updateStatus;
	}

	public String getHqlStr() {
		return hqlStr;
	}

	public void setHqlStr(String hqlStr) {
		this.hqlStr = hqlStr;
	}

	public int getListType() {
		return listType;
	}

	public void setListType(int listType) {
		this.listType = listType;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@JSON(name = "nursing")
	public Nursing getNursing() {
		return nursing;
	}

	public void setNursing(Nursing nursing) {
		this.nursing = nursing;
	}

	public long getNursingId() {
		return nursingId;
	}

	public void setNursingId(long nursingId) {
		this.nursingId = nursingId;
	}

	public String getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}

	public int getOrderType() {
		return orderType;
	}

	public void setOrderType(int orderType) {
		this.orderType = orderType;
	}

	public String[] getOfficeCodeArray() {
		return officeCodeArray;
	}

	public void setOfficeCodeArray(String[] officeCodeArray) {
		this.officeCodeArray = officeCodeArray;
	}

	public List<String> getOfficeNameList() {
		return officeNameList;
	}

	public void setOfficeNameList(List<String> officeNameList) {
		this.officeNameList = officeNameList;
	}

	@JSON(name = "user")
	public User getUser() {
		return user;
	}

	@JSON(name = "errors")
	public List<String> getErrorsList() {
		return super.getErrorsList();
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getDeviceKey() {
		return deviceKey;
	}

	public void setDeviceKey(String deviceKey) {
		this.deviceKey = deviceKey;
	}

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getVisitRange() {
		return visitRange;
	}

	public void setVisitRange(Integer visitRange) {
		this.visitRange = visitRange;
	}

	@JSON(name = "nursingList")
	public List<Nursing> getNursingList() {
		return nursingList;
	}

	public void setNursingList(List<Nursing> nursingList) {
		this.nursingList = nursingList;
	}

	@JSON(name = "serviceList")
	public List<Service> getServiceList() {
		return serviceList;
	}

	private List<Customer> customerList;

	@JSON(name = "customerList")
	public List<Customer> getCustomerList() {
		return customerList;
	}

	private List<User> userList;

	@JSON(name = "userList")
	public List<User> getUserList() {
		return userList;
	}

	public String nursingListByCharger() throws Exception {

		log.info(userActionStart(log, "nursingListByCharger", "deviceToken", deviceToken, "deviceKey", deviceKey,
				"userCode", userCode, "listType", listType, "visitRange", visitRange));

		try {
			boolean isDeviceAdmit = deviceService.deviceAdmitToUse(deviceKey);
			if (isDeviceAdmit) {
				user = userService.authenticate(userCode, password);
				if (user != null && user.isAllowLogin() && user.getRoleType() != 2) {
					userService.setDeviceWithUser(deviceToken, userCode);
					OrderType type = orderType == 0 ? OrderType.dateOrderType : OrderType.customerOrderType;
					
					if (visitRange == null) {
						visitRange = 31;
					}
					
					nursingList = nursingService.nursingRecordList(userCode, 0, type, listType, visitRange);
					if (nursingList != null) {
						result = SUCCESS;
					}
				} else {
					result = INPUT;
					addActionError("errors.message.login.failed");
				}

			} else {
				result = INPUT;
				addActionError("errors.message.device.admit");
			}
		} catch (AuthenticationException ae) {
			log_access.info(getText("logs.web.login.failed", new String[] { userCode }));
			result = INPUT;
			addActionError("errors.message.login.failed");
			log.error(ae.getStackTrace());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getStackTrace());
		}
		log.info(userActionEnd(log, "nursingListByCharger", "nursing", "nursingList", nursingList, "result", result));
		return "nursing";
	}

	public String viewNursingRecordById() throws Exception {

		log.info(userActionStart(log, "viewNursingRecordById", "userCode", userCode,
				"customerCode", customerCode, "nursingId", nursingId));

		try {
			customerList = new ArrayList<Customer>();
			userList = new ArrayList<User>();
			user = userService.authenticate(userCode, password);

			if (user != null && user.isAllowLogin()) {

				if (nursingId == 0) {
					Map<Object, Object> searchMap = new HashMap<Object, Object>();
					searchMap.put("officeCode", user.getOfficeCode());
					searchMap.put("active", "1");
					customerList = customerService.getListByProperty(searchMap, "customerNameKana, customerName");
					Map<Object, Object> searchMapUser = new HashMap<Object, Object>();
					searchMapUser.put("officeCode", user.getOfficeCode());
					searchMapUser.put("roleType", "0");
					searchMapUser.put("active", "1");
					userList = userService.getListByProperty(searchMapUser, "sortNum, userCode");

					nursing = new Nursing();
					nursing.setStatus(3);
					nursing.setCarryOut(1);
					nursing.setUserCode(user.getUserCode());
					nursing.setUserName(user.getUserName());
					nursing.setOfficeCode(user.getOfficeCode());

					SimpleDateFormat fromat = new SimpleDateFormat("yyyy-MM-dd");
					nursing.setVisitDate(fromat.format(new Date()));
					nursing.setFromTime("00:00");
					nursing.setEndTime("00:00");
					
					nursing.setBaseServicePrepare(1);
					nursing.setBaseRecord(1);
					nursing.setBaseNursing(1);
					nursing.setBaseHealthCheck(1);
					nursing.setBaseEnvirWork(1);
					
					nursingList = new ArrayList<Nursing>();
					result = SUCCESS;
				} else {
					nursing = nursingService.findById(nursingId);
					if (isCarryOut != 0) {
						nursing.setCarryOut(isCarryOut);
						// For Status Modify
						if (nursing.getStatus() == 3 || nursing.getStatus() == 4) {
							nursing.setStatus(7);
						}
						nursingService.update(nursing);
						// For Status Modify
//						nursingService.updateNursingStatus(nursingId);
					}
					// Modify for Comment - start
					if (nursing != null) {
						if (nursing.getCommentConfirmStatusShow() == EventItem.COMMENT_STATUS_UNCONFIRMED && 
								user.getUserCode() != null &&
								user.getUserCode().equals(nursing.getUserCode())) {
							nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_CONFIRMED);
							nursing.setCommentConfirmDatetime(new Date());
							nursingService.update(nursing);
						}
					}
					// Modify for Comment - end
					if (customerCode != null) {
						nursingList = nursingService.nursingRecordListByCustomer(customerCode);
					} else {
						nursingList = new ArrayList<Nursing>();
					}
				}
				Master master = masterService.findByProperty("id", 1);
				nursing.setRadius(master.getRadius());

				serviceList = serviceService.loadAllProperService(user.getOfficeCode());
				if (nursing != null) {
					Customer customer = customerService.loadCustomerByCustomerCode(nursing.getCustomerCode());
					User helper = userService.findByProperty("userCode", nursing.getUserCode());
					User follower = userService.findByProperty("userCode", nursing.getUserCodeFollow());
					if (customer != null) {
						nursing.setCustomerName(customer.getCustomerName());
						nursing.setCareRecotdPlanPDF(customer.getNursePlanePDF());
						nursing.setMedicalPDF(customer.getContectPDF());
						nursing.setAmentity(customer.getAmentity());
						nursing.setUserName(helper == null ? "" : helper.getUserName());
						if (follower != null) {
							nursing.setUserNameFollow(follower.getUserName());
						}

						if (nursing.getServiceCode() != null && nursing.getServiceCode().length() > 0) {
							Service service = serviceService.findById(nursing.getServiceCode());
							if (service != null) {
								nursing.setServiceName(service.getName());
								if (service.getActive() == 0) {
									serviceList.add(0, service);
								}
							}
						}
						nursing.setCustomerCodeFake(customer.getCustomerCodeFake());
						result = SUCCESS;
					}
				}
			} else {
				result = INPUT;
				addActionError("errors.message.login.failed");
			}

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getStackTrace());
		}
		log.info(userActionEnd(log, "viewNursingRecordById", "nursingRecord", "nursing", nursing, "result", result));
		return "nursingRecord";
	}

	public String updateNursingRecordWithFile() throws Exception {

		log.info(userActionStart(log, "updateNursingRecordWithFile", "userCode", userCode,
				"nursingId", nursingId, "photoAndVoice", photoAndVoice, "fileName", fileName));

		if (hqlStr == null || !hqlStr.startsWith("update Nursing set") || !hqlStr.endsWith(" where id='" + nursingId + "'")) {
			throw new Exception();
		}

		try {
			user = userService.authenticate(userCode, password);
			if (user != null && user.isAllowLogin()) {
				nursingId = nursingService.uploadNursingAndFile(hqlStr, photoAndVoice, fileName, nursingId, user);
				if (nursingId != 0 && sendMail.equals("1")) {
					mailService.sendConveneMessage(nursingId);
				}

				result = SUCCESS;
				updateStatus = String.valueOf(nursingId);
				nursing = nursingService.findById(nursingId);
				Customer customer = customerService.loadCustomerByCustomerCode(nursing.getCustomerCode());
				User helper = userService.findByProperty("userCode", nursing.getUserCode());
				User follower = userService.findByProperty("userCode", nursing.getUserCodeFollow());
				
				Master master = masterService.findByProperty("id", 1);
				nursing.setRadius(master.getRadius());
				
				if (customer != null && helper != null) {
					nursing.setCustomerName(customer.getCustomerName());
					nursing.setCareRecotdPlanPDF(customer.getNursePlanePDF());
					nursing.setMedicalPDF(customer.getContectPDF());
					nursing.setAmentity(customer.getAmentity());
					nursing.setUserName(helper.getUserName());
					if (follower != null) {
						nursing.setUserNameFollow(follower.getUserName());
					}

					if (nursing.getServiceCode() != null && nursing.getServiceCode().length() > 0) {
						Service service = serviceService.findById(nursing.getServiceCode());
						if (service != null) {
							nursing.setServiceName(service.getName());
						}
					}
					nursing.setCustomerCodeFake(customer.getCustomerCodeFake());
				}
			} else {
				result = INPUT;
				addActionError("errors.message.login.failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getStackTrace());
			throw e;
		}
		log.info(userActionEnd(log, "updateNursingRecordWithFile", "updateNursing", "nursing", nursing, "result",
				result, "updateStatus", updateStatus));
		return "updateNursing";
	}

	public String downloadDocument() throws Exception {

		log.info(userActionStart(log, "downloadDocument", "fileName", fileName, "customerCode", customerCode));
		
		Nursing nursing = nursingService.findById(nursingId);
		Customer customer = customerService.loadCustomerByCustomerCode(nursing.getCustomerCode());

		if (nursing == null || customer == null || fileName == null) {
			result = "failed";
			log.info(userActionEnd(log, "downloadDocument", "downLoadDocument", "result", result));
			return "downLaodDocument";
		}
		
		if (fileName.endsWith("1")) {
			fileName = "" + nursing.getId() + "_nursing_file_" + nursing.getCustomerCode() + ".zip";
		} else if (fileName.endsWith("2")) {
			fileName = customer.getNursePlanePDF();
		} else if (fileName.endsWith("3")) {
			fileName = customer.getContectPDF();
		} else if (fileName.endsWith("4")) {
			fileName = customer.getAmentity();
		}
		
		if (fileName == null) {
			result = "failed";
			log.info(userActionEnd(log, "downloadDocument", "downLoadDocument", "result", result));
			return "downLaodDocument";
		}
		
		HttpServletResponse response = ServletActionContext.getResponse();

		File file = nursingService.downloadNursingFile(fileName, customerCode);

		if (file == null) {

			result = "failed";
			log.info(userActionEnd(log, "downloadDocument", "downLoadDocument", "result", result));
			return "downLaodDocument";
		}

		FileInputStream fis = new FileInputStream(file);
		BufferedInputStream bis = new BufferedInputStream(fis);

		OutputStream os = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(os);

		response.reset();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");
		response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());
		response.setHeader("Content-Length", String.valueOf(bis.available()));

		int bytesRead = 0;
		byte[] buffer = new byte[1024];
		while ((bytesRead = bis.read(buffer)) != -1) {
			bos.write(buffer, 0, bytesRead);
		}
		bos.flush();
		bos.close();
		bis.close();

		os.close();
		fis.close();
		result = SUCCESS;

		log.info(userActionEnd(log, "downloadDocument", "downLoadDocument", "result", result));

		return "downLaodDocument";
	}

	public String confirmModified() throws Exception {

		log.info(userActionStart(log, "confirmModified", "nursingId", nursingId));

		nursing = nursingService.findById(nursingId);
		if (nursing != null) {
			nursing.setUpdateStatus(Event.UPDATE_STATUS_CONFIRMED);
			nursingService.update(nursing);
			result = SUCCESS;
		} else {
			addActionError("messages.plan.event.data.not.exited");
			result = ERROR;
		}

		log.info(userActionEnd(log, "confirmModified", "confirmModified", "nursing", nursing, "result", result));

		return "confirmModified";
	}

	// Modify for Comment - start
	public String confirmComment() throws Exception {

		log.info(userActionStart(log, "confirmComment", "nursingId", nursingId));

		user = userService.authenticate(userCode, password);

		if (user != null && user.isAllowLogin()) {
			nursing = nursingService.findById(nursingId);
			if (nursing != null) {
				if (nursing.getCommentConfirmStatusShow() == EventItem.COMMENT_STATUS_UNCONFIRMED && 
						user.getUserCode() != null &&
						user.getUserCode().equals(nursing.getUserCode())) {
					nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_CONFIRMED);
					nursing.setCommentConfirmDatetime(new Date());
					nursingService.update(nursing);
				}
				result = SUCCESS;
			} else {
				addActionError("messages.plan.event.data.not.exited");
				result = ERROR;
			}
		}

		log.info(userActionEnd(log, "confirmComment", "confirmComment", "nursing", nursing, "result", result));

		return "confirmComment";
	}
	// Modify for Comment - end
	
	public String getOfficeList() throws Exception {

		log.info(userActionStart(log, "getOfficeList", "userCode", userCode, "officeCodeList", officeCodeArray));

		String officeName = "";
		
		try {
			user = userService.authenticate(userCode, password);
			Office office = null;
			officeNameList = new ArrayList<>();
			if (user != null && user.isAllowLogin()) {
				for (String officeCode : officeCodeArray) {
					if (officeCode != "") {
						office = officeService.findByProperty("officeCode", officeCode);
						if (office == null) {
							officeNameList.add(officeName);
						} else {
							officeNameList.add(office.getOfficeName());
						}
					} else {
						officeNameList.add(officeName);
					}
				}
				result = SUCCESS;
			} else {
				result = INPUT;
				addActionError("errors.message.login.failed");
			}
		} catch (AuthenticationException ae) {
			log_access.info(getText("logs.web.login.failed", new String[] { userCode }));
			result = INPUT;
			addActionError("errors.message.login.failed");
			log.error(ae.getStackTrace());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getStackTrace());
		}

		log.info(userActionEnd(log, "getOfficeList", "officeList", officeNameList, "result", result));

		return "officeList";
	}

}
