<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<meta charset="utf-8">
	<title><s:text name="labels.header.title" /></title>
    <link type="text/css" href="<s:url value='/styles/event.css'/>" rel="stylesheet" media="all"/>
	<s:head />
<script language="javascript">
	function reCountEndTime() {
		var startTime = parseInt(j$("[name='timeStartHour']").val()) * 60 + parseInt(j$("[name='timeStartMinute']").val());
		var endTime = parseInt(j$("[name='timeEndHour']").val()) * 60 + parseInt(j$("[name='timeEndMinute']").val());
		var serviceTime1 = parseInt(j$("[name='serviceTime1']").val());
		var serviceTime2 = endTime - startTime - serviceTime1;
		if (serviceTime2 < 0) {
			serviceTime2 = 0;
		}
		j$("[name='serviceTime2']").val(serviceTime2);
	}
	function changeComment() {
		var customerId = j$("[name='customerId']").val();
		getComment(customerId);
	}
	function getComment(customerId) {
		var url = '<s:url action="comment!getCustomerComment" includeParams="none" namespace="/js" />';
		var itemData = new Object();
		itemData["id"] = customerId;
		j$.post(url, itemData, function(data) {
			if (data.result == "success") {
				j$("[name='commentContent']").val(data.comment);
			}
		}, "json").done(function() {
		}).fail(function() {
		}).always(function() {
		});
	}
	j$(document).ready(function() {
	
		var customerId = '<s:property value="defaultCustomerId" escapeHtml="false" escapeJavaScript="true"/>';
		var eventCustomerId = '<s:property value="event.customer.id" escapeHtml="false" escapeJavaScript="true"/>';
		if (eventCustomerId == 0) {
			if (customerId == -1) {
				getComment(j$("[name='customerId']").val());
			} else if (customerId != 0) {
				getComment(customerId);
			}
		}
	});
