package com.qzn.struts.web.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class TokenFilter implements Filter {
	static Log log = LogFactory.getLog(TokenFilter.class);
	
	List<String> ignoreList = new ArrayList<String>();

	public void destroy() {

	}
	
	public static String SESSINO_KEY_TOKEN = "ietoken";

	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse res = (HttpServletResponse) arg1;
		String uri = req.getRequestURI();
		
		log.debug(uri);
		
		if (!isIgnored(uri)) {
			String prevToken = (String)req.getSession().getAttribute(SESSINO_KEY_TOKEN);
			if (prevToken != null) {
				String clientToken = req.getParameter(SESSINO_KEY_TOKEN);
				if (clientToken == null || !clientToken.equals(prevToken)) {
					log.info("token error : " + req.getRequestURI());
					throw new TokenException();
				}
			}

			String newToken = UUID.randomUUID().toString() + "-" + (int)(1000+Math.random()*(9999-1000+1));
			newToken = newToken.replaceAll("-", "");
			Cookie tokenCookie = new Cookie(SESSINO_KEY_TOKEN, newToken);
			tokenCookie.setPath("" + req.getContextPath() + "/");
			tokenCookie.setMaxAge(3600);
//			tokenCookie.setSecure(true);
//			String scheme = req.getScheme();
//			if (scheme != null && scheme.toLowerCase().equals("https")) {
//				tokenCookie.setSecure(true);
//			}
			res.addCookie(tokenCookie);
			req.getSession().setAttribute(SESSINO_KEY_TOKEN, newToken);
			
		}
		chain.doFilter(req, res);
	}

	public void init(FilterConfig config) throws ServletException {
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
}
