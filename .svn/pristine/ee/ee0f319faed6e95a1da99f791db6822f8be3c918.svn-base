<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html>
<head>
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/list.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript">
	var tableIdentifier = 0;
	var dialogTitle = "利用者"
	function bulkDeletecustomer() {
		if (j$("input[name='ids']:checked").length > 0) {
			if (confirm('<s:text name="messages.customer.delete.confirm"/>') == true) {
				j$("#listForm").submit();
			}
		} else {
			alert('<s:text name="errors.customer.delete.record.required"/>');
		}
	}

	function confirmDeletecustomer() {
		var resultConfirm = confirm('<s:text name="messages.customer.delete.confirm"/>');
		if (resultConfirm == false) {
			isACancelClicked = true;
		}
		return resultConfirm;
	}
	j$(document).ready(function() {
		var cbList = j$("#listForm input:checkbox");
		for (var i = 1; i < cbList.length; i++) { //skip the first checkbox
			j$(cbList[i]).click(function() {
				var cbList2 = j$("#listForm input:checkbox");
				var bAllSelected = true;
				for (var j = 1; j < cbList2.length; j++) { //skip the first checkbox
					if (cbList2[j].checked == false) {
						bAllSelected = false;
						break;
					}
				}
				j$("#cbSelAll").attr("checked", bAllSelected);
			});
		}
	});
	
	function changeActive(self, idValue) {
		if (confirm("変更してよろしいですか？")) {
			doChangeActive(j$(self).children().attr("active") == 0 ? 1 : 0, idValue);
		}
	}
	
	function doChangeActive(active, idValue) {
		var url = '<s:url action="customer!changeActive" includeParams="none" namespace="/js" />';
		var itemData = new Object();
		itemData["id"] = idValue;
		itemData["active"] = active;
		j$.post(url, itemData, function(data) {
			if (data.result == "success") {
				window.location = iesAddToken(window.location.toString());
			}
		}, "json").done(function() {
		}).fail(function() {
		}).always(function() {
		});
	}