</script>
</head>
<body>
<div>
	<s:set name="workTimeStart" value="%{getSystemOption('work.time.drop.start')}" />
	<s:set name="workTimeEnd" value="%{getSystemOption('work.time.drop.end')}" />
	<s:set name="workTimeStartUnit" value="%{getSystemOption('work.time.drop.start.unit')}" />
	<s:set name="workTimeStartUnitCount" value="60/#workTimeStartUnit" />
	<s:set name="workTimeEndUnit" value="%{getSystemOption('work.time.drop.end.unit')}" />
	<s:set name="workTimeEndUnitCount" value="60/#workTimeEndUnit" />
	
	<s:hidden name="eventId" cssClass="item-data" value="%{event.id}"/>
	<s:hidden name="type" cssClass="item-data" value="%{item.type}"/>
	<s:hidden name="achievementExist" cssClass="item-data" value="%{achievementExist}"/>

	<table width="100%" cellpadding="5" cellspacing="0" border="0">
		<tr>
			<td colspan="2" style="text-align:left;"><div class="evt-message">&nbsp;</div></td>
		</tr>
		<tr>
			<td>利用者：</td>
			<td>
				<s:if test="event.customer.id">
					<s:select name="customerId" cssClass="item-data" list="customers" listKey="id" listValue="customerName" 
						value="event.customer.id" disabled="true"></s:select> 
					<s:textfield style="margin-left:-900px;"></s:textfield>
				</s:if>
				<s:else>
					<s:select name="customerId" cssClass="item-data" list="customers" listKey="id" listValue="customerName" 
						value="event.customer.id" onchange="changeComment()"></s:select> 
				</s:else>
			</td>
		</tr>
		<tr style="display:none;">
			<td>計画対象年月：</td>
			<td>
				<s:select name="serviceYm" cssClass="item-data" list="yearMonths" listKey="key" listValue="label" 
					value="event.serviceYm" cssStyle="width: 150px;"></s:select> 
			</td>
		</tr>
		<tr>
			<td>サービス実施日：</td>
			<td>
				<s:textfield name="serviceDate" cssClass="item-data" value="%{item.serviceDate}" style="width:100px;"/> 
			</td>
		</tr>
		<tr>
			<td>サービス開始時刻：</td>
			<td>
				<select name="timeStartHour" class="item-data" style="width: 70px;" onchange="reCountEndTime();">
					<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]" status="rowStatus">
						<s:set name="testval" value="#workTimeStart*1+#rowStatus.index" />
						<option value="<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}" <s:if test="#testval==item.intTimeStartHour">selected</s:if>>
							&nbsp;<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}&nbsp;
						</option>
					</s:iterator>
				</select>
				&nbsp;：&nbsp;
				<select name="timeStartMinute" class="item-data" style="width: 70px;" onchange="reCountEndTime();">
					<s:iterator value="new int[#workTimeStartUnitCount]" status="rowStatus">
						<s:set name="testval" value="#rowStatus.index*#workTimeStartUnit" />
						<option value="<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeStartUnit}" <s:if test="#testval==item.intTimeStartMinute">selected</s:if>>
							&nbsp;<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeStartUnit}&nbsp;
						</option>
					</s:iterator>
				</select>
			</td>
		</tr>
		<tr>
			<td>サービス終了時刻：</td>
			<td>
				<select name="timeEndHour" class="item-data" style="width: 70px;" onchange="reCountEndTime();">
					<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]" status="rowStatus">
						<s:set name="testval" value="#workTimeStart*1+#rowStatus.index" />
						<option value="<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}" <s:if test="#testval==item.intTimeEndHour">selected</s:if>>
							&nbsp;<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}&nbsp;
						</option>
					</s:iterator>
				</select>
				&nbsp;：&nbsp;
				<select name="timeEndMinute" class="item-data" style="width: 70px;" onchange="reCountEndTime();">
					<s:iterator value="new int[#workTimeEndUnitCount]" status="rowStatus">
						<s:set name="testval" value="#rowStatus.index*#workTimeEndUnit" />
						<option value="<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeEndUnit}" <s:if test="#testval==item.intTimeEndMinute">selected</s:if>>
							&nbsp;<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeEndUnit}&nbsp;
						</option>
					</s:iterator>
				</select>
			</td>
		</tr>
		<tr>
			<td>サービス内容：</td>
			<td>
				<s:select name="serviceCode" cssClass="item-data" list="services" listKey="code" listValue="shortName" 
					value="item.service.code" cssStyle="width: 250px;"></s:select> 
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				（
				<s:textfield name="serviceTime1" cssClass="item-data" value="%{item.serviceTime1}" style="width:50px;" maxlength="3" onchange="this.value=(isNaN(parseInt(this.value))?'0':parseInt(this.value));reCountEndTime();"/> 
				分、
				<s:textfield name="serviceTime2" cssClass="item-data" value="%{item.serviceTime2}" style="width:50px;" maxlength="3"/>
				分
				）
			</td>
		</tr>
		<tr>
			<td>担当（主）：</td>
			<td>
				<s:select name="helperId" cssClass="item-data" list="helpers" listKey="id" listValue="userName" 
					value="item.helper.id" headerKey="0" headerValue=""></s:select> 
			</td>
		</tr>
		<tr>
			<td>担当（同行）：</td>
			<td>
				<s:select name="followerId" cssClass="item-data" list="helpers" listKey="id" listValue="userName" 
					value="item.follower.id" headerKey="0" headerValue=""></s:select> 
			</td>
		</tr>
		<tr style="display:none;">
			<td>移動時間（分）：</td>
			<td>
				<s:textfield name="travelTime" cssClass="item-data" value="%{item.travelTime}" style="width:100px;" maxlength="4" onchange="this.value=(isNaN(parseInt(this.value))?'0':parseInt(this.value))"/> 
			</td>
		</tr>
		<tr>
			<td>加算チェック（初回）：</td>
			<td>
				<s:checkbox name="additionFirst" cssClass="item-data" value="%{item.additionFirst}" fieldValue="1"/>
			</td>
		</tr>
		<tr>
			<td>加算チェック（緊急）：</td>
			<td>
				<s:checkbox name="additionEmergency" cssClass="item-data" value="%{item.additionEmergency}" fieldValue="1"/>
				<script>
					j$("[name^=addition]").click(function() {
						if (j$(this).is(":checked")) {
							j$("[name^=addition]:not([name=" + j$(this).attr("name") + "])").attr("checked", false);
						}
					});
				</script>
			</td>
		</tr>
		<tr <s:if test="item.type==1">style="display:none;"</s:if>>
			<td>担当への連絡事項：</td>
			<td>
				<s:textfield name="remark" cssClass="item-data" value="%{event.remark}" style="width:300px;" maxlength="45"/> 
			</td>
		</tr>
		<tr>
			<td>指示項目：</td>
			<td>
				<s:textarea name="commentContent" cssClass="item-data" value="%{item.commentContent}" style="width:350px;height: 45px;" maxlength="100"/>
			</td>
		</tr>
		<s:if test="event.id==0&&item.type==1">
		<tr>
			<td colspan="2" style="height:10px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<s:checkbox name="doLoop" cssClass="item-data" value="0" fieldValue="1"/>
				今月末まで曜日より、繰り返しを作成します。
			</td>
		</tr>
		</s:if>
	</table>
</div>
</body>
</html>
