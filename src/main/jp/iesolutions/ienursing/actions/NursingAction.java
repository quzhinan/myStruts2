package jp.iesolutions.ienursing.actions;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jp.iesolutions.ienursing.data.helper.MasterHelper;
import jp.iesolutions.ienursing.models.Customer;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Nursing;
import jp.iesolutions.ienursing.models.Service;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.models.YearMonth;
import jp.iesolutions.ienursing.pdf.FileGeneratorHelper;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = NursingAction.INPUT, location = "nursing-edit.jsp"),
		@Result(name = "nursingCalendar", location = "nursing-calendar.ies?${ietoken}", type = "redirect"),
		@Result(name = "nursingList", location = "nursing-list!search.ies?${ietoken}", type = "redirect"),
		@Result(name = "schedule", location = "schedule.ies?${ietoken}", type = "redirect"),
		@Result(name = "plan", location = "plan.ies?${ietoken}", type = "redirect") })
public class NursingAction extends AbstractPageAction<Nursing> implements ModelDriven<Nursing>, Preparable {

	private static final long serialVersionUID = -141393821277805804L;

	private static final Log log = LogFactory.getLog(NursingAction.class);

	public final Boolean SHOW_ADD_MAIN_TITLE = true;
	
	@Autowired
	private NursingService nursingService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private UserService userService;

	@Autowired
	private ServiceService serviceService;

	private List<Service> services;

	public List<Service> getServices() {
		return services;
	}

	private Nursing nursing;

	private int listType;

	public int getListType() {
		return listType;
	}

	public void setListType(int listType) {
		this.listType = listType;
	}

	private List<Customer> customerList;

	private List<User> userList;

	public List<Customer> getCustomerList() {
		return customerList;
	}

