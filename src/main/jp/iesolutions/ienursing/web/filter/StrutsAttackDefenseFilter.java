package jp.iesolutions.ienursing.web.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class StrutsAttackDefenseFilter implements Filter {

	static Log log = LogFactory.getLog(StrutsAttackDefenseFilter.class);
	
	private static Pattern EXLUDE_PARAMS = Pattern.compile("(^|\\W)[cC]lass\\W");
	
	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)arg0;
		HttpServletResponse res = (HttpServletResponse) arg1;

		if(fixAttack(req,res)) {
			return;
		}

		chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

	private boolean fixAttack(HttpServletRequest httpreq,HttpServletResponse httpresp) throws IOException {

		Enumeration<?> params = httpreq.getParameterNames();
		while (params.hasMoreElements()) {
			String paramName = (String) params.nextElement();
			if (isAttack(paramName)) {
				log.error("Attack with param: "  + paramName);
				httpresp.getWriter().println("<font style='color:red;'>our application is under the attack</font>");
				return true;
			}
		}
		Cookie[] cookies = httpreq.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				String cookieName = c.getName();
				if (isAttack(cookieName)) {
					log.error("Attack with param: "  + cookieName);
					httpresp.getWriter().println("<font style='color:red;'>our application is under the attack</font>");
					return true;
				}
			}
		}

		return false;
	}

	private boolean isAttack(String target) {
		return EXLUDE_PARAMS.matcher(target).find();
	}
}
