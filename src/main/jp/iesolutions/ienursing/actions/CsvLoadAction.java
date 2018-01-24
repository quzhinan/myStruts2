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
import java.util.Date;
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
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;



import jp.iesolutions.ienursing.models.Event;
import jp.iesolutions.ienursing.models.EventItem;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.services.EventService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.util.CSVMaker;
import jp.iesolutions.ienursing.util.ZipCompressor;

@ParentPackage("ies-json-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = {
		@Result(name = "achievementNums", type = "json", params = { "includeProperties", "achievementNums, thisTimeSessionKey" }) })
public class CsvLoadAction extends AbstractAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -194854673947813799L;
	private final Log apLog = LogFactory.getLog("apLog");
	private static final Log log = LogFactory.getLog(CsvLoadAction.class);

	private String fromDay;
	private String toDay;

	@Autowired
	private EventService eventService;

	@Autowired
	private OfficeService officeService;

	@Autowired
	private CSVMaker csvMaker;

	public void setFromDay(String fromDay) {
		this.fromDay = fromDay;
	}

	public void setToDay(String toDay) {
		this.toDay = toDay;
	}

	public String execute() throws Exception {
		log.info(userActionStart(log, "execute"));
		apLog.info("Start export csv!");
		prepareDownload();
		downloadFile();
		log.info(userActionEnd(log, "execute", SUCCESS));
		return null;
	}

	private String downloadFileName;

	public String getDownloadFileName() {
		return downloadFileName;
	}

	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}

	public void downloadFile() throws Exception {
		
		log.info(userActionStart(log, "downloadFile", "fromDay",fromDay,"toDay",toDay));
		
		HttpServletResponse response = ServletActionContext.getResponse();
		session.put("achievementNums", thisTimeSessionKey + ";" + -1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmm");

		String csvFileName = "CR" + getUserFromSession().getOfficeCode() + "_" + simpleDateFormat.format(new Date())
				+ "_30102" + ".WTF";

		Integer[] itemTypes = { EventItem.TYPE_ACHIEVEMENT };
		Integer[] itemStatus = { EventItem.STATUS_COMPLETED_APPROVED };

		// status 2
		Office office = officeService.findByProperty("officeCode", getUserFromSession().getOfficeCode());
		List<Event> events = new ArrayList<Event>();
		if (office != null) {
			try {
				if (fromDay != null && fromDay.length() > 0)
					events = eventService.loadEventsWithItemInDays(office.getId(), itemTypes, fromDay,
							toDay != null && toDay.length() > 0 ? toDay : "999999999", itemStatus);
			} catch (Exception e) {
				apLog.error("　　　　" + e.getStackTrace());
				e.printStackTrace();
			}
		} else {
			apLog.error("　　　　事業所は存在がない！");
		}
		apLog.error("　　　　Generate csv, csv line numbers is " + events.size());
		session.put("achievementNums", thisTimeSessionKey + ";" + events.size());

		Map<String, List<Event>> events99 = new HashMap<String, List<Event>>();
		List<Event> eventsNot99 = new ArrayList<Event>();
		for (int i = 0; i < events.size(); i++) {
			Event event = events.get(i);
			String serviceCode = event.getAchievement().getService().getCode();
			if (serviceCode.startsWith("99")) {
				if (events99.get(serviceCode) == null) {
					List<Event> events99Temp = new ArrayList<Event>();
					//event.getAchievement().getService().setCode(null);
					events99Temp.add(event);
					events99.put(serviceCode, events99Temp);
				} else {
					events99.get(serviceCode).add(event);
				}
			} else {
				eventsNot99.add(event);
			}
		}

		csvMaker.generateCSV(eventsNot99, this.nowCSVPath + "/" + csvFileName);
		for (String key : events99.keySet()) {
			this.generateFolder(this.nowCSVPath + "/" + key);
			csvMaker.generateCSV(events99.get(key), this.nowCSVPath + "/" + key + "/" + csvFileName);
		}

		File file = generateZip(this.nowCSVPath + ".zip");
		if (file != null) {
			FileInputStream fis = null;
			BufferedInputStream bis = null;
			OutputStream os = null;
			BufferedOutputStream bos = null;

			try {
				fis = new FileInputStream(file);
				bis = new BufferedInputStream(fis);

				os = response.getOutputStream();
				bos = new BufferedOutputStream(os);

				response.reset();
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/plain");
				response.setHeader("Content-Disposition", "attachment;filename=" + this.downloadFileName);
				response.setHeader("Content-Length", String.valueOf(bis.available()));

				int bytesRead = 0;

				byte[] buffer = new byte[1024];

				while ((bytesRead = bis.read(buffer)) != -1) {
					bos.write(buffer, 0, bytesRead);
				}

				bos.flush();
				bos.close();
				bos = null;
				bis.close();
				bis = null;
				os.close();
				os = null;
				fis.close();
				fis = null;

				this.removeTempFile(file);

			} catch (FileNotFoundException e) {
				e.printStackTrace();
				apLog.error(e);
			} catch (IOException e) {
				e.printStackTrace();
				apLog.error(e);
			} finally {
				if (bos != null)
					try {
						bos.close();
					} catch (IOException e) {
						printLog(apLog, e);
					}
				if (bis != null)
					try {
						bis.close();
					} catch (IOException e) {
						printLog(apLog, e);
					}
				if (os != null)
					try {
						os.close();
					} catch (IOException e) {
						printLog(apLog, e);
					}
				if (fis != null)
					try {
						fis.close();
					} catch (IOException e) {
						printLog(apLog, e);
					}
			}
		}
		
		log.info(userActionEnd(log, "downloadFile", SUCCESS));
	}

	
	
	private void removeTempFile(File file) {
		log.info(userActionStart(log, "removeTempFile"));
		file.delete();
		log.info(userActionEnd(log, "removeTempFile", SUCCESS));
	}

	String nowCSVPath;

	private void prepareDownload() {
		
		log.info(userActionStart(log, "prepareDownload"));
		
		String string = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss-SS").format(new Date());
		File dirFile = new File(this.csvMaker.getCsvPath());
		if (!dirFile.isDirectory()) {
			dirFile.mkdir();
		}

		int max = 9999;
		int min = 1000;
		Random random = new Random();
		int s = random.nextInt(max) % (max - min + 1) + min;

		// generate worker path
		this.nowCSVPath = csvMaker.getCsvPath() + "/" + string + "-" + s;
		this.downloadFileName = string + "-" + s + ".zip";
		new File(this.nowCSVPath).mkdir();
		
		log.info(userActionEnd(log, "prepareDownload", SUCCESS ,"nowCSVPath",nowCSVPath,"downloadFileName",downloadFileName));
	}

	private void generateFolder(String path) throws Exception {
		File file = new File(path);
		if (!file.exists() || !file.isDirectory()) {
			file.mkdir();
		}
	}

	private String zipFilePath;

	private File generateZip(String zipFilePath) throws Exception {
		
		this.zipFilePath = zipFilePath;
		ZipCompressor zipCompressor = new ZipCompressor();
		zipCompressor.setZipFile(new File(this.zipFilePath));
		zipCompressor.compress(this.nowCSVPath);
		return new File(this.zipFilePath);
	}

	private String achievementNums = "999;-1";

	@JSON(name = "achievementNums")
	public int getAchievementNums() {
		return Integer.parseInt(achievementNums.split(";")[1]);
	}
	
	private int thisTimeSessionKey;
	public void setThisTimeSessionKey(int thisTimeSessionKey) {
		this.thisTimeSessionKey = thisTimeSessionKey;
	}
	
	@JSON(name = "thisTimeSessionKey")
	public int getThisTimeSessionKey() {
		return Integer.parseInt(achievementNums.split(";")[0]);
	}

	public String getNums() {
		achievementNums = (String) session.get("achievementNums");
		return "achievementNums";
	}
}
