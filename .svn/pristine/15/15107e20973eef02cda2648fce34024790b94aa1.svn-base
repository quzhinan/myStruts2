<!DOCTYPE html PUBLIC 
    "-//W3C//DTD XHTML 1.1 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <link rel="shortcut icon" href="images/icon.png" >
    <title>エラー - TPO管理システム</title>
    <link type="text/css" href="./styles/layout-main.css" rel="stylesheet" media="all"/>
    <script src="/iemeeting/struts/utils.js" type="text/javascript"></script>
</head>
<body>
<div id="page-main" align="center">
	<h1><s:text name="errors.common.title"/></h1>
	<hr/>
	<p>
	    <FONT color="red">
			<!-- <s:property value="#parameters.type"/> -->
			<s:set name="type" value="#parameters.type[0]"/>
			<!-- <s:property value="#type" /> -->
			<s:if test="#type==1">
				<s:text name="errors.common.session.timeout"/>
			</s:if>
		</FONT>
	</p>
	<br/>
	<br/>
	<br/>
	<div id="button-box" align="center">
		<a href="<s:url value='/logout.ies'/>">
			<s:text name="errors.common.goto.login"/>
		</a>
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
   			<td>
   				<table width="100%" border="0" cellSpacing="0" cellPadding="0">
	   				<tr>
	   					<!--
	   					<td class="main-footer-system-alias">
			   				<img src="./images/logo-footer.png" class="logo-footer" />
		   				</td>
		   				-->
		   				<td class="main-footer-copyright">
			   				<s:text name="labels.Coryright"/>
		   				</td>
		   				<td class="main-footer-copyright">
			   				<s:text name="labels.version"/>
		   				</td>
	   				</tr>
   				</table>
   			</td>
		</tr>
	</table>
</div>
</body>
</html>

