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
	var tableIdentifier = 1;
	var dialogTitle = "職員"
	function bulkDeleteUser() {
		if (j$("[userId]:checked").length > 0) {
			if (confirm('<s:text name="messages.user.delete.confirm"/>') == true) {
				j$("#listForm").submit();
			}
		} else {
			alert('<s:text name="errors.user.delete.record.required"/>');
		}
	}

	function confirmDeleteUser() {
		var resultConfirm = confirm('<s:text name="messages.user.delete.confirm"/>');
		if (resultConfirm == false) {
			isACancelClicked = true;
		}
		return resultConfirm;
	}

	function idsCheckAll(formId, isChecked) {
		j$("#" + formId + " [userId]").prop("checked", isChecked);
	}

	j$(function() {
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
		j$("#roleType option[value=<s:property value='roleType'/>]").attr(
				"selected", true);
	});

	function changeLock(self, idValue, isLocked) {
		if (isLocked == 0) {
			if (confirm("ロック状態を作成してよろしいですか？")) {
				doChangeLock(1, idValue);
			}
		} else {
			if (confirm("ロック状態を解除してよろしいですか？")) {
				doChangeLock(0, idValue);
			}
		}
	}
	
	function doChangeLock(isLocked, idValue) {
		var url = '<s:url action="user!changeLock" includeParams="none" namespace="/js" />';
		var itemData = new Object();
		itemData["id"] = idValue;
		itemData["isLocked"] = isLocked;
		j$.post(url, itemData, function(data) {
			if (data.result == "success") {
				window.location = iesAddToken(window.location.toString());
			}
		}, "json").done(function() {
		}).fail(function() {
		}).always(function() {
		});
	}
	
	function clearInput() {
		iesClearInput('searchForm');
		j$("#searchOffice option:first").prop("selected", true);
	}
	
	function changeActive(self, idValue) {
		if (confirm("変更してよろしいですか？")) {
			doChangeActive(j$(self).children().attr("active") == 0 ? 1 : 0, idValue);
		}
	}
	
	function doChangeActive(active, idValue) {
		var url = '<s:url action="user!changeActive" includeParams="none" namespace="/js" />';
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
					id="searchForm" action="user-list">
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
												name="labels.user.title.search" /></td>
									</tr>
									<tr>
										<td class="edit-error" nowrap="nowrap">
											<ul id="validateTips"></ul>
										</td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.user.code" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="userCode" id="userCode" maxlength="30"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.user.name" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="userName" id="userName" maxlength="30"
												cssStyle="width:150px;" cssClass="active-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.user.mail" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="email" id="email" maxlength="128"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.user.phone.number" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:textfield
												name="phoneNumber" id="phoneNumber" cssStyle="width:150px;"
												cssClass="disable-ime" /></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.user.role.type" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td><select name="roleType" id="roleType"
											style="width: 150px; margin-left: 10px;">
												<option value='-1'></option>
												<option value='1'>
													<s:text name="labels.user.type.user.service" />
												</option>
												<option value='0'>
													<s:text name="labels.user.type.user.care" />
												</option>
												<option value='2'>
													<s:text name="labels.user.type.user.system" />
												</option>
										</select></td>
									</tr>
									<tr>
										<td class="label" nowrap="nowrap">事業所<s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr>
										<td class="input" nowrap="nowrap"><s:select
												id="searchOffice" name="officeCode" cssStyle="width:150px;"
												list="offices" listKey="officeCode" listValue="officeName"
												headerKey="" headerValue="" /></td>
									</tr>
									<tr>
										<td class="search-button" nowrap="nowrap"><s:submit
												key="labels.button.search" action="user-list!search"
												cssClass="button2-action" name="search" id="search" /> <input
											type="button" onclick="clearInput();"
											value="<s:text name='labels.button.clear'/>"
											class="button-cancel" /></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</s:form></td>
			<td width="100%" class="main-box-list"><s:form id="listForm"
					action="user-list!bulkDelete">
					<s:url id="urlView" action="user-list" namespace="/"
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
											onclick="idsCheckAll('listForm', this.checked);"> <span
											class="check-all"><s:text
													name='labels.button.selectall' /></span> <s:url id="urlAdd"
												action="user!add" namespace="/" /> <img
											src="<s:url value='/images/button_create_16.png'/>"
											class="action-icon" /> <s:a href="%{urlAdd}"
												cssClass="link-action">
												<s:text name='labels.button.add' />
											</s:a> <!-- <img src="<s:url value='/images/button_delete_16.png'/>"
											class="action-icon" style="margin-left: 20px;" /> <s:a
												href="javascript:bulkDeleteUser();" cssClass="link-action">
												<s:text name='labels.button.bulkDelete' />
											</s:a> --><img src="<s:url value='/images/button_up_16.png'/>"
											class="action-icon" style="margin-left: 20px;" /> <s:a
												href="javascript:uploadCSV();" cssClass="link-action">
												<s:text name='labels.button.csv.upload' />
											</s:a> <s:actionerror cssClass="actionerror" /> <s:actionmessage
												cssClass="actionmessage" /></td>
									</tr>

									<tr class="list-content-header">
										<td nowrap="nowrap" class="list-content-header"></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.code"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.address"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.phone.number"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.apple.id"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.office.code"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.roletype"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.sort.number"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.user.lock.title"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.week.active"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"></td>
									</tr>

									<s:iterator value="pagination.items" status="rowStatus">
										<tr
											class="<s:if test="#rowStatus.odd">list-content-data-odd</s:if><s:else>list-content-data-even</s:else>">
											<td nowrap="nowrap" class="list-content-data"><input
												userId name="ids" type="checkbox" class="check"
												value="${id}"> &nbsp; <s:property
													value="#rowStatus.index+1+pagination.offset" /></td>
											<td nowrap="nowrap" class="list-content-data">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="userCodeShort" /></td>
													</tr>
													<tr>
														<td nowrap="nowrap" class="list-detail-title"><s:property
																value="userName" /></td>
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
																value="appleID" />&nbsp;</td>
													</tr>
												</table>

											</td>
											<td class="list-content-data list-content-line" width="30">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="officeCode" />&nbsp;</td>
													</tr>
												</table>

											</td>
											<td class="list-content-data list-content-line" width="15">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><span
															style="width: 50px;"><s:if test="roleType == 1">
																	<s:text name="labels.user.type.user.service" />
																</s:if> <s:elseif test="roleType == 0">
																	<s:text name="labels.user.type.user.care" />
																</s:elseif> <s:elseif test="roleType == 2">
																	<s:text name="labels.user.type.user.system" />
																</s:elseif></span>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line" width="15">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="sortNum" />
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line" width="30">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition">
														<a href="javascript:void(0)" onclick="changeLock(this, '${id}', '${isLocked}')">
															<s:if test="isLocked == 1">
																<img name="isLocked" src="<s:url value='/images/check_box_active.png'/>"/>
															</s:if>
															<s:else>
																<img name="isLocked" src="<s:url value='/images/check_box.png'/>"/>
															</s:else>
														</a>
														</td>
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
															<s:url id="urlEdit" action="user!edit" namespace="/">
																<s:param name="id" value="id" />
															</s:url> <img src="<s:url value='/images/button_edit_16.png'/>"
															class="action-icon" /> <s:a href="%{urlEdit}"
																name="user">
																<s:text name="labels.button.edit" />
															</s:a> <s:if test="roleType!=2">
																<s:url id="urlDelete" action="user!delete" namespace="/">
																	<s:param name="id" value="id" />
																</s:url>
																<img src="<s:url value='/images/button_remove_16.png'/>"
																	class="action-icon" />
																<s:a href="%{urlDelete}" name="delete"
																	onclick="return confirmDeleteUser();">
																	<s:text name="labels.button.delete" />
																</s:a>
															</s:if>
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
