<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@taglib prefix="s" uri="/struts-tags" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <link rel="shortcut icon" href="images/icon.png" >
	<title><decorator:title default="Struts Starter"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <link type="text/css" href="<s:url value='/styles/layout-welcome.css'/>" rel="stylesheet" media="all"/>
    <link type="text/css" href="<s:url value='/styles/forms.css'/>" rel="stylesheet" media="all"/>
    <link type="text/css" href="<s:url value='/styles/block.css'/>" rel="stylesheet" media="all"/>
	<script language="JavaScript" type="text/javascript" src="<s:url value='/scripts/common.js'/>"></script>
    <decorator:head/>    
</head>
<body id="page-home">
	<div id="page-main">
    	<table width="980" class="welcome-box" border="0" align="center" cellSpacing="0" cellPadding="0">
    		<tr>
    			<td class="welcome-line" colspan="3" >&nbsp;</td>
    		</tr>
    		<tr>
    			<td rowspan="2" colspan="2" class="welcome-logo">
    				<img src="<s:url value='/images/logo.jpg'/>" border="0"/>
    			</td>
    			<td class="welcome-header" nowrap="nowrap" width="100%">
		    		<s:text name="labels.system.title"/>
    			</td>
    		</tr>
    		<tr>
    			<td class="welcome-menu">&nbsp;</td>
    		</tr>
    		<tr>
    			<td class="welcome-line" colspan="3" >&nbsp;</td>
    		</tr>
    		<tr>
    			<td valign="top" class="welcome-content" align="center" colspan="3">
					<decorator:body/>
    			</td>
    		</tr>
    		<tr>
	   			<td class="welcome-footer-line" colspan="3" style="font-size:1px;">&nbsp;</td>
			</tr>
    		<tr>
    			<td colspan="3">
    				<table width="100%" border="0" cellSpacing="0" cellPadding="0">
		   				<tr>
			   				<td width="100%" class="welcome-footer-copyright" nowrap="nowrap">
			   				</td>
			   				<td class="welcome-footer-copyright" nowrap="nowrap" style="text-align:right;">
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
