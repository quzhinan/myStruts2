<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html>
<head>
<meta name="viewport" content="initial-scale=1.0, customer-scalable=no">
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/jquery.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/validate.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/jquery.ui.mouse.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/jquery.ui.draggable.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/jquery.ui.position.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/jquery.ui.resizable.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/jquery.ui.dialog.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/ajaxFileUploader/ajaxfileupload.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>

<script language="JavaScript">
	j$(function() {
		var id = <s:text name="id"/>;
		function checkCustomer() {
			if (!checkEmpty(j$("#customerId"),
					"<s:text name='errors.customer.choose.required'/>"))
				return false;
			return true;
		}

		function checkWeekFlag() {
			if (!checkEmpty(j$("#weekFlag"),
					"<s:text name='errors.week.flag.code.required'/>"))
				return false;
			return true;
		}

		function checkService() {
			if (!checkEmpty(j$("#serviceCode"),
					"<s:text name='errors.service.code.required'/>"))
				return false;
			return true;
		}

		function checkTime() {
			var startTime = parseInt(j$("[name='timeStartHour']").val()) * 60
					+ parseInt(j$("[name='timeStartMinute']").val());
			var endTime = parseInt(j$("[name='timeEndHour']").val()) * 60
					+ parseInt(j$("[name='timeEndMinute']").val());

			var serviceTime1 = parseInt(j$("[name='serviceTime1']").val());
			var serviceTime2 = parseInt(j$("[name='serviceTime2']").val());
			var totalTime = endTime - startTime;

			if (!checkTimeEndBiggerThanTimeStart(j$("[name='timeStartHour']"),
					startTime, endTime,
					"<s:text name='messages.js.plan.input.time'/>"))
				return false;
			if (!checkTimeCorrect(j$("[name='serviceTime1']"), totalTime,
					serviceTime1, serviceTime2,
					"<s:text name='errors.common.time.not.equals.week'/>"))
				return false;
			return true;
		}

		/* function checkHelper() {
			if (!checkEmpty(j$("#helperId"),
					"<s:text name='errors.helper.choose.required'/>"))
				return false;
			return true;
		} */

		function checkFollower() {
			if (j$("#helperId").val() == 0 && j$("#followerId").val() == 0) {
				return true;
			}
			if (!checkMustNotSame(j$("#helperId"), j$("#followerId"),
					"<s:text name='messages.js.plan.helper.same'/>"))
				return false;
			return true;
		}

		function checkForm() {
			if (!checkCustomer())
				return false;
			if (!checkWeekFlag())
				return false;
			if (!checkService())
				return false;
			if (!checkTime())
				return false;
			/* if (!checkHelper())
				return false; */
			if (!checkFollower())
				return false;
			return true;
		}

		j$("#week").submit(function() {
			if (checkForm())
				return true;
			alert("<s:text name='errors.common.required'/>");
			return false;
		});

		j$("#customerId").change(checkCustomer);
		j$("#weekFlag").blur(checkWeekFlag);
		j$("#serviceCode").change(checkService);

		/* j$("#helperId").change(checkHelper);
		j$("#followerId").change(checkFollower); */
	});

	function splitAddress(address) {
		var array = address.split('\\');
		return array[array.length - 1];
	}

	function uploadFileChange(num) {
		var uploadFileName = "uploadFileName" + num;
		var uploadcataFile = "uploadcataFile" + num;
		j$("#" + uploadFileName).val(
				splitAddress(j$("#" + uploadcataFile).val()));
	}

	function reCountEndTime() {
		var startTime = parseInt(j$("[name='timeStartHour']").val()) * 60
				+ parseInt(j$("[name='timeStartMinute']").val());
		var endTime = parseInt(j$("[name='timeEndHour']").val()) * 60
				+ parseInt(j$("[name='timeEndMinute']").val());

		var serviceTime1 = parseInt(j$("[name='serviceTime1']").val());
		var serviceTime2 = endTime - startTime - serviceTime1;
		if (serviceTime2 < 0) {
			serviceTime2 = 0;
		}
		j$("[name='serviceTime2']").val(serviceTime2);
	}
