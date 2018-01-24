package jp.iesolutions.ienursing.batch;

import java.io.File;

import jp.iesolutions.ienursing.util.HttpClientUtil;
import jp.iesolutions.ienursing.util.PropertiesUtil;

public class ExportNursingJob {

	// private static final Log log = LogFactory.getLog(ExportNursingJob.class);
	//private static final Log log = LogFactory.getLog("exportLog");

	//private static final String jobName = "介護記録長期間保管ジョブ：　";

	public static void main(String[] args) {
		String nurisngExportDir = PropertiesUtil.getPropertiesValue("nursing.export.dir");
		File file = new File(nurisngExportDir + File.separator + "tempExporting");
		if (file.exists()) {
			System.out.println("多重起動は不可！");
			//log.error("多重起動は不可！");
		} else {
			try {
				// log.info(jobName + "処理開始！>>>>>>>>>>");
				file.createNewFile();
				String accessUrl = PropertiesUtil.getPropertiesValue("nursing.export.server.url")
						+ "ienursing2/welcome!exportNursings.ies";
				HttpClientUtil.httpRequest(accessUrl, null);
				// log.info(jobName + "処理終了（正常）！<<<<<<<<<<\n\n");

			} catch (Exception e) {
				// log.error(e, e);
				// log.error(jobName + "処理終了（異常）！<<<<<<<<<<\n\n");
				System.exit(1);
			} finally {
				file.delete();
				System.exit(0);
			}
		}
	}
}
