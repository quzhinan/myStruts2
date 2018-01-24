package jp.iesolutions.ienursing.actions;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.pdf.FileGeneratorHelper;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.util.CSVMaker;
import jp.iesolutions.ienursing.util.SQLUtils;
import jp.iesolutions.ienursing.util.ZipCompressor;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = LoginAction.SUCCESS, location = "nursing-list.jsp") })
public class NursingListAction extends AbstractAction implements ModelDriven<Nursing>, Preparable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8106668454847098835L;

	public final Boolean SHOW_LIST_MAIN_TITLE = true;

	private static final Log log = LogFactory.getLog(NursingListAction.class);

	@Autowired
	private CSVMaker csvMaker;

	@Autowired
	private NursingService nursingService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private UserService userService;

	private List<Nursing> nursingList;

	private List<Customer> customerList;

	private List<User> chargeUserList;

	private String sortCondition;

	private Nursing nursing;

	private List<User> serviceUserList;

	public String getSortCondition() {
		return sortCondition;
	}

	public void setSortCondition(String sortCondition) {
		this.sortCondition = sortCondition;
	}

	public List<Customer> getCustomerList() {
		return customerList;
	}

	public void setCustomerList(List<Customer> customerList) {
		this.customerList = customerList;
	}

	public List<User> getChargeUserList() {
		return chargeUserList;
	}

	public void setChargeUserList(List<User> chargeUserList) {
		this.chargeUserList = chargeUserList;
	}

	public List<User> getServiceUserList() {
		return serviceUserList;
	}

	public void setServiceUserList(List<User> serviceUserList) {
		this.serviceUserList = serviceUserList;
	}

	public List<Nursing> getNursingList() {
		setNursingListToSession(nursingList);
		return nursingList;
	}

	public void setNursingList(List<Nursing> nursingList) {
		this.nursingList = nursingList;
	}

	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub
		log.info(userActionStart(log, "prepare"));
		nursing = getNursingFromSession();
		if (nursing == null) {
			nursing = new Nursing();
		}
		User user = getUserFromSession();
		serviceUserList = userService.loadAllUserByUser(user, true, 1);
		chargeUserList = userService.loadAllUserByUser(user, false, 1);

		String sessionUserOfficeCode = user.getOfficeCode();
		if (sessionUserOfficeCode != null && sessionUserOfficeCode.length() > 0) {

			if (nursing.getUserCodeService() == null) {
				nursing.setUserCodeService(user.getUserCode());
			}
			nursing.setOfficeCode(sessionUserOfficeCode);

			Map<Object, Object> maps = new HashMap<Object, Object>();
			maps.put("officeCode", sessionUserOfficeCode);
			maps.put("active", "1");
			customerList = customerService.getListByProperty(maps, "customerNameKana, customerName");
			log.info(userActionEnd(log, "prepare", SUCCESS, "customerList", (customerList == null ? 0 : customerList.size())));
		} else {
			customerList = customerService.loadAll();
			log.info(userActionEnd(log, "prepare", SUCCESS, "customerList", (customerList == null ? 0 : customerList.size())));
		}
	}

	@Override
	public String execute() throws Exception {
		// try {
		// User user = getUserFromSession();
		// nursingList =
		// nursingService.nursingRecordList(user.getUserCode(),user.getRoleType(),OrderType.dateOrderType,0);
		// } catch (Exception e) {
		// // TODO: handle exception
		// e.printStackTrace();
		// }
		// return SUCCESS;
		log.info(userActionStart(log, "execute"));
		setSortConditionToSession(null);
		// nursing = new Nursing();
		// User user = getUserFromSession();
		// if (user.getRoleType() == 1) {
		// if (nursing.getUserCodeService() == null) {
		// nursing.setUserCodeService(user.getUserCode());
		// }
		// nursing.setOfficeCode(user.getOfficeCode());
		// }

		//nursingService.updateNursingStatus();

		// String monthKey = this.getCurrMonthKey();
		// String prevMonthKey = this.getPrevYearMonthKeyWithKey(monthKey);
		// String nextMonthKey = this.getNextYearMonthKeyWithKey(monthKey);
		// YearMonth nextYearMonth = this.getYearMonthWithKey(nextMonthKey);
		// nursing.setStartDate(prevMonthKey.substring(0, 4) + "-" +
		// prevMonthKey.substring(4, 6) + "-01");
		// nursing.setToDate(nextMonthKey.substring(0, 4) + "-" +
		// nextMonthKey.substring(4, 6) + "-" + nextYearMonth.getMaxDays());

		String toDateString = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		Date date = new Date();// 取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, -3);// 把日期往后增加一天.整数往后推,负数往前移动
		date = calendar.getTime();
		String fromDateString = new SimpleDateFormat("yyyy-MM-dd").format(date);
		nursing.setStartDate(fromDateString);
		nursing.setToDate(toDateString);
		nursing.setUserCodeService("0");
		nursing.setCustomerCode(null);
		nursing.setCustomerCodeLike(null);
		nursing.setUserCode("0");
		nursing.setUserCodeFollow("0");
		nursing.setStatus(-1);
		String searchResult = this.search();
		log.info(userActionEnd(log, "execute", searchResult, "nursing", nursing));
		return searchResult;
	}

	public String search() throws Exception {
		nursing.setOfficeCode(getUserFromSession().getOfficeCode());
		log.info(userActionStart(log, "search", "nursing", nursing));
		try {
			setNursingToSession(nursing);
			if (sortCondition == null) {
				sortCondition = getSortConditionFromSession();
			}
			(new SQLUtils()).makePropertiesSafe(nursing, null);
			nursingList = nursingService.searchNursingByCondition(nursing.getStartDate(), nursing.getToDate(),
					nursing.getCustomerCodeLike(), nursing, sortCondition);
			if (nursingList != null) {
				Date systemDate = new Date();
				session.put("nursing_list_search_time", systemDate);
				for (Nursing nursing : nursingList) {
					nursing.setSystemDate(systemDate);
				}
			}
		} catch (Exception e) {
			printLog(log, e);
		}
		log.info(userActionEnd(log, "search", SUCCESS, "nursingList", "" + (nursingList == null ? 0 : nursingList.size())));
		return SUCCESS;
	}

	public String reSort() throws Exception {
		log.info(userActionStart(log, "reSort"));
		try {
			setSortConditionToSession(sortCondition);
			(new SQLUtils()).makePropertiesSafe(nursing, null);
			nursingList = nursingService.searchNursingByCondition(nursing.getStartDate(), nursing.getToDate(),
					nursing.getCustomerCodeLike(), nursing, sortCondition);
		} catch (Exception e) {
			printLog(log, e);
		}
		log.info(userActionEnd(log, "reSort", SUCCESS, "nursingList", (nursingList == null ? 0 : nursingList.size())));
		return SUCCESS;
	}
	
	public String download() throws Exception {
		
		log.info(userActionStart(log, "download"));

		Date systemDate = (Date)session.get("nursing_list_search_time");
		this.search();
		session.put("nursing_list_search_time", systemDate);
		
		if (nursingList != null) {

			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmm");
			String csvFileName = "YJ" + getUserFromSession().getOfficeCode() + "_" + simpleDateFormat.format(new Date())  + ".CSV";
			String workFolderName = this.makeCsvTempPath();
			String workFolderPath = csvMaker.getCsvPath() + File.separator + workFolderName;
			String zipFileName = workFolderName+ ".zip";
			String zipFilePath = workFolderPath + ".zip";
			
			List<Nursing> eventsList = new ArrayList<Nursing>();
			for (Nursing nursing : nursingList) {
				nursing.setSystemDate(systemDate);
				eventsList.add(nursing);
			}
			
			this.makeCsvFile(workFolderPath, csvFileName, eventsList);

			File zipFile = new File(zipFilePath);
			ZipCompressor zipCompressor = new ZipCompressor();
			zipCompressor.setZipFile(zipFile);
			zipCompressor.compress(workFolderPath + File.separator + csvFileName);
			
			File workFolder = new File(workFolderPath);
			if (workFolder.exists()) {
				workFolder.delete();
			}

			FileInputStream fis = null;
			BufferedInputStream bis = null;
			OutputStream os = null;
			BufferedOutputStream bos = null;

			try {
				HttpServletResponse response = ServletActionContext.getResponse();
				fis = new FileInputStream(zipFile);
				bis = new BufferedInputStream(fis);
				os = response.getOutputStream();
				bos = new BufferedOutputStream(os);
				
				FileGeneratorHelper.setResponseHeader(response, zipFileName, bis.available());
				
				int bytesRead = 0;
				byte[] buffer = new byte[1024];
				while ((bytesRead = bis.read(buffer)) != -1) {
					bos.write(buffer, 0, bytesRead);
				}

				bos.flush();
				
			} catch (FileNotFoundException e) {
				printLog(log, e);
			} catch (IOException e) {
				printLog(log, e);
			} finally {
				if (bos != null) try { bos.close(); } catch (IOException e) { printLog(log, e);}
				if (bis != null) try { bis.close(); } catch (IOException e) { printLog(log, e);}
				if (os != null) try { os.close(); } catch (IOException e) { printLog(log, e);}
				if (fis != null) try { fis.close(); } catch (IOException e) { printLog(log, e);}
			}
			
			if (zipFile.isFile() && zipFile.exists()) {
				zipFile.delete();
			}

		}
		
		log.info(userActionEnd(log, "download", SUCCESS));
		
		return null;
	}
	
	private String makeCsvTempPath() {

		String string = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss-SS").format(new Date());
		File dirFile = new File(this.csvMaker.getCsvPath());
		if (!dirFile.isDirectory()) {
			dirFile.mkdir();
		}

		int max = 9999;
		int min = 1000;
		int random = new Random().nextInt(max) % (max - min + 1) + min;

		String tempPath = string + "-" + random;
		new File(csvMaker.getCsvPath() + File.separator + tempPath).mkdir();
		
		return tempPath;
	}
	
	private void makeCsvFile(String path, String fileName, List<Nursing> datas) throws Exception{
		
		// Modify for Comment - start
		final String header = "\"訪問日\",\"曜日\",\"開始時間\",\"終了時間\",\"提供時間（分）\",\"身体介護時間\",\"生活支援時間\",\"利用者番号\",\"利用者氏名\",\"サービス種類コード\",\"サービス項目コード\",\"サービス内容\",\"職員番号（主）\",\"訪問者（主）\",\"職員番号（同行）\",\"訪問者（同行）\",\"状態\",\"指示事項\",\"介護記録\",\"事業所使用欄\",\"連絡事項（「担当への連絡」）\"\r\n";
		// Modify for Comment - end

		File folder = new File(path);
		if (!folder.isDirectory()) {
			folder.mkdir();
		}

		File file = null;
		BufferedWriter writer = null;

		try {
			User tempUser = new User();
			
			file = new File(path + File.separator + fileName);
			file.createNewFile();

			writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "MS932"), 1024);
			
			writer.write(header);
			for (Nursing nursing : datas) {
				String userCode = null;
				String userCodeFollow = null;
				String serviceTypeCode = null;
				String ServiceItemCode = null;

				String serviceCode = nursing.getServiceCode();
				if (serviceCode != null && serviceCode.length() >= 2) {
					serviceTypeCode = serviceCode.substring(0, 2);
					ServiceItemCode = serviceCode.substring(2, serviceCode.length());
				} else {
					serviceTypeCode = serviceCode;
				}
				
				tempUser.setUserCode(nursing.getUserCode());
				userCode = tempUser.getUserCodeShort();
				
				tempUser.setUserCode(nursing.getUserCodeFollow());
				userCodeFollow = tempUser.getUserCodeShort();
				
				writer.write(makeCsvCol((nursing.getVisitDate() == null ? "" : nursing.getVisitDate().replaceAll("-", "/")), false));
				// Modify for Comment - start
				writer.write(makeCsvCol((nursing.getVisitDate() == null ? "" : getWeekByDate(nursing.getVisitDate())), false));
				// Modify for Comment - end
				writer.write(makeCsvCol(nursing.getFromTime(), false));
				writer.write(makeCsvCol(nursing.getEndTime(), false));
				writer.write(makeCsvCol("" + (nursing.getServiceTime1() + nursing.getServiceTime2()), false));
				// Modify for Comment - start
				writer.write(makeCsvCol("" + nursing.getServiceTime1(), false));
				writer.write(makeCsvCol("" + nursing.getServiceTime2(), false));
				// Modify for Comment - end
				writer.write(makeCsvCol(nursing.getCustomerCode(), false));
				writer.write(makeCsvCol(nursing.getCustomerName(), false));
				writer.write(makeCsvCol(serviceTypeCode, false));
				writer.write(makeCsvCol(ServiceItemCode, false));
				writer.write(makeCsvCol(nursing.getServiceNameFull(), false));
				writer.write(makeCsvCol(userCode, false));
				writer.write(makeCsvCol(nursing.getUserName(), false));
				writer.write(makeCsvCol(userCodeFollow, false));
				writer.write(makeCsvCol(nursing.getUserNameFollow(), false));
				writer.write(makeCsvCol(makeCsvStatus(nursing.getStatus(), nursing.getFinishedFlag()), false));
				writer.write(makeCsvCol(nursing.getCommentContent(), false));
				// Modify for Comment - start
				writer.write(makeCsvCol(nursing.getNursingRecord(), false));
				writer.write(makeCsvCol(nursing.getOfficeRecord(), false));
				writer.write(makeCsvCol(nursing.getRemark(), true));
				// Modify for Comment - end
			}
			
			writer.flush();

		} catch (IOException e) {
			printLog(log, e);
		} finally {
			if (writer != null) try { writer.close(); } catch (IOException e) { printLog(log, e);}
		}
	}
	
	private String getWeekByDate(String date) throws Exception{
		String[] weeks = { "日", "月", "火", "水", "木", "金", "土" };
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date newDate = sdf.parse(date);
		Calendar cal = Calendar.getInstance();
		cal.setTime(newDate);
		int week_index = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (week_index < 0) {
			week_index = 0;
		}
		return weeks[week_index];
	}
	
	private String makeCsvCol(String value, boolean isNewLine) {
		if (value == null) {
			value = "";
		}
		value = "\"" + value.replaceAll("\"", "\"\"") + "\"" + (isNewLine ? "\r\n" : ",");
		return value;
	}
	
	private String makeCsvStatus(int status, int finishedFlag) {
		String key = null;
		switch(status) {
		case 0:
			key = "labels.nursing.status.undo";
			break;
		case 1:
			key = "labels.nursing.status.finish";
			break;
		case 2:
			key = "labels.nursing.status.finish.update";
			break;
		case 3:
			key = "labels.nursing.status.today.order";
			break;
		case 4:
			key = "labels.nursing.status.order";
			break;
		case 5:
			key = "labels.nursing.status.approve";
			break;
		case 6:
			key = "labels.nursing.status.cancel";
			break;
		case 7:
			key = "labels.nursing.status.carryout";
			break;
		case 8:
			key = "labels.nursing.status.finish.new";
			break;
		}
		
		String result = "";
		
		if (key != null) {
			result = getText(key);
		}
		
		if (finishedFlag == 1 && (status == 1 || status == 2 || status == 8)) {
			result = result + "●";
		}
		
		return result;
	}

	@Override
	public Nursing getModel() {
		// TODO Auto-generated method stub
		return nursing;
	}

}
