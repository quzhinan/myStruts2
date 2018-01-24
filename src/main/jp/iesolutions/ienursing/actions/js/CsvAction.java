package jp.iesolutions.ienursing.actions.js;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import jp.iesolutions.ienursing.actions.AbstractAction;
import jp.iesolutions.ienursing.models.Office;
import jp.iesolutions.ienursing.models.User;
import jp.iesolutions.ienursing.services.CustomerService;
import jp.iesolutions.ienursing.services.NursingService;
import jp.iesolutions.ienursing.services.OfficeService;
import jp.iesolutions.ienursing.services.ServiceService;
import jp.iesolutions.ienursing.services.UserService;
import jp.iesolutions.ienursing.services.exceptions.CSVInvalidException;

@ParentPackage("ies-json-default")
@Results({
		@Result(name = CsvAction.SUCCESS, type = "json", params = { "contentType", "text/html", "includeProperties",
				"result, message", "excludeProperties", "" }),
		@Result(name = CsvAction.INPUT, type = "json", params = { "contentType", "text/html", "includeProperties",
				"result, message", "excludeProperties", "" }) })
public class CsvAction extends AbstractAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3555154779827672252L;
	private final Log apLog = LogFactory.getLog("apLog");
	private static final String CSV_FILE_SUFFIX = ".wtf";
	private static final Log log = LogFactory.getLog(CsvAction.class);

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

	private File csvFile;
	private String csvName;
	private int tableIdentifier;
	private String csvYM;
	private String startDay;

	public void setCsvFile(File csvFile) {
		this.csvFile = csvFile;
	}

	public void setCsvName(String csvName) {
		this.csvName = csvName;
	}

	public void setTableIdentifier(int tableIdentifier) {
		this.tableIdentifier = tableIdentifier;
	}

	public void setCsvYM(String csvYM) {
		this.csvYM = csvYM;
	}
	
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}

	public void validate() {

	}

	private String result;
	private String message;

	@JSON(name = "result")
	public String getResult() {
		return result;
	}

	@JSON(name = "message")
	public String getMessage() {
		return message;
	}

	@Override
	public String execute() {

		log.info(userActionStart(log,"execute","csvName",csvName,"tableIdentifier",tableIdentifier,"startDay",this.startDay));
		
		String nowPathString = this.csvFile.getPath();
		User user = getUserFromSession();
		String officeCode = user.getOfficeCode() != null & user.getOfficeCode().length() > 1 ? user.getOfficeCode()
				: "administrator";
		String fileNameErrorMessage = getText("errors.file.name.error");

		if (csvName != null && csvName.length() > 0) {
			apLog.info("Start import csv!");
			if (nowPathString == null || nowPathString.isEmpty()) {
				log.info(userActionEnd(log,"execute",INPUT));
				return INPUT;
			}
			try {
				switch (tableIdentifier) {
				case 0:
					try {
						if (!csvName.substring(0, 9).toLowerCase().equals("all_kihon")|| csvName.split("_")[2].length() != 14 || !csvName.split("_")[2].toLowerCase().endsWith(CSV_FILE_SUFFIX)) throw new CSVInvalidException(fileNameErrorMessage, apLog);
					} catch (Exception e) {
						throw new CSVInvalidException(fileNameErrorMessage, apLog);
					}
					apLog.info("Import 利用者 csv!");
					message = customerService.importCSV(nowPathString, officeCode);
					break;
				case 1:
					try {
						if (!csvName.substring(0, 11).toLowerCase().equals("all_syokuin") || csvName.split("_")[2].length() != 14 || !csvName.split("_")[2].toLowerCase().endsWith(CSV_FILE_SUFFIX)) throw new CSVInvalidException(fileNameErrorMessage, apLog);
					} catch (Exception e) {
						throw new CSVInvalidException(fileNameErrorMessage, apLog);
					}
					apLog.info("Import 職員 csv!");
					message = userService.importCSV(nowPathString, officeCode);
					break;
				case 2:
					shiftJSToUtf8(nowPathString);
					apLog.info("Import 事業所 csv!");
					message = officeService.importCSV(nowPathString, officeCode);
					break;
				case 3:
					if (officeCode.equals("administrator")) {
						result = INPUT;
						message = getText("message.uploadCsv.failed.authority");
						apLog.error(getText("message.uploadCsv.failed.authority"));
						log.info(userActionEnd(log,"execute",INPUT));
						return result;
					}

					shiftJSToUtf8(nowPathString);
					if (this.startDay == null || this.startDay.length() == 0) {
						this.startDay = "0";
					}
					// office_codeを取得
					String firstAlpha = "";
					String office_code = "";
					String service_type = "";
					String YM = "";
					try {
						firstAlpha = csvName.substring(0, 1);
						office_code = csvName.split("_")[5];
						service_type = csvName.split("_")[4];
						YM = csvName.split("_")[0].substring(1, 7);
					} catch (Exception e) {
						throw new CSVInvalidException(fileNameErrorMessage, apLog);
					}
					if (!firstAlpha.equals("P")) throw new CSVInvalidException("ファイル名の形式に誤りがあります。", apLog);
					
					if (!office_code.equals(officeCode)) throw new CSVInvalidException("ファイル名の事業所とログインユーザの事業所が異なるか、ファイルの形式に誤りがあります。", apLog);
					
					if (!YM.equals(this.csvYM)) throw new CSVInvalidException("ファイル名の計画年月と画面の選択年月が異なります。", apLog);

					Office office = officeService.findByProperty("officeCode", officeCode);
					apLog.info("Import 提供票 csv!");
					message = nursingService.importCSV(nowPathString, office, YM + startDay, officeCode, service_type);
					break;
				case 4:
					shiftJSToUtf8(nowPathString);
					apLog.error("Import サービス csv!");
					message = serviceService.importCSV(nowPathString, officeCode);
					break;
				default:
					break;
				}

			} catch (Exception e) {
				e.printStackTrace();
				result = INPUT;
				message = getText("message.uploadCsv.failed") + e.getMessage();
				apLog.error(getText("message.uploadCsv.failed"));
				log.info(userActionEnd(log,"execute",INPUT,"result",result,"message",message));
				return INPUT;
			} finally {
			}
		}
		message += "<br><br>一括取込は正常に終了しました。";
		apLog.info("　　　　一括取込は正常に終了しました。");
		result = SUCCESS;
		
		log.info(userActionEnd(log,"execute",INPUT,"result",result,"message",message));
		
		return result;
	}

	private void shiftJSToUtf8(String fileName) {
		String from = fileName;
		String to = fileName + "__";
		File fromFile = new File(from);
		File toFile = new File(to);

		InputStreamReader reader = null;
		OutputStreamWriter writer = null;
		try {
			toFile.createNewFile();
			reader = new InputStreamReader(new FileInputStream(fromFile), "MS932");
			writer = new OutputStreamWriter(new FileOutputStream(toFile), "UTF-8");
			int num = -1;
			char c[] = new char[1024];
			while ((num = reader.read(c)) != -1) {
				writer.write(new String(c, 0, num));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (reader != null) {
					reader.close();
				}
				if (writer != null) {
					writer.flush();
					writer.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		fromFile.delete();
		toFile.renameTo(fromFile);
	}
}
