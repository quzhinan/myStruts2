package jp.iesolutions.ienursing.web.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import jp.iesolutions.ienursing.util.AuthenticateUtil;

public class LoginFilter implements Filter {
	static Log log = LogFactory.getLog(LoginFilter.class);

	private String indexPath;
	List<String> ignoreList = new ArrayList<String>();

	public void destroy() {

	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse res = (HttpServletResponse) arg1;
		String method = req.getMethod();
		res.setHeader("Content-Security-Policy",
				"default-src 'self';script-src 'self' 'unsafe-inline' 'unsafe-eval';style-src 'self' 'unsafe-inline' 'unsafe-eval'");
		String uri = req.getRequestURI();
		log.debug(uri);
		if (log.isDebugEnabled() || method.equals("GET")) {
			Enumeration en = req.getParameterNames();
			while (en.hasMoreElements()) {
				String name = (String) en.nextElement();
				String[] values = req.getParameterValues(name);
				if (values != null) {
					for (int i = 0; i < values.length; i++) {
						String nowValue = values[i];
						if (checkIllegalParam(nowValue)) {
							res.sendRedirect(req.getContextPath() + "/error.jsp");
						}
						log.debug(name + " : " + nowValue);
					}
				}
			}
		}
		if (req.getSession().getAttribute(AuthenticateUtil.SESSION_USER) != null || isIgnored(uri)) {

			if (req.getParameter("menuid") != null) {

				try {

					int menuId = Integer.parseInt(req.getParameter("menuid"));

					req.getSession().setAttribute("menuid", menuId);

				} catch (NumberFormatException e) {
					e.printStackTrace();
					log.error(e.getStackTrace());
					res.sendRedirect(req.getContextPath() + "/error-404.jsp");
				}
			}

			chain.doFilter(req, res);
		} else {
			log.warn("Not yet authenticated, The request uri is [" + uri + "].");

			String cookie = req.getHeader("cookie");
			if (StringUtils.isEmpty(cookie) == false && cookie.indexOf("JSESSIONID=") > -1) {
				res.sendRedirect(req.getContextPath() + "/error-common.jsp?type=1");
			} else {
				res.sendRedirect(req.getContextPath() + indexPath);
			}

			log.warn("We will redirct to [" + indexPath + "]");
		}
	}

	public void init(FilterConfig config) throws ServletException {
		indexPath = config.getInitParameter("indexPath");
		ignoreList = Arrays.asList(config.getInitParameter("ignoreList").split(","));
	}

	private boolean isIgnored(String uri) {
		for (String ignore : ignoreList) {
			if (StringUtils.contains(uri, ignore)) {
				return true;
			}
		}
		return false;
	}

	private boolean checkIllegalParam(String value) {
		List<String> strings = new ArrayList<String>();
		strings.add("script");
		strings.add("onclick");
		strings.add("post");
		strings.add("ajax");
		strings.add("alert");
		boolean existIllegal = false;
		for (int i = 0; i < strings.size(); i++) {
			if (value.toLowerCase().indexOf(strings.get(i)) >= 0) {
				existIllegal = true;
				break;
			}
		}
		return existIllegal;
	}
}
