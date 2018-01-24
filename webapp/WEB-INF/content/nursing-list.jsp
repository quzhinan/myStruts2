<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title><s:text name="labels.header.title" /></title>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/event.js.jsp'/>"></script>
<script language="JavaScript" type="text/javascript">

	var window_prev_frame = {width: 0, height: 0};
	var allowDownload = true;
	var allowSearch = true;
	function checkDate() {
		var startDate = j$("#startDate").val();
		var toDate = j$("#toDate").val();
		if(toDate < startDate) {
			j$("#dateHint").css("display", "block");
			allowSearch = false;
		} else {
			j$("#dateHint").css("display", "none");
			allowSearch = true;
		}
	}
	j$(document).ready(function() {
		j$("#startDate").datepicker();
		j$("#startDate").datepicker("option", "dateFormat", "yy-mm-dd");
		j$("#toDate").datepicker();
		j$("#toDate").datepicker("option", "dateFormat", "yy-mm-dd");
		j$("#startDate").change(function(){
			j$("#toDate").val(j$("#startDate").val());
		});
		j$("#startDate").val('<s:property value="startDate" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#toDate").val('<s:property value="toDate" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#customerCodeLike").val('<s:property value="customerCodeLike" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#userCodeService").val('<s:property value="userCodeService" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#userCode").val('<s:property value="userCode" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#userCodeFollow").val('<s:property value="userCodeFollow" escapeHtml="false" escapeJavaScript="true"/>');
		//j$("#customerCode").val('<s:property value="customerCode" />');

		// csv download
		j$("#fromDay").datepicker();
		j$("#fromDay").datepicker("option", "dateFormat", "yy年mm月dd日");
		j$("#toDay").datepicker();
		j$("#toDay").datepicker("option", "dateFormat", "yy年mm月dd日");

		var nowDateString = new Date().Format("yyyy年MM月dd日");
		j$("#fromDay").val(nowDateString);
		function checkTime(){
			var fromDay = j$("#fromDay").val();
			var toDay = j$("#toDay").val();
			if(toDay < fromDay) {
				j$("#compareFromTo").css("display", "block");
				allowDownload = false;
			} else {
				j$("#compareFromTo").css("display", "none");
				allowDownload = true;
			}
			
		}
		j$("#fromDay").change(checkTime);
		j$("#toDay").change(checkTime);

		j$(window).resize(function(){
			resizeTagsFrame();
		});
		resizeTagsFrame();
		
		var sortCondition = "<s:property value='sortCondition' />"
		var condition = 4;
		if(sortCondition == "customer_name_kana") {
			condition = 0;
		} else if(sortCondition == "sort_num, user_code") {
			condition = 1;
		} else if(sortCondition == "user_code_service") {
			condition = 2;
		} else if(sortCondition == "status") {
			condition = 3;
		} else if(sortCondition == "visit_date, from_time") {
			condition = 4;
		}
		var content = j$("#sortTd"+condition).html();
		content = content.replace("△","▲");
		j$("#sortTd"+ condition).html(content);
	});

	/* resize tags frame */
	function resizeTagsFrame() {

		if (j$(window).height() != window_prev_frame.height || j$(window).width() != window_prev_frame.width) {
			window_prev_frame.height = j$(window).height();
			window_prev_frame.width = j$(window).width();
			var height = window_prev_frame.height-290;
			if (height < 410) height = 410;
			j$("div.nursingDataContent ").height(height);
		}
	}
	
	function editNursing(nursingId) {
			var url = '<s:url action="nursing!edit" namespace="/" />?id=' + nursingId + '&listType=2';
			window.location.href = iesAddToken(url);
	}
	
	Date.prototype.Format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //   
    "d+" : this.getDate(),                    //   
    "h+" : this.getHours(),                   //   
    "m+" : this.getMinutes(),                 //   
    "s+" : this.getSeconds(),                 //   
    "q+" : Math.floor((this.getMonth()+3)/3), //   
    "S"  : this.getMilliseconds()             //   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}  
	
	function todayBtnClick() {
		var now = new Date().Format("yyyy-MM-dd");
		j$("#startDate").val(now);
		j$("#toDate").val(now);
		j$("#nursingSearch").submit();
	}
	
	function sortById(index) {
		var content = "";
		var condition = "";
		switch (index) {
					case 0:
						condition = "customer_name_kana";
						break;
					case 1:
						condition = "sort_num, user_code";
						break;
					case 2:
						condition = "user_code_service";
						break;
					case 3:
						condition = "status";
						break;
					case 4:
						condition = "visit_date, from_time";
						break;
					default:
						break;
				}
		for (var i = 0; i < 5; i++) {
			content = j$("#sortTd"+i).html();
			if (i == index) {
				content = content.replace("▲","▲");
				j$("#sortTd"+i).html(content);
				
				window.location.href=iesAddToken('<s:url action="nursing-list!reSort" namespace="/" />?sortCondition=' +condition+"&startDate="+j$("#startDate").val()+"&toDate="+j$("#toDate").val()+"&customerCodeLike="+j$("#customerCodeLike").val());
			} else {
				content = content.replace("▲","▲");
				j$("#sortTd"+i).html(content);
			}
		}
	}
	var csvInterval;
	var thisTimeSessionKey;
	
	function getRandomNum(Min, Max) {   
		var Range = Max - Min;
		var Rand = Math.random();
		return (Min + Math.round(Rand * Range));
	}
	
	function showDialog(){
		j$("#download-success").css("display", "none");
		var dialogOpts = {
				bgiframe: true,
				resizable: false,
				height : 440,
				width : 600,
				modal: true,
				overlay: {
				     backgroundColor: '#ff0000',
				     opacity: 0.5
				},
				    buttons: {
				        "ダウンロード": function() {
				        	if(allowDownload && j$("#fromDay").val().length > 0  && j$("#toDay").val().length > 0) {
				        		thisTimeSessionKey = getRandomNum(1000, 9999);
				        		var url = "csv-load.ies?fromDay=" + j$("#fromDay").val() + "&toDay=" + j$("#toDay").val() + "&thisTimeSessionKey=" + thisTimeSessionKey;
						        url = url.replace("年","").replace("月","").replace("日","").replace("年","").replace("月","").replace("日","");
						        window.location = iesAddToken(url);
						        j$("#download-success").css("display", "none");
						        csvInterval = setInterval("clock()",1500)
						        
				        	} else {
				        		alert("<s:text name='errors.common.start.later.end.2'/>");
				        	}
				        },
				        "閉じる": function() {
				            j$(this).dialog('close');
				        }
				    }
				};
		j$("#loadCSVDialog").dialog(dialogOpts);
	}
	
	function removeLoginButton() {
		var buttons = {
				"閉じる" : function(event, ui) {
					j$(this).dialog("close");
				}
			}
		j$("#loadCSVDialog").dialog("option", "buttons", buttons);
	}
	
	function clock() {
		var url = '<s:url action="csv-load!getNums.ies" namespace="/" />';
		j$.get(url, function(data){
			if(data.thisTimeSessionKey == thisTimeSessionKey && data.achievementNums >= 0) {
				removeLoginButton();
				var messageNode = j$("#download-success");
				messageNode.css("display", "inline");
				messageNode.html("<br>○合計レコード数　　　　　　　　　 " + data.achievementNums + "　件<br><br>実績出力は正常に終了しました。");
				window.clearInterval(csvInterval);
			}
		  });
		/* var achievementNums = "<s:property value='achievementNums' />";
		if(achievementNums != null && achievementNums >= 0) {
			alert(achievementNums);
			
		} */
    }
	
	function openCreateSchedule() {
		evt_open_editor(
				0, 0, 2 /* Sechedule */, 
				function(event){ /* success */
					window.location.reload();
				}, 
				function(message){ /* failed */
					window.location.reload();
				}, 
				function(){ /* close */
				});
	}
	function checkInput() {
		checkDate();
		if(!allowSearch) {
			alert("<s:text name='errors.common.start.later.end'/>");
		}
		return allowSearch;
	}
</script>
</head>
<body>
	<div id="loadCSVDialog" title="実績のCSVファイルのダウンロード"
		style="display: none; width: 400px; height: 300px;">
		開始日:&nbsp;&nbsp;
		<s:textfield id="fromDay" name="fromDay" cssClass="downloadCSVInput"></s:textfield>
		<br /> <br /> <br /> <br /> 終了日:&nbsp;&nbsp;
		<s:textfield id="toDay" name="toDay" cssClass="downloadCSVInput"></s:textfield>
		<span id="compareFromTo" style="display: none; color: red;"><s:text
				name='errors.common.start.later.end.2' /></span> <br />
		<p id="download-success" style="display: none;"></p>
	</div>
	<%-- <div style="background-color:cyan; margin:0 auto;"><span id="dateHint"
					style="display: none; color: red; font-size: 14px; margin-right: 950px;"><s:text
							name="errors.common.start.later.end.date" /></span></div> --%>
	<s:form id="nursingSearch" action="nursing-list!search.ies"
		enctype="multipart/form-data" onsubmit="return checkInput();">
		<table style="width: 95%; min-width: 1100px;" border="0">
			<tr>
				<td colspan=9><span id="dateHint"
							style="display: none; color: red; font-size: 14px; margin-left:6px;"><s:text
								name="errors.common.start.later.end.date" /></span></td>
			</tr>
			<tr>
				<td style="text-align: right"><s:text
						name="labels.nursing.visit.date" /> <s:text
						name="labels.separator.label" /></td>
				<td style="width: 18%;"><span
					onclick="javascript:todayBtnClick();"
					style="font-size: 11px; cursor: pointer; background-color: #d89e8e; border-width: 1px; border-style: solid; border-radius: 1px; padding: 4px 10px 1px 10px;"><s:text
							name="labels.button.today" /></span> <s:textfield name="startDate"
						id="startDate" cssStyle="width:100px;" cssClass="disable-ime"
						maxlength="15" onchange="checkDate()" />&nbsp; <img
					src="<s:url value='/images/icon_calendar_16.png'/>"
					style="width: 14px; height: 14px;" /></td>
				<td style="text-align: center; width: 100px"><s:text
						name="labels.separator.to" /></td>
				<td><s:textfield name="toDate" id="toDate"
						cssStyle="width:100px;" cssClass="disable-ime" maxlength="15"
						onchange="checkDate()" />&nbsp; <img
					src="<s:url value='/images/icon_calendar_16.png'/>"
					style="width: 14px; height: 14px;" /></td>
				<td style="text-align: right"><s:text
						name="labels.nursing.service.charger" /> <s:text
						name="labels.separator.label" /></td>
				<td><s:select list="serviceUserList" id="userCodeService"
						name="userCodeService" listKey="userCode" listValue="userName"
						style="width:120px;" headerKey='0' headerValue="すべて" /></td>
				<td style="text-align: right">状態 <s:text
						name="labels.separator.label" /></td>
				<td><s:select
						list="#{-1:'すべて',3:'本日予定',4:'予定',0:'未実施',7:'実施中',1:'終了',2:'終了(変更)',8:'終了(新規)',5:'承認',6:'キャンセル'}"
						listKey="key" listValue="value" name="status"></s:select></td>
				<td></td>
			</tr>
			<tr>
				<td style="text-align: right"><s:text
						name="labels.nursing.customer" /> <s:text
						name="labels.separator.label" /></td>
				<td><s:select list="customerList" id="customerCode"
						name="customerCode" listKey="customerCode"
						listValue="customerName" style="width:120px;" headerKey='0'
						headerValue="すべて" /></td>
				<td style="text-align: right"><s:text
						name="labels.nursing.customer.code" /> <s:text
						name="labels.separator.label" /></td>
				<td><s:textfield name="customerCodeLike" id="customerCodeLike"
						cssStyle="width:140px;" cssClass="disable-ime" maxlength="20" /></td>
				<td style="text-align: right"><s:text
						name="labels.nursing.charger" /> <s:text
						name="labels.separator.label" /></td>
				<td><s:select list="chargeUserList" id="userCode"
						name="userCode" listKey="userCode" listValue="userName"
						style="width:120px;" headerKey='0' headerValue="すべて" /></td>
				<td style="text-align: right"><s:text
						name="labels.nursing.user.follow" /> <s:text
						name="labels.separator.label" /></td>
				<td><s:select list="chargeUserList" id="userCodeFollow"
						name="userCodeFollow" listKey="userCode" listValue="userName"
						style="width:120px;" headerKey='0' headerValue="すべて" /></td>
				<td><s:submit key="labels.button.search"
						cssClass="button2-action" name="search" id="search" /></td>
			</tr>
		</table>
	</s:form>



	<table style="width: 95%; min-width: 1150px;" cellspacing="0"
		cellpadding="0">
		<tr>
			<td>
				<div style="width: 100%; overflow-x: hidden; overflow-y: scroll;">
					<table id="titleTable" style="width: 100%; table-layout: fixed;"
						cellspacing="0" cellpadding="0">
						<tr class="listTitle">
							<td style="width: 80px;">
								<%-- <s:text
									name="labels.button.selectall" /> --%>&nbsp;&nbsp;<s:text
									name="labels.title.index" />
							</td>
							<td style="width: 100px;"><s:text
									name="labels.button.service.content" /></td>
							<td id="sortTd4" style="width: 160px; cursor: pointer;"
								onclick="javascript:sortById(4);"><s:text
									name="labels.nursing.list.visit.datetime" /></td>
							<td id="sortTd0" style="width: 135px; cursor: pointer;"
								onclick="javascript:sortById(0);"><s:text
									name="labels.nursing.list.customer" /></td>
							<td id="sortTd1" style="width: 140px; cursor: pointer;"
								onclick="javascript:sortById(1);"><s:text
									name="labels.nursing.list.charger" /></td>
							<td style="width: 140px;"><s:text
									name="labels.nursing.list.charger.follow" /></td>
							<td id="sortTd2" style="width: 140px; cursor: pointer;"
								onclick="javascript:sortById(2);"><s:text
									name="labels.nursing.list.service.charger" /></td>
							<td id="sortTd3"
								style="width: 90px; border-right: #5e76ae solid 1px; cursor: pointer;"
								onclick="javascript:sortById(3);"><s:text
									name="labels.nursing.status" /></td>
							<td style="width: 10px; border: none; cursor: pointer;"></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="nursingDataContent">
					<table style="width: 100%; table-layout: fixed;" cellspacing="0"
						cellpadding="0" border="0">
						<s:iterator value="nursingList" id="nursing" status="status">
							<tr class="nursingRecord"
								<s:if test="status == 1">bgcolor="#96af85"</s:if>
								<s:elseif test="status == 2">bgcolor="#f7f27a"</s:elseif>
								<s:elseif test="status == 0">bgcolor="#ea9ed4"</s:elseif>
								<s:elseif test="status == 5">bgcolor="#808080"</s:elseif>
								<s:elseif test="status == 6">bgcolor="#f39d63"</s:elseif>
								<s:elseif test="status == 7">bgcolor="#89d6fa"</s:elseif>
								<s:elseif test="status == 8">bgcolor="#32ce32"</s:elseif>
								onclick="javascript:editNursing(${id});">
								<td style="width: 80px; border-left: #5e76ae solid 1px;">
									<!-- <input
									name="ids" type="checkbox" class="check" value="id"> --> <s:property
										value="#status.index+1" />
								</td>
								<td style="width: 100px;"><s:property value="serviceName" /></td>
								<td style="width: 160px;"><s:property
										value="visitDateWeekTime" /></td>
								<td style="width: 135px;"><s:property value="customerName" /></td>
								<td style="width: 140px;"><s:property value="userName" /></td>
								<td style="width: 140px;"><s:property
										value="userNameFollow" /></td>
								<td style="width: 140px;"><s:property
										value="userNameService" /></td>
								<td style="width: 90px;"><s:if test="status == 0">
										<s:text name="labels.nursing.status.undo" />
									</s:if> <s:elseif test="status == 1">
										<s:text name="labels.nursing.status.finish" />
									</s:elseif> <s:elseif test="status == 2">
										<s:text name="labels.nursing.status.finish.update" />
									</s:elseif> <s:elseif test="status == 8">
										<s:text name="labels.nursing.status.finish.new" />
									</s:elseif> <s:elseif test="status == 3">
										<s:text name="labels.nursing.status.today.order" />
									</s:elseif> <s:elseif test="status == 4">
										<s:text name="labels.nursing.status.order" />
									</s:elseif> <s:elseif test="status == 5">
										<s:text name="labels.nursing.status.approve" />
									</s:elseif> <s:elseif test="status == 6">
										<s:text name="labels.nursing.status.cancel" />
									</s:elseif> <s:elseif test="status == 7">
										<s:text name="labels.nursing.status.carryout" />
									</s:elseif> <s:if test="finishedFlag == 1 && (status == 1 || status == 2 || status == 8)">
										<span style="font-size: 20px;">●</span>
									</s:if></td>
								<td style="width: 10px; border: none; cursor: pointer;  background-color: white; font-size: 20px;">
								<s:if test="commentConfirmStatusShow == 0">
								<span>&nbsp;</span>
								</s:if>
								<s:elseif test="commentConfirmStatusShow == 2">
								<span style="color: rgb(50,50,50);">■</span>
								</s:elseif>
								<s:elseif test="commentConfirmStatusShow == 1">
								<span style="color: red;">■</span>
								</s:elseif></td>
							</tr>
						</s:iterator>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<div class="blackLine">
		<table class="menuTable" border="0">
			<tr>
				<!-- td width=10%><s:url id="urlList" action="nursing-list.ies"
						namespace="/" /> <s:a href="%{urlList}">
						<s:text name="labels.nursing.record" />
					</s:a></td -->
				<td width=54%></td>
				<%-- <td width=10%><s:a href="javascript:void(0);"
						onclick="openCreateSchedule();">
						<s:text name="labels.nursing.add" />
					</s:a></td> --%>
				<td width=16%><s:url id="urlDL" action="nursing-list!download"
						namespace="/">
					</s:url> <s:a href="%{urlDL}">
						訪問予定・実績一覧CSV出力
					</s:a></td>
				<td width=10%><s:url id="urlAdd" action="nursing!add"
						namespace="/">
						<s:param name="listType" value="2" />
					</s:url> <s:a href="%{urlAdd}">
						介護記録・新規
					</s:a></td>
				<td width=10%><s:url id="urlCSVExport" action="csv-load"
						namespace="/">
						<%--  href="%{urlCSVExport}" --%>
					</s:url> <s:a href="#" onClick="showDialog()">
						実績出力
					</s:a></td>
			</tr>
		</table>
	</div>



</body>

</html>