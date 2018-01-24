<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<link rel="shortcut icon" href="images/icon.png">
<title><decorator:title default="" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />

<link type="text/css" href="<s:url value='/styles/layout-main.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/forms.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/block.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/menu.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/cust.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/list.css'/>"
	rel="stylesheet" media="all" />

<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/1.11/jquery-1.11.3.min.js'/>"></script>

<link type="text/css"
	href="<s:url value='/jquery/1.11/jquery-ui-1.11.4.custom/jquery-ui.min.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css"
	href="<s:url value='/jquery/1.11/jquery-ui-1.11.4.custom/jquery-ui.structure.min.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css"
	href="<s:url value='/jquery/1.11/jquery-ui-1.11.4.custom/jquery-ui.theme.min.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/1.11/jquery-ui-1.11.4.custom/jquery-ui.min.js'/>"></script>


<link type="text/css" href="<s:url value='/styles/calendar.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/i18n/jquery.ui.datepicker-ja.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/common.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/calendar.js'/>"></script>

<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ajaxfileupload.js'/>"></script>

<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/jquery.cookie.js'/>"></script>



<script language="JavaScript">
	jQuery.noConflict();
	var j$ = jQuery;

	j$(document).ready(function() {
		j$("#select_date_input").val('<s:property value="requestDate"/>');

		j$("#select_date_input").datepicker({
			dateFormat : "yy-mm-dd",
			onSelect : function(dateText, inst) {
				finishChooseDate(dateText);
			}
		});
		
		j$("form").submit(function(){
			if (j$(this).attr("enctype") == "multipart/form-data") {
				j$(this).attr("action", iesAddTokenSubmit(j$(this).attr("action")));
			} else {
				j$("#ietoken").detach();
				j$(this).append('<input id="ietoken" type="hidden" name="ietoken"/>');
				j$("#ietoken").val(j$.cookie("ietoken"));
			}
		});
		
		j$("a").click(function(){
			if (isACancelClicked) {
				isACancelClicked = false;
			} else {
				var href = j$(this).attr("href");
				if (href.indexOf("/") == 0) {
					j$(this).attr("href", iesAddToken(href));
				}
			}
		});
	});
	
	var isACancelClicked = false;
	
	j$(document).ajaxSend(function( event, request, settings ) {
		if (!settings.data) {
		    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			settings.data = "ietoken=" + j$.cookie("ietoken");
		} else if (typeof(settings.data) == 'string') {
			settings.data += '&ietoken=' + j$.cookie("ietoken");
		} else if (!settings.data._token) {
			settings.data.ietoken = j$.cookie("ietoken");
		}
	});

	function fillToday() {
		var t = new Date;
		year = t.getFullYear();
		month = t.getMonth() + 1;
		date = t.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (date < 10) {
			date = "0" + date;
		}
		var nowDate = year + "-" + month + "-" + date;
		j$("#select_date_input").val(nowDate);
		finishChooseDate(nowDate);
	}
	
	function removeLoginButton() {
		var buttons = {
				"閉じる" : function(event, ui) {
					j$(this).dialog("close");
					window.location = iesAddToken(window.location.toString());
				}
			}
		j$("#uploadCSVDialog").dialog("option", "buttons", buttons);
	}
	
	function uploadCSV() {
		j$("#upload-result-success").css("display", "none");
		j$("#upload-result").css("display", "none");
		if (tableIdentifier == 3) {
			j$("#planStartDate").css("display", "inline");
		}
		//
		j$("#csvName").val("");
		j$("#csvPath").val("");
		var hadUpload = false;
		var dialogOpts = {
			bgiframe : true,
			resizable : false,
			height : 440,
			width : 600,
			modal : true,
			overlay : {
				backgroundColor : '#ff0000',
				opacity : 0.5
			},
			buttons : {
				'登録' : function() {
					j$("#upload-result-success").css("display", "none");
					hadUpload = true;
					var url = '<s:url action="csv" namespace="/js" />';
					var csvName = j$("#csvName").val();
					var csvYM = j$("#searchServiceYmCSV").val();
					var startDay = j$("#planStartDay").val();

					j$.ajaxFileUpload({
								url : iesAddToken(url),
								data : {
									csvName : csvName,
									tableIdentifier : tableIdentifier,
									csvYM : csvYM,
									startDay : startDay
								},
								type : "post",
								dataType : "text/xml",
								timeout : 1000,
								secureuri : false,
								fileElementId : "csvPath",
								error : function(data, status, e) {
									alert("failed");
								},
								success : function(data, status) {
									
									if(data.result == "success") {
										//j$(this).dialog("close");
										// window.location.reload();
										var messageNode = j$("#upload-result-success");
										messageNode.css("display", "inline");
										//messageNode.css("color", "red"); 
										messageNode.html(data["message"]);
									} else {
										var messageNode = j$("#upload-result");
										messageNode.css("display", "inline");
										messageNode.css("color", "red"); 
										messageNode.html(data["message"]);
									}
									removeLoginButton();
								}
							});
				},
				"閉じる" : function(event, ui) {
					j$(this).dialog("close");

					if (hadUpload) {
						window.location = iesAddToken(window.location.toString());
					}
				}
			}
		};
		j$("#uploadCSVDialog").attr("title", dialogTitle + "のCSVファイルのアップロード");
		j$("#uploadCSVDialog").dialog(dialogOpts);
	}
	function splitAddress(address) {
		var array = address.split('\\');
		return array[array.length - 1];
	}
	function uploadFileChange() {
		j$("#csvName").val(splitAddress(j$("#csvPath").val()));
		j$("#upload-result").css("display", "none");
	}