</script>
<s:head />
</head>
<body>

	<s:form id="week" action="customer">
		<s:hidden name="id" id="id" />
		<s:hidden name="active" id="active" />
		<table width="100%" class="edit-box" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td class="edit-header"><s:if test="id==0">
						<img src="<s:url value='/images/button_create_16.png'/>"
							class="action-icon" />
						<s:text name="labels.week.title.add" />
					</s:if> <s:else>
						<img src="<s:url value='/images/button_edit_16.png'/>"
							class="action-icon" />
						<s:text name="labels.week.title.edit" />
					</s:else></td>
			</tr>
			<tr>
				<td class="edit-error"><s:actionerror /> <s:fielderror />
					<ul id="validateTips"></ul></td>
			</tr>
			<tr>
				<td class="edit-data">
					<table width="100%" class="edit-data-box" border="0"
						cellpadding="0" cellspacing="0">

						<tr>
							<td class="label_long" nowrap="nowrap"><s:text
									name="labels.customer.name" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:if test="customer.id">
									<s:select id="customerId" name="customerId" value="customer.id"
										cssStyle="width:250px;" list="customers" listKey="id"
										listValue="customerName" headerKey="" headerValue="" />
								</s:if> <s:else>
									<s:select id="customerId" name="customerId"
										cssStyle="width:250px;" list="customers" listKey="id"
										listValue="customerName" headerKey="" headerValue="" />
								</s:else> <ies:requiredflag /></td>
						</tr>
						<!-- サービス開始 -->
						<tr>
							<td class="label_long" nowrap="nowrap">サービス実施曜日：</td>
							<td class="input" nowrap="nowrap"><s:select id="weekFlag"
									name="weekFlag" value="weekFlag" cssClass="item-data"
									style="width:100px;"
									list="#{1:'月曜日',2:'火曜日',3:'水曜日',4:'木曜日',5:'金曜日',6:'土曜日',7:'日曜日'}"
									listKey="key" listValue="value" headerKey="" headerValue="" />
								<ies:requiredflag /></td>
						</tr>
						<!-- 電子メール -->
						<s:set name="workTimeStart"
							value="%{getSystemOption('work.time.drop.start')}" />
						<s:set name="workTimeEnd"
							value="%{getSystemOption('work.time.drop.end')}" />
						<s:set name="workTimeStartUnit"
							value="%{getSystemOption('work.time.drop.start.unit')}" />
						<s:set name="workTimeStartUnitCount" value="60/#workTimeStartUnit" />
						<s:set name="workTimeEndUnit"
							value="%{getSystemOption('work.time.drop.end.unit')}" />
						<s:set name="workTimeEndUnitCount" value="60/#workTimeEndUnit" />
						<tr>
							<td class="label_long" nowrap="nowrap">サービス開始時刻<s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><select
								name="timeStartHour" class="item-data" style="width: 70px;"
								onchange="reCountEndTime();">
									<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]"
										status="rowStatus">
										<s:set name="testval"
											value="#workTimeStart*1+#rowStatus.index" />
										<option
											value="<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}"
											<s:if test="#testval==week.intTimeStartHour">selected</s:if>>
											&nbsp;
											<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}&nbsp;
										</option>
									</s:iterator>
							</select> &nbsp;：&nbsp; <select name="timeStartMinute" class="item-data"
								style="width: 70px;" onchange="reCountEndTime();">
									<s:iterator value="new int[#workTimeStartUnitCount]"
										status="rowStatus">
										<s:set name="testval"
											value="#rowStatus.index*#workTimeStartUnit" />
										<option
											value="<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeStartUnit}"
											<s:if test="#testval==week.intTimeStartMinute">selected</s:if>>
											&nbsp;
											<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeStartUnit}&nbsp;
										</option>
									</s:iterator>
							</select> <ies:requiredflag /></td>
						</tr>
						<tr>
							<td class="label_long" nowrap="nowrap">サービス終了時刻<s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><select name="timeEndHour"
								class="item-data" style="width: 70px;"
								onchange="reCountEndTime();">
									<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]"
										status="rowStatus">
										<s:set name="testval"
											value="#workTimeStart*1+#rowStatus.index" />
										<option
											value="<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}"
											<s:if test="#testval==week.intTimeEndHour">selected</s:if>>
											&nbsp;
											<s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}&nbsp;
										</option>
									</s:iterator>
							</select> &nbsp;：&nbsp; <select name="timeEndMinute" class="item-data"
								style="width: 70px;" onchange="reCountEndTime();">
									<s:iterator value="new int[#workTimeEndUnitCount]"
										status="rowStatus">
										<s:set name="testval"
											value="#rowStatus.index*#workTimeEndUnit" />
										<option
											value="<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeEndUnit}"
											<s:if test="#testval==week.intTimeEndMinute">selected</s:if>>
											&nbsp;
											<s:if test="#testval<10">0</s:if>${rowStatus.index*workTimeEndUnit}&nbsp;
										</option>
									</s:iterator>
							</select> <ies:requiredflag /></td>
						</tr>
						<tr>
							<td class="label_long" nowrap="nowrap">サービス内容<s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:if
									test="service.code != ''">
									<s:select id="serviceCode" name="serviceCode"
										value="service.code" cssStyle="width:250px;" list="services"
										listKey="code" listValue="name" headerKey="" headerValue="" />
								</s:if> <s:else>
									<s:select id="serviceCode" name="serviceCode"
										cssStyle="width:250px;" list="services" listKey="code"
										listValue="name" headerKey="" headerValue="" />
								</s:else> <ies:requiredflag />（ <s:textfield name="serviceTime1"
									cssClass="item-data" value="%{week.serviceTime1}"
									style="width:50px;" maxlength="3"
									onchange="this.value=(isNaN(parseInt(this.value))?'0':parseInt(this.value));reCountEndTime();" />
								分、 <s:textfield name="serviceTime2" cssClass="item-data"
									value="%{week.serviceTime2}" style="width:50px;" maxlength="3" />
								分 ）</td>
						</tr>

						<tr>
							<td class="label_long" nowrap="nowrap"><s:text
									name="labels.nursing.charger" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:if test="helper.id">
									<s:select id="helperId" name="helperId" value="helper.id"
										cssStyle="width:250px;" list="helpers" listKey="id"
										listValue="userName" headerKey="0" headerValue="" />
								</s:if> <s:else>
									<s:select id="helperId" name="helperId" cssStyle="width:250px;"
										list="helpers" listKey="id" listValue="userName" headerKey="0"
										headerValue="" />
								</s:else></td>
						</tr>
						<tr>
							<td class="label_long" nowrap="nowrap"><s:text
									name="labels.nursing.user.follow" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:if test="follower.id">
									<s:select id="followerId" name="followerId" value="follower.id"
										cssStyle="width:250px;" list="helpers" listKey="id"
										listValue="userName" headerKey="0" headerValue="" />
								</s:if> <s:else>
									<s:select id="followerId" name="followerId"
										cssStyle="width:250px;" list="helpers" listKey="id"
										listValue="userName" headerKey="0" headerValue="" />
								</s:else></td>
						</tr>
						<tr>
							<td colspan="3" nowrap="nowrap"
								style="padding: 15px 0px 0px 180px; font-size: 9pt; color: red;">
								<s:text name="labels.symbol.star.explain" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="edit-button"><s:if test="id==0">
						<s:submit key="labels.button.update" action="week!save"
							cssClass="button2-action" name="update" id="update" />
					</s:if> <s:else>
						<s:submit key="labels.button.update" action="week!update"
							cssClass="button2-action" name="update" id="update" />
					</s:else> <s:url id="url" action="week!cancel.ies" includeParams="none"
						namespace="/" /> <input type="button" id="cancel" name="cancel"
					value="<s:text name="labels.button.cancel"/>" class="button-cancel"
					onclick="window.location=iesAddToken('${url}')" /></td>
			</tr>
		</table>
	</s:form>

</body>
</html>
