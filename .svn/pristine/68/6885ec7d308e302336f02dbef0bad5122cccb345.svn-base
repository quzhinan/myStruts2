<!DOCTYPE html PUBLIC 
    "-//W3C//DTD XHTML 1.1 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    
<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <link rel="shortcut icon" href="images/icon.png" >
    <title><s:text name="labels.error.title"/> - <s:text name="labels.header.title" /></title>
    <script type="text/javascript"> 
        j$(function(){
        	j$("#local")
	            .treemenu()
	            .treemenu("hide", "main");
	        j$("#sub")
	            .buttonmenu()
	            .buttonmenu("hide", "main");

            j$("#back").bind("click", function() {
            	window.history.go(-1);
            });
            j$("#main").css("height", "450px");
        });
     </script>
    <s:head />
</head>
<body>
    
<!--
<h2>An unexpected error has occurred</h2>
<p>
    Please report this error to your system administrator
    or appropriate technical support personnel.
    <br>
    Thank you for your cooperation.
</p>
-->

<hr/>

<h1><s:text name="labels.error.msg0"/></h1>
<p>
    <s:text name="labels.error.msg1"/>
    <br>
    <s:text name="labels.error.msg2"/>
</p>

<hr/>

<br/>
<br/>
<br/>
<!--
<div id="button-box" align="center"><s:submit key="labels.button.back" id="back"/></div>
-->
<div id="button-box" align="center"><a id="logout" href="logout.ies"><s:text name="labels.button.login.link"/></a></div>

<br/>
<br/>
</body>
</html>

