<!DOCTYPE html PUBLIC 
    "-//W3C//DTD XHTML 1.1 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%response.setStatus(HttpServletResponse.SC_OK);%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <link rel="shortcut icon" href="images/icon.png" >
    <title>エラー - 介護システム</title>
    <link type="text/css" href="./styles/layout-main.css" rel="stylesheet" media="all"/>
    <script src="/iemeeting/struts/utils.js" type="text/javascript"></script>
</head>
<body>
<div id="page-main" align="center">
	<h1>エラーメッセージ</h1>
	<hr/>
	<p>
	<%if (exception != null && exception.getMessage() != null && exception.getMessage().equals("token.error")) {%>
	    <FONT color="red">不正なアクセス。</FONT>
	<%} else {%>
	    <FONT color="red">URLが存在しません。</FONT>
	<%}%>
	</p>
	<br/>
	<br/>
	<br/>
	<div id="button-box" align="center">
		<%if (exception != null && exception.getMessage() != null && exception.getMessage().equals("token.error")) {%>
			<a href="javascript:void(0);" onclick="javascript:history.back();"> 戻る </a>
			<br/><br/>
			<a href="logout.ies"> ＞＞ ログイン画面へ </a>
		<%} else {%>
			<a href="logout.ies"> ＞＞ ログイン画面へ </a>
		<%}%>
	</div>
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	<table width="100%" class="main-content-box" border="0" cellSpacing="0" cellPadding="0">
		<tr>
			<td class="main-footer-line"></td>
		</tr>
		<tr>
			<td class="main-footer-copyright">
				<table width="100%" border="0" cellSpacing="0" cellPadding="0">
	   				<tr>
	   					<!--
	   					<td class="main-footer-system-alias">
			   				<img src="./images/logo-footer.png" class="logo-footer" />
		   				</td>
		   				-->
		   				<td class="main-footer-copyright">
							Copyright (c) Information Environment Solutions Co., LTD. All Rights Reserved.
		   				</td>
		   				<td class="main-footer-copyright">
			   				システムバージョン：1.1
		   				</td>
	   				</tr>
   				</table>
			</td>
		</tr>
	</table>
</div>
</body>
</html>

