<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="initial-scale=1.0, office-scalable=no">
<meta charset="utf-8">
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/validate.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<script language="JavaScript">
	j$(document)
			.ready(
					function() {
						var id = <s:text name="id"/>;
						function checkTypeCode() {
							if (!checkEmpty(j$("#typeCode"),
									"<s:text name='errors.service.typecode.required'/>"))
								return false;
							if (j$("#typeCode").val().length != 2)
								return false;
							return true;
						}

						function checkItemCode() {
							if (!checkEmpty(j$("#itemCode"),
									"<s:text name='errors.service.itemcode.required'/>"))
								return false;
							if (!checkNumber(j$("#itemCode"),
									"<s:text name='errors.service.itemcode.formaterror'/>"))
								return false;
							return true;
						}

						function checkName() {
							if (!checkEmpty(j$("#name"),
									"<s:text name='errors.service.name.required'/>"))
								return false;
							if(!checkLength(j$("#name"),"<s:text name='errors.service.name.lengtherror'/>",0,30))
								return false;
							return true;
						}

						function checkNameShort() {
							if (!checkEmpty(j$("#shortName"),
									"<s:text name='errors.service.shortname.required'/>"))
								return false;
							if(!checkLength(j$("#shortName"),"<s:text name='errors.service.name.lengtherror'/>",0,15))
								return false;
							return true;
						}
						function checkUnitTotal() {
							if (!checkEmpty(j$("#unitTotal"),
									"<s:text name='errors.service.unitTotal.required'/>"))
								return false;
							return true;
						}

						function checkForm() {
							if (!checkTypeCode())
								return false;
							if (!checkItemCode())
								return false;
							if (!checkName())
								return false;
							if (!checkNameShort())
								return false;
							if (!checkUnitTotal())
								return false;
							return true;
						}

						j$("#service_form").submit(function() {
							if (checkForm())
								return true;
							alert("<s:text name='errors.common.required'/>");
							return false;
						});
						
						//在登陆按钮按下的时候，统一检测
						/* j$("#typeCode").blur(checkTypeCode);
						j$("#itemCode").blur(checkItemCode);
						j$("#name").blur(checkName);
						j$("#shortName").blur(checkNameShort);
						j$("#unitTotal").blur(checkUnitTotal); */
					});
</script>
<s:head />
</head>
<body>

	<s:form id="service_form">
		<s:hidden name="id" id="id" />
		<s:hidden name="active" id="active"/>
		<table width="100%" class="edit-box" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td class="edit-header"><s:if test="code==null">
						<img src="<s:url value='/images/button_create_16.png'/>"
							class="action-icon" />
						<s:text name="labels.service.title.add" />
					</s:if> <s:else>
						<img src="<s:url value='/images/button_edit_16.png'/>"
							class="action-icon" />
						<s:text name="labels.service.title.edit" />
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
						<!-- typeCode -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.code.type" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:if
									test='code==null'>
									<s:textfield name="typeCode" id="typeCode"
										cssStyle="width:150px;" cssClass="disable-ime" maxlength="2"
										onkeyup="value=value.replace(/[\W]/g, '')" />
								</s:if> <s:else>
									<s:textfield name="typeCode" id="typeCode"
										cssStyle="width:150px;background-color:#a1a1a1;"
										cssClass="disable-ime" maxlength="2" readonly="true" />
								</s:else> <ies:requiredflag /></td>
						</tr>
						<!-- itemCode -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.code.item" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:if
									test='code==null'>
									<s:textfield name="itemCode" id="itemCode"
										cssStyle="width:150px;" cssClass="disable-ime" maxlength="4"
										readonly="false" onkeyup="value=value.replace(/[^\d]/g, '')" />
								</s:if> <s:else>
									<s:textfield name="itemCode" id="itemCode"
										cssStyle="width:150px;background-color:#a1a1a1;"
										cssClass="disable-ime" maxlength="4" readonly="true" />
								</s:else> <ies:requiredflag /></td>
						</tr>
						<!-- serviceCodeFake -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.code.true" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="fakeCode" id="fakeCode"
									cssStyle="background-color:lightGray; width:150px;"
									cssClass="disable-ime" maxlength="6"
									onkeyup="value=value.replace(/[\W]/g, '')" /><%-- <span
								style="font-size: 10px;">(必要な状況に入力して。)</span> --%></td>
						</tr>
						<!-- name -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.name" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="name" id="name" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="30" /> <ies:requiredflag /></td>
						</tr>
						<!-- shortName -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.name.short" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="shortName" id="shortName" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="15" /> <ies:requiredflag /></td>
						</tr>
						<!-- unitTotal -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.unit.total" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="unitTotal" id="unitTotal" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="6"
									onkeyup="value=value.replace(/[^\d]/g, '')" /> <ies:requiredflag /></td>
						</tr>
						<!-- totalType -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.service.cal.type" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:select name="totalType"
									id="totalType" cssStyle="width:150px;"
									list="#{0:'月単位計算',1:'日割り計算'}" listKey="key" listValue="value"
									value="totalType"></s:select> <ies:requiredflag /></td>
						</tr>
						<!-- officeCode -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.office.name" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:select
									id="officeCode" name="officeCode" cssStyle="width:200px;"
									list="officeList" listKey="officeCode" listValue="officeName"
									headerKey="0000000000" headerValue="すべて" /> <ies:requiredflag /></td>
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
				<td class="edit-button"><s:if test="code==null">
						<s:submit key="labels.button.update" action="service!save"
							cssClass="button2-action" name="update" id="update" />
					</s:if> <s:else>
						<s:submit key="labels.button.update" action="service!update"
							cssClass="button2-action" name="update" id="update" />
					</s:else> <s:url id="url" action="service!cancel.ies" includeParams="none"
						namespace="/" /> <input type="button" id="cancel" name="cancel"
					value="<s:text name="labels.button.cancel"/>" class="button-cancel"
					onclick="window.location=iesAddToken('${url}')" /></td>
			</tr>
		</table>
	</s:form>
</body>
</html>
