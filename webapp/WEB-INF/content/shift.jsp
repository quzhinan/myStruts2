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
<s:head />
<script language="javascript">

	var clear_message_timer = null;
	var http_post_is_busying = false;
	var send_data_undo_buffer = new Array();
	
	var events_plan_data = [
	<s:iterator value="events" status="rowStatus">
		<s:if test="#rowStatus.index>0">
			,
		</s:if>
	{
		"id": ${schedule.id},	/* modify display date plan -> schedule */
		"serviceCode": "${schedule.service.code}",
		"serviceName": "${schedule.service.shortName}",
		"day": "${schedule.intServiceDay}",
		"timeStart": "${schedule.textTimeStart}",
		"timeEnd": "${schedule.textTimeEnd}",
		<s:if test="schedule.helper!=null">
			"helperId": ${schedule.helper.id},
			"helperCode": "${schedule.helper.userCode}",
			"helperName": "${schedule.helper.userName}",
		</s:if>
		<s:else>
			"helperId": 0,
			"helperCode": "",
			"helperName": "",
		</s:else>
		<s:if test="schedule.follower!=null">
			"followerId": ${schedule.follower.id},
			"followerCode": "${schedule.follower.userCode}",
			"followerName": "${schedule.follower.userName}",
		</s:if>
		<s:else>
			"followerId": 0,
			"followerCode": "",
			"followerName": "",
		</s:else>
	}
	</s:iterator>];

	var window_prev_frame = {width: 0, height: 0};
	
	j$(function (){
		for (var i=0; i<events_plan_data.length; i++) {
			var plan = events_plan_data[i];
			var cell = j$("#plan_cell_" + plan.day);
			var item = j$("<div id='plan_" + plan.id + "' scheduleId='" + plan.id + "'></div>").addClass("plan-item");
			item.append(j$("<div time1></div>").html(plan.timeStart));
			item.append(j$("<div time2></div>").html("-" + plan.timeEnd));
			item.append(j$("<div service></div>").html(plan.serviceName));
			item.append(j$("<div helper helperId='" + plan.helperId + "'></div>").html(plan.helperName.replace("　", "").replace(" ", "")));
			item.append(j$("<div follower helperId='" + plan.followerId + "'></div>").html(plan.followerName.replace("　", "").replace(" ", "")));
			item.appendTo(cell);
		}
		
		j$(".plan-item div[helper], .plan-item div[follower]").click(function(){
			
			j$("#warning_messager").html("");
			
			var scheduleId = j$(this).parent().attr("scheduleId");
			var type = j$(this).is("div[helper]") ? 1 : 2;
			var helperId = 0;
			
			var selector = j$(".helper-box .item[selected]");
			if (selector.length > 0) {
				selector = j$(selector[0]);
				if (j$(this).attr("helperId") != selector.attr("helperId")) {
					helperId = j$(selector[0]).attr("helperId");
				}
			}
			
			setHelper(type, scheduleId, helperId, false);
		});
		
		j$(".helper-box .item").click(function(){
			if (!j$(this).is("[selected]")) {
				j$(".helper-box .item").removeAttr("selected");
				j$(this).attr("selected", "");
			} else {
				j$(this).removeAttr("selected");
			}
		});

		j$(window).resize(function(){
			resizeTagsFrame();
		});
		resizeTagsFrame();
		
		scrollToShowItem("box_customer_item_${customerId}", "box_customer_list");
	});

	/* resize tags frame */
	function resizeTagsFrame() {

		if (j$(window).height() != window_prev_frame.height || j$(window).width() != window_prev_frame.width) {
			window_prev_frame.height = j$(window).height();
			window_prev_frame.width = j$(window).width();
			var height = window_prev_frame.height-240;
			var width = window_prev_frame.width-460;
			if (height < 460) height = 460;
			if (width < 790) width = 790;
			var unit = parseInt((width-50)/7) - 1;
			j$("div.shift-title").width(width);
			j$("div.shift-box").height(height);
			j$("div.shift-box").width(width);
			j$("#box_customer_list").height(height);
			j$("div.helper-box").height(height);
			j$("div.shift-title td").width(unit);
			j$("div.shift-box td.plan-cell").width(unit);
			j$("div.shift-box div.plan-item div[service]").width(unit-63);
			j$("div.shift-box div.plan-item div[helper]").width((unit-2)/2);
			j$("div.shift-box div.plan-item div[follower]").width((unit-2)/2);
		}
	}
	
	function setHelper(type, scheduleId, helperId, isUndo) {	// type 1:helper, 2:follower
		if (http_post_is_busying == true) return;
	
		var url = '<s:url action="shift" includeParams="none" namespace="/js" />';
		j$.post(url, {"type": type, "scheduleId": scheduleId, "helperId": helperId}, function(data){
					if (data.result == "success") {
						
						j$("#warning_messager").attr("type", "msg");
						var helperItem = null
						var helperData = null;
						if (type == 1) {
							helperItem = j$("#plan_" + scheduleId + " div[helper]");
							helperData = data.schedule.helper;
						} else {
							helperItem = j$("#plan_" + scheduleId + " div[follower]");
							helperData = data.schedule.follower;
						}

						if (isUndo == true) {
							send_data_undo_buffer.pop();
							if (send_data_undo_buffer.length == 0) {
								j$("#buttonUndoHelper").hide();
							}
						} else {
							send_data_undo_buffer.push({
								"type": type, 
								"scheduleId": scheduleId, 
								"helperId": helperItem.attr("helperId")
								});
							j$("#buttonUndoHelper").show();
						}
						
						if (helperData == null) {
							helperItem.attr("helperId", "");
							helperItem.text("");
						} else {
							helperItem.attr("helperId", helperData.id);
							helperItem.text(helperData.userName.replace("　", "").replace(" ", ""));
						}
						clearMessageAfter(1);
					} else {
						j$("#warning_messager").attr("type", "err");
						clearMessageAfter(5);
					}
					j$("#warning_messager").html(data.message);
				}, "json")
				.done(function(){
					http_post_is_busying == true;
				})
				.fail(function(){
					window.location = iesAddToken(window.location.toString());
				})
				.always(function(){
					http_post_is_busying == false;
				});
	}
	
	function clearMessageAfter(interval) { // unit is second
		if (clear_message_timer != null) {
			clearTimeout(clear_message_timer);
		}
		clear_message_timer = setTimeout(clearMessageAndTimer, interval * 1000);
	}
	
	function clearMessageAndTimer() {
		j$("#warning_messager").html("");
		clear_message_timer = null;
	}
	
	function undoSetHelper() {
		if (send_data_undo_buffer.length > 0) {
			var data = send_data_undo_buffer[send_data_undo_buffer.length - 1];
			setHelper(data.type, data.scheduleId, data.helperId, true);
		}
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
	
	j$(function(){

		j$("#downloadPdfShiftDialog").dialog({
			title: "利用者別月間シフト印刷",
			autoOpen: false,
			resizable: false,
			modal: true,
			width: 400,
			height: 300,
			buttons:[
						{
							text: "ダウンロード", 
							click: function(){
								j$(this).dialog("close");
								var url = '<s:url action="pdf-download!customerMonthShift" includeParams="none" namespace="/" />';
								var param = {};
								if(j$("#downloadPdfShift_CustomerCode").val() == null){
									param["customerId"] = $("0").val();
								}else{
									param["customerId"] = j$("#downloadPdfShift_CustomerCode").val();
								}
								
								param["selectedYM"] = j$("#downloadPdfShift_searchServiceYm").val();
								
								url += "?customerId=" + param["customerId"] + "&selectedYM=" + param["selectedYM"];
								window.location = iesAddToken(url);
								/*j$.post(url, param, function(data){
								}, "json");*/
							}
						},
						{
							text: "閉じる", 
							click: function(){
								j$(this).dialog("close");
							}
						}
			         ]
		});
	});
	
	function downloadPdfShift() {
		j$("#downloadPdfShiftDialog").dialog("open");
	}
		
</script>
</head>
<body>
	<table class="page-content page-content-nofooter shift-content" border="0">
		<s:form id="form_search" action="shift">
		<tr class="header">
			<td class="search">
				<input type="text" name="searchCustomerName" value="${searchCustomerName}" maxlength="30" placeholder="<s:text name="labels.button.search.name" />" />
				<img src="<s:url value='/images/button_page_search.png'/>" border="0" onclick="submitForm();"/>
			</td>
			<td class="warning" colspan="2">
				<div id="warning_messager" class="warning-box"></div>
			</td>
			<td class="title" >
				<s:if test="customerName != null">
					&nbsp;
					<a id="buttonUndoHelper" href="javascript:void(0)" onclick="undoSetHelper();" style="display:none;font-size:15px;">UNDO</a>
					&nbsp;
					<s:text name="labels.plan.title.customer">
						<s:param>${customerName}</s:param>
					</s:text>
				</s:if>
			</td>
			<td class="date">
					<table><tr>
						<td>
						</td>
						<td>
							<a href="javascript:void(0);" onclick="changeSelectedYm('${prevMonthKey}');">
								<img src="<s:url value='/images/p2/button_left.png'/>" width="22" style="margin:3px 5px 0 0;" />
							</a>
						</td>
						<td>
							<s:select id="searchServiceYm" name="searchServiceYm" list="yearMonths" listKey="key" listValue="label" 
								cssStyle="font-size:15px;" value="searchServiceYm" onchange="submitForm();"></s:select> 
						</td>
						<td>
							<a href="javascript:void(0);" onclick="changeSelectedYm('${nextMonthKey}');">
								<img src="<s:url value='/images/p2/button_right.png'/>" width="22" style="margin:3px 0 0 5px;" />
							</a>
						</td>
					</tr></table>
			</td>
		</tr>
		</s:form>
		<tr class="content">
			<td class="list">
				<div id="box_customer_list" class="list-box">
<ul>
	<s:iterator value="customers" status="rowStatus">
		<s:url id="url" action="shift" includeParams="none" namespace="/" >
			<s:param name="customerId" value="id"/>
		</s:url>
		<li id="box_customer_item_${id}" onclick="window.location=iesAddToken('${url}')" <s:property value="id==customerId?'selected':''"/>>${customerName}</li>
	</s:iterator>
</ul>
				</div>
				<div style="padding:8px;" align="center" >
				<s:a href="javascript:downloadPdfShift();"
					style="text-decoration:underline; cursor:pointer;">
					利用者別月間シフト印刷
				</s:a>
				</div>
				
			</td>
			
			<td class="grid" colspan="3">
				<div class="shift-title">
<table>
	<tr>
<s:iterator value="new int[7]" status="rowStatus">
		<td class="plan-title"><s:text name="labels.date.week.short.%{#rowStatus.index}" /></td>
</s:iterator>
	</tr>
</table>
				</div>
				<div class="shift-box">
<table>
	<tr>
<s:iterator value="new int[selectedMonthWeeks*7]" status="rowStatus">
	<s:if test="#rowStatus.index>0 && #rowStatus.index%7==0">
		</tr>
		<tr>
	</s:if>
	<s:set name="dayNumber" value="%{#rowStatus.index-selectedMonth.firstWeekday+1}" />
	<s:if test="#dayNumber>0 && #dayNumber<=selectedMonth.maxDays">
		<td id="plan_cell_${dayNumber}" 
			class="plan-cell 
				   <s:if test="isToday(searchServiceYm, #dayNumber)">plan-cell-today</s:if>
				   <s:if test="(#rowStatus.index+1)%7<2">plan-cell-weekend</s:if> 
				   "
		><div class="plan-day">${dayNumber}</div></td>
	</s:if>
	<s:else>
		<td>&nbsp;</td>
	</s:else>
</s:iterator>
	</tr>
</table>
				</div>
			</td>
			<td class="items">
				<div class="helper-box">
<s:iterator value="helpers" status="rowStatus">
	<div class="item" helperId="${id}">
		<span>${userCodeShort}</span><br/><span helper>${userName}</span>
	</div>
</s:iterator>
				</div>
			</td>
		</tr>
	</table>
	<div id="downloadPdfShiftDialog">
		<table cellpadding="8" style="padding:10px;">
			<tr>
				<td>
					利用者：
				</td>
				<td>
				<s:select id="downloadPdfShift_CustomerCode"
						cssStyle="width:160px;" list="customers"
						listKey="id" listValue="customerName"
						value="customerId" />
				</td>
			</tr>
			<tr>
				<td>
					サービス年月：
				</td>
				<td>
				
				<s:select id="downloadPdfShift_searchServiceYm"
						list="yearMonths" listKey="key" listValue="label" value="searchServiceYm"></s:select> 
				</td>
			</tr>
		</table>
	</div>
	
</body>
</html>
