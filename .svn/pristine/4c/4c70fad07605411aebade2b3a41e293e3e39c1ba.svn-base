<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<link type="text/css" href="<s:url value='/styles/validate.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<script language="JavaScript">
		j$(document).ready(function() {
			function checkPreViewTime() {
				if (!checkEmpty(j$("#beginTime"),"数値を入力してください。"))
					return false;
				if (!checkNumber(j$("#beginTime"),"数値を入力してください。"))
					return false;
				return true;
			}

			function checkAfterViewTime() {
				if (!checkEmpty(j$("#endTime"),"数値を入力してください。"))
					return false;
				if (!checkNumber(j$("#endTime"),"数値を入力してください。"))
					return false;
				return true;
			}
			
			function checkRadius() {
				if (!checkEmpty(j$("#radius"),"数値を入力してください。"))
					return false;
				if (!checkNumber(j$("#radius"),"数値を入力してください。"))
					return false;
				return true;
			}
			
			function checkForm() {
				if (!checkPreViewTime())
					return false;
				if (!checkAfterViewTime())
					return false;
				if (!checkRadius())
					return false;
				return true;
			}
			
			j$("#master").submit(function() {
				if (checkForm()){
					alert("登録は完了しました。");
					return true;
				} else {
					alert("<s:text name='errors.common.required'/>");
					return false;
				}
			});
			
			j$("#beginTime").blur(checkPreViewTime);
			j$("#endTime").blur(checkAfterViewTime);
			j$("#radius").blur(checkRadius);
		});
</script>

<s:head />


</head>
<body>
	<s:form action="master">
	<table width="100%" class="edit-box" border="0" cellpadding="0" cellspacing="0" style="height:200px;">
		<tr>
			<td class="edit-header">
            	<img src="<s:url value='/images/button_edit_16.png'/>" class="action-icon" />
				<s:text name="labels.master.edit.title"/>
			</td>
		</tr>
		<tr>
			<td class="edit-error">
				<s:actionerror/>
				<s:fielderror/>
				<ul id="validateTips"></ul>
			</td>
		</tr>
		<tr>
			<td class="edit-data" align="center">			
				<table width="60%" class="edit-data-box" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="label" nowrap="nowrap">
							事前開始時間（分）
							<s:text name="labels.separator.label"/>
						</td>
						<td class="input" nowrap="nowrap">
							<s:textfield name="beginTime" id="beginTime" cssStyle="width:100px;" cssClass="disable-ime" maxlength="8" onkeyup="value=value.replace(/[^\d]/g, '')"/>
							<ies:requiredflag/>
						</td>
					</tr>
				
					<tr>
						<td class="label" nowrap="nowrap">
							終了後入力可能時間（分）
							<s:text name="labels.separator.label"/>
						</td>
						<td class="input" nowrap="nowrap">
							<s:textfield name="endTime" id="endTime" cssStyle="width:100px;" cssClass="disable-ime" maxlength="8" onkeyup="value=value.replace(/[^\d]/g, '')"/>
							<ies:requiredflag/>
						</td>
					</tr>
					
					<tr>
						<td class="label" nowrap="nowrap" >
							許容範囲（ｍ）
							<s:text name="labels.separator.label"/>
						</td>
						<td class="input" nowrap="nowrap">
							<s:textfield name="radius" id="radius" cssStyle="width:100px;" cssClass="disable-ime" maxlength="6" onkeyup="value=value.replace(/[^\d]/g, '')"/>
							<ies:requiredflag/>
						</td>
					</tr>

					<tr>
						<td colspan="2" nowrap="nowrap" style="padding: 15px 0px 0px 180px;font-size: 9pt; color: red;">
							<s:text name="labels.symbol.star.explain"/>
						</td>
					</tr>
				</table>
				

			</td>
		</tr>
		<tr>
			<td class="edit-button">
				<s:submit key="labels.button.update" action="master!update" cssClass="button2-action" name="update" id="update"/>
			</td>
		</tr>
	</table>
	</s:form>
<table class="menuTable" border="0"><tr>
<td></td>
<td></td>
</tr></table>
</body>
</html>
