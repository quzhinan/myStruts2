package jp.iesolutions.ienursing.web.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import jp.iesolutions.ienursing.services.UserService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;


public class UserSessionListener implements HttpSessionListener {

	private static final Log log = LogFactory.getLog(UserSessionListener.class);
	
	private UserService userService;
	
	public void sessionCreated(HttpSessionEvent event) {
		// Do nothing
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		/*
		HttpSession session = event.getSession();
		getServiceBean(session);
		User user = (User)session.getAttribute(AuthenticateUtil.SESSION_USER);
		if (user != null && StringUtils.isEmpty(user.getLoginDeviceUDID()) == false) {
			try {
				userService.logoutFromDevice(user.getId());
			} catch (ServiceException e) {
				log.error(e);
			}
		}
		*/
	}

	
	private void getServiceBean(HttpSession session) {
		if (userService == null) {
			ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(session.getServletContext());
			userService = (UserService)context.getBean("userService");
		}
	}
}