</script>
<decorator:head />
</head>
<body id="page-home">
	<div id="uploadCSVDialog"
		style="display: none; width: 400px; height: 300px;">

		<div class='fakefileinputs'>
			<input type='file' class='truefileforupload' size=1 name='csvFile'
				id='csvPath' onChange='uploadFileChange()' style="width: 170px;" />
			<div class='abovefakefile'>
				<input type='text' maxlength="200" name='csvName' readonly
					id='csvName' style='z-index: 3; width: 390px;' /> <input
					type='button' value='<s:text name='labels.button.refer'/>'
					id='btnTriger' /> <span style='color: red; font-size: 14px;'>*</span><span
					style="padding-left: 7px;"></span>
			</div>
			<br /> <br />
			<s:if test="choooseYM">
				<table id="planStartDate">
						<tr>
							<td>
								<s:select id="searchServiceYmCSV" name="searchServiceYm" cssStyle="font-size:18px;"
									list="yearMonthsCSV" listKey="key" listValue="label"
									value="defaultCSVYM"></s:select>
							</td>
							<td>
							<s:select id="planStartDay" list="{'02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'}" theme="simple" headerKey="00" headerValue="01"></s:select>
							</td>
						</tr>
				</table>
			</s:if>
			<br /> <br /> <br />
			<p id="upload-result-success" style="display: none;"></p>
			<br /> <br /> <br /> <br />
			
			<h3 id="upload-result" style="display: none;"></h3>
		</div>
	</div>
	<div id="page-main">
		<table width="100%" class="main-title-box" border="0" cellSpacing="0"
			cellPadding="0" id="calendar_td">
			<tr>
				<td nowrap="nowrap" class="main-logo"><img
					src="<s:url value='/images/logo.jpg'/>" border="0"
					style="width: 140px; height: 39px;" /> &nbsp;</td>
				<td nowrap="nowrap" class="main-header"><s:text
						name="labels.system.title" /></td>
				<td nowrap="nowrap" class="main-welcome">${welcomeInfo}</td>
				<td width="90" nowrap="nowrap" class="main-welcome"><s:url
						id="url" action="logout" includeParams="none" namespace="/" /> <span
					onclick="window.location=iesAddToken('${url}')"
					style="cursor: pointer; background-color: #91acda; border-width: 1px; border-style: solid; border-radius: 3px; padding: 3px 5px 2px 5px;"><s:text
							name="labels.menu.logout" /></span></td>
				<td nowrap="nowrap" class="main-welcome"><s:if
						test="!isSystemMenu()">
						<s:url id="url" action="home" includeParams="none" namespace="/">
							<s:param name="menuid" value="menuIdSysHome" />
						</s:url>
						<img onclick="window.location=iesAddToken('${url}')" style="cursor: pointer;"
							src="<s:url value='/images/button_top_home.png'/>" border="0"
							height="32" />
					</s:if></td>
			</tr>
			<s:if test="!isSystemMenu()">
				<tr>
					<td nowrap="nowrap" class="page-menu" colspan="5">
						<ul>
							<s:if test="isManageMenu()">
								<s:if test="canDoAction('plan')">
									<s:url id="url" action="plan" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrPlan" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrPlan?'selected':''"/>><s:text
											name="labels.menu.manager.plan" /></li>
								</s:if>
								<s:if test="canDoAction('shift')">
									<s:url id="url" action="shift" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrShift" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrShift?'selected':''"/>><s:text
											name="labels.menu.manager.shift" /></li>
								</s:if>
								<s:if test="canDoAction('schedule')">
									<s:url id="url" action="schedule" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrSchedule" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrSchedule?'selected':''"/>><s:text
											name="labels.menu.manager.schedule" /></li>
								</s:if>
								<s:if test="canDoAction('nursing')">
									<s:url id="url" action="nursing-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrAchievement" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrAchievement?'selected':''"/>><s:text
											name="labels.menu.manager.achievement" /></li>
								</s:if>
								<s:if test="canDoAction('week')">
									<s:url id="url" action="week-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrWeek" />
										<s:param name="clear" value="true" />
										<s:param name="tab" value="1" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrWeek?'selected':''"/>><s:text
											name="labels.menu.manager.week" /></li>
								</s:if>
								<!--  Modify for Comment - start -->
								<s:if test="canDoAction('comment')">
									<s:url id="url" action="comment-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMgrComment" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMgrComment?'selected':''"/>><s:text
											name="labels.menu.manager.comment.short" /></li>
								</s:if>
								<!--  Modify for Comment - end -->
							</s:if>
							<s:if test="isMasterMenu()">
								<s:if test="canDoAction('customer')">
									<s:url id="url" action="customer-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMstCustomer" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMstCustomer?'selected':''"/>><s:text
											name="labels.menu.master.customer" /></li>
								</s:if>
								<s:if test="canDoAction('user')">
									<s:url id="url" action="user-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMstUser" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMstUser?'selected':''"/>><s:text
											name="labels.menu.master.user" /></li>
								</s:if>
								<s:if test="canDoAction('office')">
									<s:url id="url" action="office-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMstOffice" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMstOffice?'selected':''"/>><s:text
											name="labels.menu.master.office" /></li>
								</s:if>
								<s:if test="canDoAction('master')">
									<s:url id="url" action="master" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMstMaster" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMstMaster?'selected':''"/>><s:text
											name="labels.menu.master.master" /></li>
								</s:if>
								<s:if test="canDoAction('service')">
									<s:url id="url" action="service-list" includeParams="none"
										namespace="/">
										<s:param name="menuid" value="menuIdMstService" />
										<s:param name="clear" value="true" />
									</s:url>
									<li onclick="window.location=iesAddToken('${url}')"
										<s:property value="menuIdFromSession==menuIdMstService?'selected':''"/>><s:text
											name="labels.menu.master.service" /></li>
								</s:if>
							</s:if>
						</ul>
					</td>
				</tr>
			</s:if>
		</table>
		<table width="100%" class="main-content-box" border="0"
			cellSpacing="0" cellPadding="0">
			<tr>
				<td class="main-content" valign="top" align="center"
					style="padding-top: 20px; min-height: 400px;"><decorator:body /></td>
			</tr>
			<tr>
				<td class="main-footer-line"></td>
			</tr>
		</table>
	</div>
</body>
</html>
