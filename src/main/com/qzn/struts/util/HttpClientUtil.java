package com.qzn.struts.util;

import java.io.IOException;
import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class HttpClientUtil {

	private static final Log log = LogFactory.getLog(HttpClientUtil.class);

	/**
	 * httpリクエスト
	 * 
	 * @param url
	 *            リクエスト先
	 * @param paramList
	 *            パラメータリスト
	 * @return
	 * @throws IOException
	 * @throws HttpException
	 */
	public static String httpRequest(String url, List<NameValuePair> paramList) throws Exception {

		// HTTPのPOSTメソッド
		PostMethod httppost = new PostMethod(url);
		// httpclientの⽣成
		HttpClient httpclient = new HttpClient();

		try {
			// POSTデータ形式の指定
			httppost.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
			httppost.setRequestHeader("Connection", "close");

			// パラメータ設定する
			if (paramList != null) {
				for (NameValuePair nameValue : paramList) {
					httppost.addParameter(nameValue);
				}
			}

			log.info("HTTPリクエスト先URL:" + url);

			// HTTPステータスコードを取得
			int statusCode = httpclient.executeMethod(httppost);

			// ログ出力
			log.info(httppost.getStatusLine());

			// リクエスト取得異常時
			if (statusCode != HttpStatus.SC_OK) {
				log.error("HTTPリクエストに失敗しました。STATUS=" + statusCode);
			} else {
				byte[] responseBody = httppost.getResponseBody();

				return new String(responseBody);
			}
			return null;
		} catch (Exception ex) {
			throw ex;
		} finally {
			httppost.releaseConnection();
		}

	}
}
