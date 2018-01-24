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
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/DateManager.js'/>"></script>
<s:head />
<script language="javascript">
	var tableIdentifier = 3;
	var dialogTitle = "提供票";
	var window_prev_frame = {width: 0, height: 0};
	
	j$(function(){
		j$("#fromDay").datepicker();
		j$("#fromDay").datepicker("option", "dateFormat", "yy年mm月dd日");
		j$("#toDay").datepicker();
		j$("#toDay").datepicker("option", "dateFormat", "yy年mm月dd日");
		
		j$(window).resize(function(){
			resizeTagsFrame();
		});
		resizeTagsFrame();
		scrollToShowItem("box_customer_item_${customerId}", "box_customer_list");
		
		var deleteSize = "<s:property value='deleteSize'/>";
		if(deleteSize == -1) {
			alert("<s:text name='messages.plan.delete.fail'/>");
		} else if (deleteSize != -2) {
			alert("<s:text name='messages.plan.delete.success'/>, 件数は " + deleteSize + " です。");
		}
	});

	/* resize tags frame */
	function resizeTagsFrame() {
		if (j$(window).height() != window_prev_frame.height || j$(window).width() != window_prev_frame.width) {
			window_prev_frame.height = j$(window).height();
			window_prev_frame.width = j$(window).width();
			var height = window_prev_frame.height-410;
			var width = window_prev_frame.width-270;
			if (height < 280) height = 280;
			if (width < 990) width = 990;
			var unit = parseInt(width/40) - 1;
			j$("div.plan-header-box").width(width);
			j$("div.plan-content-box").height(height);
			j$("div.plan-content-box").width(width);
			j$("#box_customer_list").height(height+120);
			j$("div.plan-header-box td").width(unit);
			j$("div.plan-content-box td").width(unit);
		}
	}
	
	function modifyEventItemData(box, eventId, type, timeStart, timeEnd, serviceCode, serviceYm, serviceDay) {
		var notHasId = isNaN(parseInt(j$(box).text()));
		if (type == 1) {
			var defval = {customerId: ${customerId}, serviceYm: '${searchServiceYm}'};
			defval.timeStartHour = timeStart.substring(0, 2);
			defval.timeStartMinute = timeStart.substring(2, 4);
			defval.timeEndHour = timeEnd.substring(0, 2);
			defval.timeEndMinute = timeEnd.substring(2, 4);
			defval.serviceCode = serviceCode;
			defval.serviceDate = "" + serviceYm + (serviceDay < 10 ? "0" : "") + serviceDay;
			evt_open_editor(
					0, (notHasId ? 0 : eventId), 1 /* Plan */, 
					function(event){ /* success */
						var location = window.location.toString().replace("?deleteSize=-1", "");
						window.location = iesAddToken(location);
					}, 
					function(message){ /* failed */
						window.location = iesAddToken(window.location.toString());
					}, 
					function(){ /* close */
					}, defval);
		} else if (eventId > 0 && notHasId == false) {
			var url = '<s:url action="schedule!toNursingId" includeParams="none" namespace="/js" />';
			j$.post(url, {nursingId: eventId}, function(data){
				if (data.nursingId > 0) {
					var url = '<s:url action="nursing!edit" includeParams="none" namespace="/" />';
					window.location = iesAddToken(url + "?id=" + data.nursingId + "&listType=4");
				}
			}, "json")
		} else {
			alert("<s:text name='messages.plan.achievement.data.not.exited' />");
		}
	}
		
	function createEventItemData() {
		var defval = {customerId: ${customerId}, serviceYm: '${searchServiceYm}'};
		evt_open_editor(
				0, 0, 1 /* Plan */, 
				function(event){ /* success */
					window.location = iesAddToken(window.location.toString());
				}, 
				function(message){ /* failed */
					window.location = iesAddToken(window.location.toString());
				}, 
				function(){ /* close */
				}, defval);
	}
	
	function createEventItemDataWeek() {
		var defval = {customerId: ${customerId}, serviceYm: '${searchServiceYm}'};
		evt_open_editor_week(
				0, 1 /* Plan */, 
				function(event){ /* success */
					window.location = iesAddToken(window.location.toString());
				}, 
				function(message){ /* failed */
					window.location = iesAddToken(window.location.toString());
				}, 
				function(){ /* close */
				}, defval);
	}
	
	function changeSelectedYm(ym) {
		if (ym != null && ym.length == 6) {
			j$("#searchServiceYm").val(ym);
			submitForm();
		}
	}
	
	function submitForm() {
		j$("#form_search").submit();
	}

	var allowImportWeek = true;
	
	function checkTime() {
		var fromDay = j$("#fromDay").val();
		var toDay = j$("#toDay").val();
		if(toDay < fromDay) {
			j$("#compareFromTo").css("display", "block");
			allowImportWeek = false;
		} else {
			j$("#compareFromTo").css("display", "none");
			allowImportWeek = true;
		}	
	}
	
	// 週間導入
	function importWeek() {
		var nowDateString = new Date().Format("yyyy年MM月dd日");
		var maxDay = new Date().MaxDayOfDate();
		var endDateString = new Date().Format("yyyy年MM月") + maxDay + "日";
		j$("#fromDay").val(nowDateString);
		j$("#toDay").val(endDateString);
		j$("#fromDay").change(checkTime);
		j$("#toDay").change(checkTime);
		
		j$("#import-week-result-success").css("display", "none");
		j$("#import-week-result").css("display", "none");
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
					removeImportButton();
					if(!allowImportWeek) {
						alert("<s:text name='message.startday.before.endday'/>");
						return;
					}
					var url = '<s:url action="week" namespace="/js" includeParams="none"/>';
					var customerCode = j$("#customerCode").val();
					var fromDay = j$("#fromDay").val();
					var toDay = j$("#toDay").val();

					if(fromDay.substring(0,7) != toDay.substring(0,7)) {
						alert("開始日と終了日の月は一致してください。");
						return;
					}
					j$.post(url, {"customerCode" : customerCode, "fromDay" : fromDay, "toDay" : toDay,"a":"e"}, function(data) {
						if(data.result == "success") {
							var messageNode = j$("#import-week-result-success");
							var fdStart = data["message"].indexOf("実績データがあるので");
							if(fdStart == 0) {
								messageNode.css("color", "red");
							} else {
								messageNode.css("color", "blue");
							}
							messageNode.html(data["message"]);
							
						} else {
							var messageNode = j$("#import-week-result");
							messageNode.css("display", "inline");
							messageNode.css("color", "red"); 
							messageNode.html(data["message"]);
							if (data["message"] == "<br><br>今月に既存イベント。") {
								if(confirm("既存データが存在しています。上書きしてもよろしいでしょうか？")) {
									forceImportWeek();
								}
							}
						}
					}, "json");
				},
				"閉じる" : function(event, ui) {
					j$(this).dialog("close");
					window.location = iesAddToken(window.location.toString());
				}
			}
		};
		
		j$("#weekImportDialog").attr("title", '<s:text name="labels.button.week.import"/>');
		j$("#weekImportDialog").dialog(dialogOpts);
	}
	
	function forceImportWeek() {
		j$("#import-week-result-success").css("display", "none");
		var url = '<s:url action="week" namespace="/js" />';
		var customerCode = j$("#customerCode").val();
		var month = j$("#searchWeekYmCSV").val();
		var datas = new Object();
		datas["customerCode"] = customerCode;
		datas["month"] = month;
		datas["force"] = "isForce";
		
		j$.post(url, datas, function(data) {
			var messageNodeSuccess = j$("#import-week-result-success");
			messageNodeSuccess.css("display", "inline");
			var messageNode = j$("#import-week-result");
			messageNode.css("display", "none");
			messageNode.css("color", "red"); 
			if(data.result == "success") {
				messageNodeSuccess.html(data["message"]);
				removeImportButton();
			} else {
				messageNode.html(data["message"]);
			}
		}, "json");
	}
	
	function removeImportButton() {
		var buttons = {
				"閉じる" : function(event, ui) {
					j$(this).dialog("close");
					window.location = iesAddToken(window.location.toString());
				}
			}
		
		j$("#weekImportDialog").dialog("option", "buttons", buttons);
		
		// 移除登録button后显示正在倒入中
		var messageNode1 = j$("#import-week-result-success");
		messageNode1.css("color", "blue");
		messageNode1.css("display", "inline");
		messageNode1.html("ただいま実行中です。");
	}
	
	/* function bulkDelete() {
		if (j$("input[name='keys']:checked").length > 0) {
			if (confirm('<s:text name="messages.plan.delete.confirm" />') == true) {
				j$("#form_list").submit();
			} else {
				j$("input[name='keys']:checked").attr("checked", false);
			}
		} else {
			alert('<s:text name="messages.plan.delete.required" />');
		}
	} */
	
	function bulkServiceDelete() {
		if (j$("input[name='keys']:checked").length > 0) {
			
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
					'OK' : function() {
						var deleteStartDay = j$("#deleteStartDay").val();
						var deleteStopDay = j$("#deleteStopDay").val();
						if(parseInt(deleteStartDay) > parseInt(deleteStopDay)) {
							alert('<s:text name="message.startday.before.endday" />');
							return;
						}
						if (confirm('<s:text name="messages.plan.delete.confirm" />') == true) {
							j$("#startDay").val(deleteStartDay);
							j$("#stopDay").val(deleteStopDay);
							j$("#form_list").submit();
						}
						/* j$("#import-week-result-success").css("display", "none");
						var url = '<s:url action="event!deleteEvents" namespace="/js" includeParams="none"/>';
						var customerCode = j$("#customerCode").val();
						var month = j$("#searchWeekYm").val();
						var deleteStartDay = j$("#deleteStartDay").val();
						var deleteStopDay = j$("#deleteStopDay").val();
						j$.post(url, {"customerCode" : customerCode, "month" : month,"deleteStartDay":deleteStartDay,"deleteStopDay":deleteStopDay}, function(data) {
							
						}, "json"); */
					},
					"閉じる" : function(event, ui) {
						j$(this).dialog("close");
						window.location = iesAddToken(window.location.toString());
					}
				}
			};
			
			j$("#deleteServiceDialog").attr("title", '<s:text name="labels.button.delete.service.title"/>');
			j$("#deleteServiceDialog").dialog(dialogOpts);
			
		} else {
			alert('<s:text name="messages.plan.delete.service.required" />');
		}
	}
	
	function checkAll(obj) {
		if(j$(obj).prop("checked")) {
			j$("input[name='keys']").prop("checked", true);
		} else {
			j$("input[name='keys']").prop("checked", false);
		}
		
	}
