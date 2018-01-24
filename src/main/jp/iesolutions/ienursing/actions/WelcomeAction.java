package jp.iesolutions.ienursing.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import jp.iesolutions.ienursing.services.NursingService;

@ParentPackage("ies-webapp-default")
@InterceptorRef(value = "paramsPrepareParamsStack")
@Results(value = { @Result(name = WelcomeAction.SUCCESS, location = "welcome.jsp") })
public class WelcomeAction extends AbstractAction {

	private static final long serialVersionUID = -9188346549650601022L;
	// private final Log log = LogFactory.getLog(WelcomeAction.class);
	private static final Log exportLog = LogFactory.getLog("exportLog");

	@Override
	public String execute() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		session.invalidate();

		return SUCCESS;
	}

	@Autowired
	private NursingService nursingService;
	private static final String jobName = "介護記録長期間保管ジョブ：　";
	public void exportNursings() {
		exportLog.info(jobName + "処理開始！>>>>>>>>>>");
		HttpServletRequest servletRequest = ServletActionContext.getRequest();
		String requestIP = servletRequest.getRemoteAddr();
		if (requestIP.equals("127.0.0.1") || requestIP.equals("localhost")) {
			try {
				nursingService.exportNursings();
				exportLog.info(jobName + "処理終了（正常）！<<<<<<<<<<\n\n");
			} catch (Exception e) {
				exportLog.error(e, e);
				exportLog.error(jobName + "処理終了（異常）！<<<<<<<<<<\n\n");
			}
		} else {
			exportLog.info("Request IP エラー！IPは：　" + requestIP);
		}
	}
}