	public void setCustomerList(List<Customer> customerList) {
		this.customerList = customerList;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	private Long id;

	@Override
	public Nursing getModel() {
		return nursing;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	private String defaultYM;
	private List<YearMonth> yearMonths;

	public String getDefaultYM() {
		return defaultYM;
	}

	public List<YearMonth> getYearMonths() {
		return yearMonths;
	}

	@Override
	public void prepare() throws Exception {
		User user = getUserFromSession();
		log.info(userActionStart(log, "prepare", "user", user));
		if (listType == 0) {
			listType = getListTypeFromSession();
		} else {
			setListTypeToSession(listType);
		}
		String sessionUserOfficeCode = user.getOfficeCode();
		Map<Object, Object> maps = new HashMap<Object, Object>();
		
		if (sessionUserOfficeCode != null && sessionUserOfficeCode.length() > 0) {
			maps.put("officeCode", sessionUserOfficeCode);
		}

		if (nursing == null && id != null && id.longValue() != 0) {
			userList = userService.loadAllUserByUser(user, false, 1);
			nursing = nursingService.findById(id);
			if (nursing != null) {

				if(!StringUtils.isEmpty(nursing.getUserCode())){
					User usingUse = userService.findByProperty("userCode", nursing.getUserCode());
					if(usingUse != null && usingUse.getActive() == 0) {
						userList.add(0, usingUse);
					}
				}

				if(!StringUtils.isEmpty(nursing.getUserCodeFollow())) {
					User usingUseFollow = userService.findByProperty("userCode", nursing.getUserCodeFollow());
					if(usingUseFollow != null && usingUseFollow.getActive() == 0) {
						userList.add(0, usingUseFollow);
					}
				}
			}
		} else {
			maps.put("active", "1");
			userList = userService.loadAllUserByUser(user, false, 1);
			nursing = new Nursing();
			nursing.setTodayStateSweat(0);
			nursing.setTodayStateAppetite(1);
			nursing.setTodayStateSleep(1);
			nursing.setTodayStateColor(1);
		}
		customerList = customerService.getListByProperty(maps, "customerNameKana, customerName");
		services = serviceService.loadAllProperService(sessionUserOfficeCode);

		if (nursing.getServiceCode() != null && nursing.getServiceCode().length() > 0) {
			Service service = serviceService.findById(nursing.getServiceCode());
			if (service != null && service.getActive() == 0) {
				services.add(0, service);
			}
		}
		yearMonths = getRecentlyMonths(false);
		if (nursing.getVisitDate() != null && nursing.getVisitDate().length() == 10) {
			defaultYM = nursing.getVisitDate().substring(0, 4) + nursing.getVisitDate().substring(5, 7);
		}
		log.info(userActionEnd(log, "prepare", SUCCESS, "customerList", customerList, "userList", userList, "nursing",
				nursing));

	}

	public String execute() throws Exception {
		return "";
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

	public Long getPreviousId() {
		List<Long> ids = getIdList();
		int nowIndex = ids.indexOf(id);
		int resultIndex = 0;
		if (nowIndex != 0) {
			resultIndex = nowIndex - 1;
		}
		return ids.get(resultIndex);
	}

	public Long getNextId() {
		List<Long> ids = getIdList();
		int nowIndex = ids.indexOf(id);
		int resultIndex = ids.size() - 1;
		if (nowIndex != ids.size() - 1) {
			resultIndex = nowIndex + 1;
		}
		return ids.get(resultIndex);
	}

	private List<Long> getIdList() {
		List<Nursing> nursingList = getNursingListFromSession();
		List<Long> ids = new ArrayList<Long>();
		for (int i = 0; i < nursingList.size(); i++) {
			Nursing nursing = nursingList.get(i);
			ids.add(nursing.getId());
		}
		return ids;
	}

	public String save() throws Exception {

		log.info(userActionStart(log, "save", "customerCode", nursing.getCustomerCode(), "userCode",
				nursing.getUserCode()));

		try {
			Customer customer = customerService.findByProperty("customerCode", nursing.getCustomerCode());
			if (customer != null) {
				nursing.setUserCodeService(customer.getUserCode());
			}

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String date = dateFormat.format(new Date());
			User user = userService.findByProperty("userCode", nursing.getUserCode());
			if (user != null) {
				nursing.setOfficeCode(user.getOfficeCode());
			} else {
				nursing.setOfficeCode("");
			}

			if (date.equals(nursing.getVisitDate())) {
				nursing.setStatus(3);
			} else {
				nursing.setStatus(4);
			}
			
			String strNursingRecord = nursing.getNursingRecord().replaceAll("\r\n", "\n");
			String strOfficeRecord = nursing.getOfficeRecord().replaceAll("\r\n", "\n");
			nursing.setNursingRecord(strNursingRecord);
			nursing.setOfficeRecord(strOfficeRecord);
			
			// Modify for Comment - start
			if (StringUtils.isEmpty(nursing.getCommentContent())) {
				nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_NONE);
			} else  {
				nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_UNCONFIRMED);
			}
			nursing.setCommentUpdateDatetime(new Date());
			// Modify for Comment - end
			
			if (nursing.getId() == 0L) {
				nursing.setNewFlag(1);
				if (!MasterHelper.isBeforeServiceTime(nursing.getVisitDate(), nursing.getFromTime())) {
					nursing.setStatus(8);
				}
			}
			
			nursingService.save(nursing);
		} catch (Exception e) {
			printLog(log, e);
			throw new Exception("save data error.");
		}

		if (listType == 1) {
			log.info(userActionEnd(log, "save", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "save", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "save", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "save", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public String update() throws Exception {

		log.info(userActionStart(log, "update"));

		if (nursing.getStatus() == 3 || nursing.getStatus() == 4) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String date = dateFormat.format(new Date());

			if (date.equals(nursing.getVisitDate())) {
				nursing.setStatus(3);
			} else {
				nursing.setStatus(4);
			}
		}

		try {
			String strNursingRecord = nursing.getNursingRecord().replaceAll("\r\n", "\n");
			String strOfficeRecord = nursing.getOfficeRecord().replaceAll("\r\n", "\n");
			nursing.setNursingRecord(strNursingRecord);
			nursing.setOfficeRecord(strOfficeRecord);
			
			// Modify for Comment - start
			Nursing oldNursing = nursingService.findById(id);
			if (StringUtils.isEmpty(nursing.getCommentContent())) {
				nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_NONE);
			} else if (!nursing.getCommentContent().equals(oldNursing.getCommentContent())) {
				nursing.setCommentConfirmStatus(EventItem.COMMENT_STATUS_UNCONFIRMED);
			} else {
				nursing.setCommentConfirmStatus(oldNursing.getCommentConfirmStatus());
			}
			nursing.setCommentUpdateDatetime(new Date());
			// Modify for Comment - end
			
			nursingService.update(nursing);
		} catch (Exception e) {
			printLog(log, e);
			throw new Exception("save data error.");
		}
		if (listType == 1) {
			log.info(userActionEnd(log, "update", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "update", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "update", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "update", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public String approve() throws Exception {

		log.info(userActionStart(log, "approve", "id", id));
		try {
			if (id != null && id != 0L) {
				nursing.setStatus(5);
				nursingService.update(nursing);
			}
		} catch (Exception e) {
			printLog(log, e);
			throw new Exception("save data error.");
		}
		if (listType == 1) {
			log.info(userActionEnd(log, "approve", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "approve", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "approve", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "approve", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public String cancelNursing() throws Exception {

		log.info(userActionStart(log, "cancelNursing", "id", id));
		try {
			if (id != null && id != 0L) {
				nursingService.cancelNursing(nursing.getEventId(), true);
			}
		} catch (Exception e) {
			printLog(log, e);
			throw new Exception("save data error.");
		}
		if (listType == 1) {
			log.info(userActionEnd(log, "cancelNursing", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "cancelNursing", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "cancelNursing", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "cancelNursing", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public String delete() throws Exception {

		log.info(userActionStart(log, "delete", "id", id));

		try {
			nursingService.deleteById(id);
		} catch (Exception e) {
			printLog(log, e);
			throw new Exception("save data error.");
		}

		if (listType == 1) {
			log.info(userActionEnd(log, "delete", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "delete", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "delete", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "delete", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public String cancel() throws Exception {
		log.info(userActionStart(log, "cancel"));
		if (listType == 1) {
			log.info(userActionEnd(log, "cancel", "nursingCalendar", "listType", listType));
			return "nursingCalendar";
		} else if (listType == 2) {
			log.info(userActionEnd(log, "cancel", "nursingList", "listType", listType));
			return "nursingList";
		} else if (listType == 3) {
			log.info(userActionEnd(log, "cancel", "schedule", "listType", listType));
			return "schedule";
		} else if (listType == 4) {
			log.info(userActionEnd(log, "cancel", "plan", "listType", listType));
			return "plan";
		}
		return null;
	}

	public Boolean showManageItems() {
		log.info(userActionStart(log, "showManageItems"));
		log.info(userActionEnd(log, "showManageItems", SUCCESS));
		return true;
	}

	/**
	 * 下载录音和图片文件
	 */

	public String downloadRecordPhotos() throws Exception {
		String fileName = nursing.getId() + "_nursing_file_" + nursing.getCustomerCode() + ".zip";
		String filePath = nursingService.getUserCodeDirPath(fileName) + File.separator + fileName;
		
		//找到需要解压到zip文件
		File zipFile = new File(filePath);
		//解压到的临时目录
		String tempFilePath = nursingService.getUserCodeDirPath(null) + File.separator + "temp" + File.separator + "files";
		//新的zip文件名字
		String zipFileName = nursingService.getUserCodeDirPath(null) + File.separator + "temp" + File.separator + nursing.getId() + "_nursing_file_" + nursing.getCustomerCode() + "_n.zip";
		//将临时文件及文件夹删除
		File tempFile = new File(tempFilePath);
		
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		OutputStream os = null;
		BufferedOutputStream bos = null;
		
		try {
			//解压原zip
			unZip(zipFile, tempFilePath, nursingService.getZipPassword());
			//压缩新zip
			zip(tempFilePath, zipFileName, true, null);
			//删除临时文件
			File[] files = tempFile.listFiles();
			for(int i=0; i<files.length; i++){
	               files[i].delete();
	        }
			tempFile.delete();
			
			HttpServletResponse response = ServletActionContext.getResponse();
			fis = new FileInputStream(zipFileName);
			bis = new BufferedInputStream(fis);
			os = response.getOutputStream();
			bos = new BufferedOutputStream(os);
			
			FileGeneratorHelper.setResponseHeader(response, fileName, bis.available());
			
			int bytesRead = 0;
			byte[] buffer = new byte[1024];
			while ((bytesRead = bis.read(buffer)) != -1) {
				bos.write(buffer, 0, bytesRead);
			}

			bos.flush();
		} catch (FileNotFoundException e) {
			printLog(log, e);
		} finally {
			if (bos != null) try { bos.close(); } catch (IOException e) { printLog(log, e);}
			if (bis != null) try { bis.close(); } catch (IOException e) { printLog(log, e);}
			if (os != null) try { os.close(); } catch (IOException e) { printLog(log, e);}
			if (fis != null) try { fis.close(); } catch (IOException e) { printLog(log, e);}
		}
		
		File newZipFile = new File(zipFileName);
		
		if (newZipFile.isFile() && newZipFile.exists()) {
			newZipFile.delete();
		}
		
		return null;
	}
	
	public boolean getExistVoiceAndPhoto() {
		String fileName = nursing.getId() + "_nursing_file_" + nursing.getCustomerCode() + ".zip";
		String filePath = nursingService.getUserCodeDirPath(fileName) + File.separator + fileName;
		File file = new File(filePath);
		return file.exists();
	}
	
	/**
      * 解压加密的压缩文件
      * @param zipfile
      * @param dest
      * @param passwd
      * @throws ZipException
      */
	
	public void unZip(File zipfile,String dest,String passwd) throws ZipException{
         ZipFile zfile=new ZipFile(zipfile);
//        zfile.setFileNameCharset("GBK");//在GBK系统中需要设置
         if(!zfile.isValidZipFile()){
             throw new ZipException("Compressed files are not legal and may have been damaged!");
         }
         File file=new File(dest);
         if(file.isDirectory() && !file.exists()){
             file.mkdirs();
         }
         if(zfile.isEncrypted()){
             zfile.setPassword(passwd.toCharArray());
         }
         zfile.extractAll(dest);
     }
	
	/**
      * 压缩文件且加密
      * @param src
      * @param dest
      * @param is
      * @param passwd
      */
     public void zip(String src,String dest,boolean is,String passwd){
         File srcfile=new File(src);
         //创建目标文件
         String destname = buildDestFileName(srcfile, dest);
         ZipParameters par=new ZipParameters();
         par.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
         par.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
         if(passwd!=null){
             par.setEncryptFiles(true);
             par.setEncryptionMethod(Zip4jConstants.ENC_METHOD_STANDARD);
             par.setPassword(passwd.toCharArray());
         }
         try {
             ZipFile zipfile=new ZipFile(destname);
             if(srcfile.isDirectory()){
                 if(!is){
                     File[] listFiles = srcfile.listFiles();
                     ArrayList<File> temp=new ArrayList<File>();
                     Collections.addAll(temp, listFiles);
                     zipfile.addFiles(temp, par);
                 }
                 zipfile.addFolder(srcfile, par);
             }else{
                 zipfile.addFile(srcfile, par);
             }
         } catch (ZipException e) {
        	 printLog(log, e);
         }
     }
     
     /**
      * 目标文件名称
      * @param srcfile
      * @param dest
      * @return
      */
     public String buildDestFileName(File srcfile,String dest){
         if(dest==null){//没有给出目标路径时
             if(srcfile.isDirectory()){
                 dest=srcfile.getParent()+File.separator+srcfile.getName()+".zip";
             }else{
                 String filename=srcfile.getName().substring(0,srcfile.getName().lastIndexOf("."));
                 dest=srcfile.getParent()+File.separator+filename+".zip";
             }
         }else{
             createPath(dest);//路径的创建
             if(dest.endsWith(File.separator)){
                 String filename="";
                 if(srcfile.isDirectory()){
                     filename=srcfile.getName();
                 }else{
                     filename=srcfile.getName().substring(0, srcfile.getName().lastIndexOf("."));
                 }
                 dest+=filename+".zip";
             }
         }
         return dest;
     }
     
     /**
      * 路径创建
      * @param dest
      */
     private void createPath(String dest){
         File destDir=null;
         if(dest.endsWith(File.separator)){
             destDir=new File(dest);//给出的是路径时
         }else{
             destDir=new File(dest.substring(0,dest.lastIndexOf(File.separator)));
         }
         if(!destDir.exists()){
             destDir.mkdirs();
         }
     }
}
