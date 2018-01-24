package com.qzn.struts.pdf;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

public class FileGeneratorHelper {

	protected static Log log = LogFactory.getLog(FileGeneratorHelper.class);

	public static void setResponseHeader(HttpServletResponse response, String fileName, int fileSize) throws UnsupportedEncodingException {

		response.reset();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain");

		String agent = ServletActionContext.getRequest().getHeader("User-Agent");
		String downloadFileName = "";
		if (agent == null) {
			downloadFileName = "attachment;filename=\"" + fileName + "\"";
		} else {
			agent = agent.toLowerCase();
			if (agent.indexOf("msie") > -1 || agent.indexOf("trident") > -1) {
				downloadFileName = "attachment;filename=\""
						+ URLEncoder.encode(fileName, "UTF-8").replace("+", "%20") + "\"";
			} else if (agent.indexOf("safari") > -1 || agent.indexOf("opera") > -1) {
				downloadFileName = "attachment;filename=\""
						+ new String(fileName.getBytes("UTF-8"), "ISO8859-1") + "\"";
			} else {
				// RFC2231.

				boolean isAfterFirefox7 = false;

				if (agent.indexOf("firefox") > -1) {

					int index = agent.indexOf(".", agent.indexOf("firefox/"));

					if (index > 0) {

						String version = agent.substring(index - 1, index);

						try {

							if (Integer.parseInt(version) > 7)
								isAfterFirefox7 = true;

						} catch (Exception ex) {

							log.error(ex);
						}
					}
				}

				downloadFileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");
				downloadFileName = isAfterFirefox7 ? "attachment;filename*=utf8''" + downloadFileName
						: "attachment;filename*=\"utf8''" + downloadFileName + "\"";
			}
		}
		response.setHeader("Content-Disposition", downloadFileName);
		response.setHeader("Content-Length", String.valueOf(fileSize));

	}
}