</script>

<style type="text/css">
.plan_dialog {
	display: none;
	width: 400px;
	height: 300px;
}
</style>
</head>
<body>
	<div id="deleteServiceDialog" class="plan_dialog">
		<div class='fakefileinputs'>
			<br /> <br /> <br />
			<table id="planStartDate">
				<tr>
					<td>開始日：&nbsp;<s:property value="searchServiceYmLong" /> <s:select
							id="deleteStartDay" cssStyle="font-size:18px;"
							list="monthDayList" listKey="key" listValue="value" 
							></s:select>日
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>終了日：&nbsp;<s:property value="searchServiceYmLong" /> <s:select
							id="deleteStopDay" cssStyle="font-size:18px;" list="monthDayList"
							listKey="key" listValue="value"></s:select>日
					</td>
				</tr>
			</table>
			<br /> <br /> <br />
		</div>
	</div>
	<div id="weekImportDialog" class="plan_dialog">
		<div class='fakefileinputs'>
			<br />
			<table id="planStartDate">
				<tr>
					<td>利用者:&nbsp;&nbsp;<s:select id="customerCode"
							name="customerCode"
							cssStyle="font-size:18px;height:30px; width:200px; border-radius: 5px;"
							list="customers" listKey="customerCode" listValue="customerName"
							headerKey="0" headerValue="--すべて--" /></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td>開始日:&nbsp;&nbsp;<s:textfield id="fromDay" cssClass="disable-ime"
							cssStyle="height:30px; width:200px; border-radius: 5px; border:1px solid;"></s:textfield></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td>終了日:&nbsp;&nbsp;<s:textfield id="toDay" cssClass="disable-ime"
							cssStyle="height:30px; width:200px; border-radius: 5px; border:1px solid;"></s:textfield></td>
				</tr>
				<tr>
					<td><span id="compareFromTo"
						style="display: none; color: red;"><s:text
								name='errors.common.start.later.end.1' /></span></td>
				</tr>
				<%-- <tr>
					<td><span style="color: black; font-size: 17px;">全利用者を対象に計画を一括作成します。</span>
					<s:select id="searchWeekYmCSV" name="searchServiceYm"
							cssStyle="font-size:18px;" list="yearMonthsCSV" listKey="key"
							listValue="label" value="defaultCSVYM"></s:select>
					</td>
				</tr> --%>
			</table>
			<br /> <br /> <br />
			<p id="import-week-result-success" style="display: none;"></p>
			<h3 id="import-week-result" style="display: none;"></h3>
		</div>
	</div>
	<table class="page-content" border="0">
		<s:form id="form_search" action="plan!jikannhennkou">
			<tr class="header">
				<td class="search"><input type="text" name="searchCustomerName"
					value="${searchCustomerName}" maxlength="30"
					placeholder="<s:text name="labels.button.search.name" />" /> <img
					src="<s:url value='/images/button_page_search.png'/>" border="0"
					onclick="submitForm();" /></td>
				<td class="warning" colspan="2"><s:if
						test="planActualDifference">
						<s:text name="messages.plan.warning" />
					</s:if></td>
				<td class="title"><s:if test="customerName != null">
						<s:text name="labels.plan.title.customer">
							<s:param>${customerName}</s:param>
						</s:text>
					</s:if></td>
				<td class="date">
					<table>
						<tr>
							<td><a href="javascript:void(0);"
								onclick="changeSelectedYm('${prevMonthKey}');"> <img
									src="<s:url value='/images/p2/button_left.png'/>" width="22"
									style="margin: 3px 5px 0 0;" />
							</a></td>
							<td><s:select id="searchServiceYm" name="searchServiceYm"
									cssStyle="font-size:15px;" list="yearMonths" listKey="key"
									listValue="label" value="searchServiceYm"
									onchange="submitForm();"></s:select></td>
							<td><a href="javascript:void(0);"
								onclick="changeSelectedYm('${nextMonthKey}');"> <img
									src="<s:url value='/images/p2/button_right.png'/>" width="22"
									style="margin: 3px 0 0 5px;" />
							</a></td>
						</tr>
					</table>
				</td>
			</tr>
		</s:form>
		<tr class="content">
			<td class="list">
				<div id="box_customer_list" class="list-box">
					<ul>
						<s:iterator value="customers" status="rowStatus">
							<s:url id="url" action="plan" includeParams="none" namespace="/">
								<s:param name="customerId" value="id" />
							</s:url>
							<li id="box_customer_item_${id}"
								onclick="window.location=iesAddToken('${url}')"
								<s:property value="id==customerId?'selected':''"/>>${customerName}</li>
						</s:iterator>
					</ul>
				</div> <%-- <div class="add-box">
					<table>
						<tr>
							<td><img src="<s:url value='/images/p2/button_add.png'/>"
								width="22" style="margin-right: 5px;" /></td>
							<td><a href="javascript:void(0)"
								onclick="createEventItemData();" class="link-action2">新規作成</a></td>
						</tr>
					</table>
				</div> --%>
			</td>
			<td class="grid" colspan="4">
				<div class="plan-header-box ">
					<table class="plan-header">
						<tr>
							<td rowspan="3" colspan="1"><s:text name="labels.plan.check" /><br />
								<br /> <input type="checkbox" onchange="checkAll(this)" /></td>
							<td rowspan="2" colspan="2"><s:text
									name="labels.plan.time.scope" /></td>
							<td rowspan="3" colspan="1"><s:text
									name="labels.plan.service" /></td>
							<td rowspan="1" colspan="24" style="border-right-width: 0px;">${selectedMonth.label}</td>
							<td rowspan="1" colspan="10"
								style="border-left-width: 0px; text-align: right; padding-right: 10px;">
								<s:text name="labels.plan.total.customer.format">
									<s:param>${total.textCustomerActualTotal}</s:param>
									<s:param>${total.textCustomerPlanTotal}</s:param>
								</s:text>
							</td>
						</tr>
						<tr>
							<td><s:text name="labels.plan.date.day" /></td>
							<s:iterator value="selectedMonth.days" status="rowStatus">
								<td
									class="<s:if test="isToday(searchServiceYm, #rowStatus.index+1)">plan-cell-today</s:if>
									<s:elseif test="(#rowStatus.index<selectedMonth.maxDays)&&(selectedMonth.firstWeekday+#rowStatus.index+1)%7<2">plan-cell-weekend</s:elseif>"
									><s:if test="%{#rowStatus.index<selectedMonth.maxDays}">
										<span>${rowStatus.index+1}</span>
									</s:if> <s:else>
					/
				</s:else></td>
							</s:iterator>
							<td rowspan="2" colspan="1"><s:text
									name="labels.plan.total.count" /></td>
							<td rowspan="2" colspan="1"><s:text
									name="labels.plan.total.unit" /></td>
						</tr>
						<tr>
							<td><s:text name="labels.plan.time.start" /></td>
							<td><s:text name="labels.plan.time.end" /></td>
							<td><s:text name="labels.plan.date.week" /></td>
							<s:iterator value="selectedMonth.days" status="rowStatus">
								<td
									class="<s:if test="isToday(searchServiceYm, #rowStatus.index+1)">plan-cell-today</s:if>
									<s:elseif test="(#rowStatus.index<selectedMonth.maxDays)&&(selectedMonth.firstWeekday+#rowStatus.index+1)%7<2">plan-cell-weekend</s:elseif>"
									><s:if test="%{#rowStatus.index<selectedMonth.maxDays}">
										<span> <s:text
												name="labels.date.week.short.%{(selectedMonth.firstWeekday+#rowStatus.index)%7}" />
										</span>
									</s:if> <s:else>
					/
				</s:else></td>
							</s:iterator>
						</tr>
					</table>
				</div>
				<div class="plan-content-box ">
					<s:form id="form_list" action="plan!bulkDelete">
						<input id="startDay" name="startDay" type="hidden"></input>
						<input id="stopDay" name="stopDay" type="hidden"></input>
						<table class="plan-header plan-content">
							<s:iterator value="achievements" status="rowStatus">
								<tr>
									<td rowspan="2"><input name="keys" type="checkbox"
										value="${key}" /></td>
									<td rowspan="2"><s:property
											value="%{convertToVerticalHtml(textTimeStart)}"
											escape="false" /></td>
									<td rowspan="2"><s:property
											value="%{convertToVerticalHtml(textTimeEnd)}" escape="false" /></td>
									<td rowspan="2"><s:property
											value="%{convertToVerticalHtml(serviceName)}" escape="false" /></td>
									<td><s:text name="labels.plan.cell.plan" /></td>
									<s:iterator value="selectedMonth.days" status="cellStatus">
										<td
											class="<s:if test="isToday(searchServiceYm, #cellStatus.index+1)">plan-cell-today</s:if>
											<s:elseif test="(#cellStatus.index<selectedMonth.maxDays)&&(selectedMonth.firstWeekday+#cellStatus.index+1)%7<2">plan-cell-weekend</s:elseif>"
											onclick="modifyEventItemData( this,
											'${planEventIds[cellStatus.index]}', 1, '${timeStart}',
											'${timeEnd}', '${serviceCode}', '${searchServiceYm}',
											${cellStatus.index+1} )" class="plan" >
											${servicePlanDate[cellStatus.index]}
										</td>
									</s:iterator>
									<td><s:property
											value="%{convertToVerticalHtml(servicePlanCount)}"
											escape="false" /></td>
									<td><s:property
											value="%{convertToVerticalHtml(servicePlanUnitTotal)}"
											escape="false" /></td>
								</tr>
								<tr>
									<td><s:text name="labels.plan.cell.achievement" /></td>
									<s:iterator value="selectedMonth.days" status="cellStatus">
										<td
											class="<s:if test="isToday(searchServiceYm, #cellStatus.index+1)">plan-cell-today</s:if>
											<s:elseif
												test="(#cellStatus.index<selectedMonth.maxDays)&&(selectedMonth.firstWeekday+#cellStatus.index+1)%7<2">plan-cell-weekend</s:elseif>"
											onclick="modifyEventItemData(this,
											'${actualEventIds[cellStatus.index]}', 2)" class="actual" >
											${serviceActualDate[cellStatus.index]}
										</td>
									</s:iterator>
									<td><s:property
											value="%{convertToVerticalHtml(serviceActualCount)}"
											escape="false" /></td>
									<td><s:property
											value="%{convertToVerticalHtml(serviceActualUnitTotal)}"
											escape="false" /></td>
								</tr>
							</s:iterator>
						</table>
					</s:form>
				</div>
			</td>
		</tr>
		<tr class="footer">
			<td class="total" colspan="1">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2"><s:text name="labels.plan.total.offic.title" />
						</td>
					</tr>
					<tr>
						<td><s:text name="labels.plan.total.offic.plan" /> <s:text
								name="labels.separator.label" /></td>
						<td align="right">${total.textOfficePlanTotal}<s:text
								name="labels.plan.total.label.unit" />
						</td>
					</tr>
					<tr>
						<td><s:text name="labels.plan.total.offic.achievement" /> <s:text
								name="labels.separator.label" /></td>
						<td align="right">${total.textOfficeActualTotal}<s:text
								name="labels.plan.total.label.unit" />
						</td>
					</tr>
				</table> <br /> <br />
			</td>
			<td class="buttons" colspan="4">
				<table border="0" width="100%">
					<tr>

						<%-- <td><input type="button" class="button2-action"
							value="<s:text name="labels.button.delete" />"
							onclick="bulkDelete();" style="width: 150px;" /></td> --%>
						<td><input type="button" class="button2-action"
							value="<s:text name="labels.button.delete.service" />"
							onclick="bulkServiceDelete();" style="width: 150px;" /></td>

						<td align="right" width="10%"><img
							src="<s:url value='/images/p2/button_add.png'/>" width="32"
							style="margin-right: 27px;" /> <br /> <a
							href="javascript:void(0)" onclick="createEventItemData();"
							class="link-action2">利用者別作成</a></td>
						<td align="right" width="10%"><img
							src="<s:url value='/images/p2/button_week.png'/>" width="32"
							style="margin-right: 27px;" /> <br /> <s:a
								href="javascript:importWeek();" cssClass="link-action2">
								<s:text name="labels.button.week.import" />
							</s:a></td>
						<td align="right" width="10%"><img
							src="<s:url value='/images/p2/button_upload.png'/>" width="32"
							style="margin-right: 17px;" /> <br /> <s:a
								href="javascript:uploadCSV();" cssClass="link-action2">
								<s:text name="labels.button.plan.import" />
							</s:a></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