</script>
<s:head />
</head>
<body>
	<table width="100%" class="main-box" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td nowrap="nowrap" class="main-box-search"><s:form
					id="searchForm" action="customer-list">
					<table width="100%" class="search-box" border="1" cellpadding="0"
						cellspacing="0">
						<tr>
							<td class="search-condition" nowrap="nowrap">
								<table class="search-condition-box" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<td class="header" nowrap="nowrap"><img
											src="<s:url value='/images/button_search_16.png'/>"
											class="action-icon" /> <s:text
												name="labels.customer.title.search" /></td>
									</tr>
									<tr>
										<td class="edit-error" nowrap="nowrap">
											<ul id="validateTips"></ul>
										</td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.code" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="customerCode" id="customerCode" maxlength="30"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.name" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="customerName" id="customerName" maxlength="30"
												cssStyle="width:150px;" cssClass="active-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.mail" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="email" id="email" maxlength="128"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.phone.number" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="phoneNumber" id="phoneNumber" cssStyle="width:150px;"
												cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap">事業所<s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:select id="searchOffice" name="officeCode" cssStyle="width:150px;"
												list="offices" listKey="officeCode" listValue="officeName"
												headerKey="" headerValue="" /></td>
									</tr>
									<tr>
										<td class="search-button" nowrap="nowrap"><s:submit
												key="labels.button.search" action="customer-list!search"
												cssClass="button2-action" name="search" id="search" /> <input
											type="button" onclick="iesClearInput('searchForm');"
											value="<s:text name='labels.button.clear'/>"
											class="button-cancel" /></td>
									</tr>
								</table>
							</td>
						</tr>

					</table>
				</s:form></td>
			<td width="100%" class="main-box-list"><s:form id="listForm"
					action="customer-list!bulkDelete">
					<s:url id="urlView" action="customer-list" namespace="/"
						includeParams="none" />
					<table width="100%" class="list-box button-box" border="0"
						cellpadding="0" cellspacing="0">
						<tr>
							<td class="list-content" colspan="2">
								<table width="100%" class="list-content-box" border="0"
									cellpadding="0" cellspacing="0">
									<tr class="list-controller-header">
										<td nowrap="nowrap" class="list-controller-header"
											colspan="12"><input type="checkbox" id="cbSelAll"
											class="check"
											onclick="iesCheckAll('listForm', this.checked);"> <span
											class="check-all"><s:text
													name='labels.button.selectall' /></span> <s:url id="urlAdd"
												action="customer!add" namespace="/" /> <img
											src="<s:url value='/images/button_create_16.png'/>"
											class="action-icon" /> <s:a href="%{urlAdd}"
												cssClass="link-action">
												<s:text name='labels.button.add' />
											</s:a> <img src="<s:url value='/images/button_delete_16.png'/>"
											class="action-icon" style="margin-left: 20px;" /> <s:a
												href="javascript:bulkDeletecustomer();"
												cssClass="link-action">
												<s:text name='labels.button.bulkDelete' />
											</s:a><img src="<s:url value='/images/button_up_16.png'/>"
											class="action-icon" style="margin-left: 20px;" /> <s:a
												href="javascript:uploadCSV();" cssClass="link-action">
												<s:text name='labels.button.csv.upload' />
											</s:a>
											<s:actionerror cssClass="actionerror" />
											<s:actionmessage cssClass="actionmessage" /></td>
									</tr>

									<tr class="list-content-header">
										<td nowrap="nowrap" class="list-content-header"></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.customer.code"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.customer.address"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.customer.phone.number"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.customer.email"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.week.active"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"></td>
									</tr>

									<s:iterator value="pagination.items" status="rowStatus">
										<tr
											class="<s:if test="#rowStatus.odd">list-content-data-odd</s:if><s:else>list-content-data-even</s:else>">
											<td nowrap="nowrap" class="list-content-data"><input
												name="ids" type="checkbox" class="check" value="${id}">
												&nbsp; <s:property
													value="#rowStatus.index+1+pagination.offset" /></td>
											<td nowrap="nowrap" class="list-content-data">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="customerCode" /></td>
													</tr>
													<tr>
														<td nowrap="nowrap" class="list-detail-title"><s:property
																value="customerName" /></td>
													</tr>
												</table>
											</td>

											<td class="list-content-data list-content-line" width="50%">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td class="list-detail-addition"><s:property
																value="address" />&nbsp;</td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line" width="30">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="phoneNumber" />&nbsp;</td>
													</tr>
												</table>

											</td>
											<td class="list-content-data list-content-line" width="30">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="email" />&nbsp;</td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line" width="30">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition">
														<a href="javascript:void(0)" onclick="changeActive(this, '${id}')">
															<s:if test="active == 1">
																<img name="active" active="1" src="<s:url value='/images/check_box_active.png'/>"/>
															</s:if>
															<s:else>
																<img name="active" active="0" src="<s:url value='/images/check_box.png'/>"/>
															</s:else>
														</a>
													</tr>
												</table>
											</td>
											<td nowrap="nowrap" class="list-content-data">
												<table width="100%" class="list-action-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr>
														<td nowrap="nowrap" class="list-action-line">&nbsp;</td>
														<td nowrap="nowrap" rowspan="2" class="list-action-button">
															<s:url id="urlEdit" action="customer!edit" namespace="/">
																<s:param name="id" value="id" />
															</s:url> <img src="<s:url value='/images/button_edit_16.png'/>"
															class="action-icon" /> <s:a href="%{urlEdit}"
																name="customer">
																<s:text name="labels.button.edit" />
															</s:a> <s:url id="urlDelete" action="customer!delete"
																namespace="/">
																<s:param name="id" value="id" />
															</s:url> <img src="<s:url value='/images/button_remove_16.png'/>"
															class="action-icon" /> <s:a href="%{urlDelete}"
																name="delete" onclick="return confirmDeletecustomer();">
																<s:text name="labels.button.delete" />
															</s:a>
														</td>
													</tr>
													<tr>
														<td nowrap="nowrap" class="list-action-line">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
									</s:iterator>
								</table>
							</td>
						</tr>
						<tr>
							<td class="list-header-left"><ies:pagination
									url="${urlView}" /></td>
							<td class="list-header-right"><ies:recordscount /></td>
						</tr>
					</table>
				</s:form></td>
		</tr>
	</table>
	<div class="blackLine">
		<table class="menuTable" border="0">
			<tr>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
</html>
