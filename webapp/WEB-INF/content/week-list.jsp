<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>
<!DOCTYPE html>
<html>
<head>
<title><s:text name="labels.header.title" /></title>
<link href="<s:url value='/styles/list.css'/>" rel="stylesheet"
	media="all" />
<link href="<s:url value='/styles/week_list.css'/>" rel="stylesheet"
	media="all" />

<script>
	var tableIdentifier = 0;
	var dialogTitle = "週間計画"
	function bulkDeleteWeek() {
		if (j$("input[name='ids']:checked").length > 0) {
			if (confirm('<s:text name="messages.week.delete.confirm"/>') == true) {
				j$("[name='active']").remove();
				j$("#listForm").submit();
			}
		} else {
			alert('<s:text name="errors.week.delete.record.required"/>');
		}
	}
	
	function weekHide() {
		j$("#fade_div").css("display", "none");
		j$("#alert_div").css("display", "none");
	}
	
	
	function weekShow() {
		var customerId = <s:property value="customerId" />;
		if (customerId > 0) {
			// 打开新窗口显示内容
			var url = '<s:url action="week!goToList2" includeParams="none" namespace="/" />' + "?customerId=" + customerId;
			window.open(iesAddToken(url), "newwindow", "height=450,width=965,top=100,left=100,scrollbars=no,resizable=no,modal=false,alwaysRaised=yes");
		} else {
			alert('ご利用者を選択してください。');
		}
	}

	function confirmDeletecustomer() {
		var resultConfirm = confirm('<s:text name="messages.week.delete.confirm"/>');
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
		changeTab(<s:property value="tab" />);
	});

	function changeActive(self, idValue) {
		var canEdit = false;
		<s:if test="canDoAction('week.edit')">
		canEdit = true;
		</s:if>
		if (j$(self).children().attr("active") == 0) {
			if (canEdit && confirm("変更してよろしいですか？")) {
				doChangeActive(1, idValue);
			} 
		} else {
			if (canEdit && confirm("変更してよろしいですか？")) {
				doChangeActive(0, idValue);
			}
		}
	}
	
	function doChangeActive(active, idValue) {
		var url = '<s:url action="week!changeActive" includeParams="none" namespace="/js" />';
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
	
	function idsCheckAll(formId, isChecked) {
		j$("#" + formId + " [userId]").prop("checked", isChecked);
	}
	
	function changeTab(tab_id){
		if(tab_id == 1) {
			j$("#tab0").css("background-color", "white");
			j$("#tab0").css("color", "#005eac");
			j$("#tab1").css("background-color", "#005eac");
			j$("#tab1").css("color", "white");
			j$("tr [customerList]").css("display", "block");
			j$("tr [searchBox]").css("display", "none");
			j$("#weekShow").css("display", "inline");
			j$("#box_customer_item_${customerId}").css("color", "gray");
			scrollToShowItem("box_customer_item_${customerId}", "box_customer_list");
		} else {
			j$("#tab0").css("background-color", "#005eac");
			j$("#tab0").css("color", "white");
			j$("#tab1").css("background-color", "white");
			j$("#tab1").css("color", "#005eac");
			j$("tr [customerList]").css("display", "none");
			j$("tr [searchBox]").css("display", "block");
			j$("#weekShow").css("display", "none");
		}
	}
</script>
<s:head />
</head>
<body>
	<table width="100%" class="main-box" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td nowrap="nowrap" class="main-box-search"><s:form
					id="searchForm" action="week-list">
					<table width="100%" class="search-box" border="1" cellpadding="0"
						cellspacing="0">
						<tr>
							<td class="search-condition" nowrap="nowrap">
								<table class="search-condition-box" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<td class="header" nowrap="nowrap"
											style="font-size: 13px; padding: 0px;"><span id="tab0"
											onclick="changeTab(0)"
											style="cursor: pointer; line-height: 30px; color: #005eac; margin: 0px; height: 30px; width: 100px; text-align: center; display: inline-block; background-color: white;">
												<s:text name="labels.week.title.search" />
										</span><span id="tab1" onclick="changeTab(1)"
											style="cursor: pointer; line-height: 30px; color: white; margin: 0px; height: 30px; width: 100px; text-align: center; display: inline-block; background-color: #005eac;"><s:text
													name="labels.week.title.customer" /></span></td>
									</tr>
									<tr customerList style="display: none;">
										<td class="list">
											<div id="box_customer_list"
												style="padding: 5px; width: 190px; height: 410px; overflow-x: hidden; overflow-y: scroll; background: linear-gradient(to right, #cddbf4, #cddbf4, #cddbf4, #ffffff);">
												<ul
													style="margin: 0px; padding: 0px; list-style-type: none; text-align: left;">
													<s:iterator value="customers" status="rowStatus">
														<s:url id="url" action="week-list!search"
															includeParams="none" namespace="/">
															<s:param name="customerCode" value="customerCode" />
															<s:param name="tab" value="1" />
														</s:url>
														<li
															style="padding: 10px; width: 160px; height: 14px; font-size: 14px; overflow: hidden; cursor: pointer;"
															id="box_customer_item_${id}"
															onclick="window.location=iesAddToken('${url}')"
															<s:property value="id==customerId?'selected':''"/>>${customerName}</li>
													</s:iterator>
												</ul>
											</div>
										</td>
									</tr>
									<tr searchBox>
										<td class="edit-error" nowrap="nowrap">
											<ul id="validateTips"></ul>
										</td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.code" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:textfield
												name="customerCode" id="customerCode" maxlength="30"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.customer.name" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:select
												id="customerName" name="customerName"
												cssStyle="width:150px;" list="customers"
												listKey="customerName" listValue="customerName" headerKey=""
												headerValue="" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap">担当（主）番号 <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:textfield
												name="helperCode" id="helperCode" maxlength="128"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap">担当（主）名 <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:select
												id="helperName" name="helperName" cssStyle="width:150px;"
												list="helpers" listKey="userName" listValue="userName"
												headerKey="" headerValue="" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap">担当（同行）番号 <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:textfield
												name="followerCode" id="followerCode" maxlength="128"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap">担当（同行）名 <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:select
												id="followerName" name="followerName"
												cssStyle="width:150px;" list="helpers" listKey="userName"
												listValue="userName" headerKey="" headerValue="" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.service.code" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:textfield
												name="serviceCode" id="serviceCode" maxlength="30"
												cssStyle="width:150px;" cssClass="disable-ime" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap"><s:text
												name="labels.service.name" /> <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:textfield
												name="serviceName" id="serviceName" maxlength="30"
												cssStyle="width:150px;" cssClass="active-ime" /></td>
									</tr>
									<tr searchBox>
										<td class="label" nowrap="nowrap">サービス実施曜日 <s:text
												name="labels.separator.label" /></td>
									</tr>
									<tr searchBox>
										<td class="input" nowrap="nowrap"><s:select id="weekFlag"
												name="weekFlag" cssClass="item-data" style="width:100px;"
												list="#{1:'月曜日',2:'火曜日',3:'水曜日',4:'木曜日',5:'金曜日',6:'土曜日',7:'日曜日'}"
												listKey="key" listValue="value" headerKey="0"
												headerValue="--曜日を選択--" /></td>
									</tr>
									<tr searchBox>
										<td class="search-button" nowrap="nowrap"><s:submit
												key="labels.button.search" action="week-list!search"
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
					action="week-list!bulkDelete">
					<s:url id="urlView" action="week-list" namespace="/"
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
													name='labels.button.selectall' /></span>
											<s:if test="canDoAction('week.edit')">
											<s:url id="urlAdd"
												action="week!add" namespace="/" /> <s:a href="%{urlAdd}"
												cssClass="link-action">
												<img src="<s:url value='/images/button_create_16.png'/>"
													class="action-icon" />
												<s:text name='labels.button.add' />
											</s:a> <s:a href="javascript:bulkDeleteWeek();"
												cssClass="link-action">
												<img src="<s:url value='/images/button_delete_16.png'/>"
													class="action-icon" style="margin-left: 20px;" />
												<s:text name='labels.button.bulkDelete' />
											</s:a>
											</s:if>
											<s:a id="weekShow" cssStyle="display:none;"
												href="javascript:weekShow();" cssClass="link-action">
												<img src="<s:url value='/images/p2/button_week.png'/>"
													class="action-icon"
													style="margin-left: 20px; width: 16px; height: 16px;" />
												<s:text name='labels.button.week.show' />
											</s:a>
											<s:actionerror cssClass="actionerror" /> <s:actionmessage
												cssClass="actionmessage" />
										</td>
									</tr>

									<tr class="list-content-header">
										<td nowrap="nowrap" class="list-content-header"></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.customer.code"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.week.flag"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.service.name"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.nursing.charger"></s:text></td>
										<td nowrap="nowrap" class="list-content-header"><s:text
												name="labels.nursing.user.follow"></s:text></td>

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
																value="customer.customerCode" /></td>
													</tr>
													<tr>
														<td nowrap="nowrap" class="list-detail-title"><s:property
																value="customer.customerName" /></td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value='%{seperateTime(timeStart)}' />~<s:property
																value='%{seperateTime(timeEnd)}' /></td>
													</tr>
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-title"><s:if
																test="weekFlag == 7">日曜日</s:if> <s:elseif
																test="weekFlag == 1">月曜日</s:elseif> <s:elseif
																test="weekFlag == 2">火曜日</s:elseif> <s:elseif
																test="weekFlag == 3">水曜日</s:elseif> <s:elseif
																test="weekFlag == 4">木曜日</s:elseif> <s:elseif
																test="weekFlag == 5">金曜日</s:elseif> <s:elseif
																test="weekFlag == 6">土曜日</s:elseif></td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td class="list-detail-addition"><s:property
																value="service.code" />&nbsp;</td>
													</tr>
													<tr class="list-detail-data">
														<td class="list-detail-title"><s:property
																value="service.name" />&nbsp;</td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="helper.userCodeShort" />&nbsp;</td>
													</tr>
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-title"><s:property
																value="helper.userName" />&nbsp;</td>
													</tr>
												</table>
											</td>
											<td class="list-content-data list-content-line">
												<table width="100%" class="list-detail-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-addition"><s:property
																value="follower.userCodeShort" />&nbsp;</td>
													</tr>
													<tr class="list-detail-data">
														<td nowrap="nowrap" class="list-detail-title"><s:property
																value="follower.userName" />&nbsp;</td>
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
												<s:if test="canDoAction('week.edit')">
												<table width="100%" class="list-action-box" border="0"
													cellpadding="0" cellspacing="0">
													<tr>
														<td nowrap="nowrap" class="list-action-line">&nbsp;</td>
														<td nowrap="nowrap" rowspan="2" class="list-action-button">
															<s:url id="urlEdit" action="week!edit" namespace="/">
																<s:param name="id" value="id" />
																<s:param name="tab" value="tab" />
															</s:url> <img src="<s:url value='/images/button_edit_16.png'/>"
															class="action-icon" /> <s:a href="%{urlEdit}"
																name="customer">
																<s:text name="labels.button.edit" />
															</s:a> <s:url id="urlDelete" action="week!delete" namespace="/">
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
												</s:if>
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
