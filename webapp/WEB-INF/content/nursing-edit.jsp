<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/jquery.css'/>"
	rel="stylesheet" media="all" />
<link type="text/css" href="<s:url value='/styles/validate.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<style>
#nursingContent {
	width: 100%;
	height: 460px;
	border-style: solid;
	border-width: 1px;
	border-color: #000000;
	overflow: auto;
}

#contentTable {
	width: 100%;
}

tr[color1] {
	background-color: #d1d2cf;
}

tr[color2] {
	background-color: white;
}

td[main-title] {
	text-align: left;
	font-size: 18px;
	color: white;
	font-weight: bold;
}

td[title] {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}

.inputBox {
	display: inline;
	width: 150px;
	height: 28px;
	line-height: 30px;
	background-color: #aaaaaa;
}

.content-table {
	width: 100%;
	font-weight: bold;
	table-layout: fixed;
	color: #444444;
}

.content-table tr {
	height: 30px;
}
</style>
<script language="JavaScript" type="text/javascript">
	function calculateFund() {
		if (j$("#liveBuyDeposit").val().length == 0) j$("#liveBuyDeposit").val(0);
		var value = j$("#liveBuyDeposit").val() - j$("#liveBuyUsegold").val();
		if (value < 0) {
			alert("預り金、または、使用金の入力が誤りです。");
			j$("#liveBuyUsegold").val("0")
			j$("#liveBuyRefund").val(j$("#liveBuyDeposit").val());
		} else {
			j$("#liveBuyRefund").val(value);
		}
	}
	j$(function() {
		if("<s:property value='status'/>" != 5){
			if("<s:property value='finishedFlag'/>" == 1) {
				j$("#admit").css("display", "inline");
			} else {
				j$("#admit").css("display", "none");
			}
		}
		
		j$("#liveBuyDeposit").blur(calculateFund);
		j$("#liveBuyUsegold").blur(calculateFund);
	});
	
	function inputCheckBoxChange(inputId,boxId) {
		if(j$(inputId).val().length > 0) {
			j$(boxId).prop("checked",true);
		} else {
			j$(boxId).prop("checked",false);
		}
	}
	
	function checkBoxInputChange(inputId) {
		j$(inputId).val("");
	}
	
	function checkBoxFASChange(fatherId,sonId1,sonId2,sonId3){
		if(j$(sonId1).is(':checked') || j$(sonId2).is(':checked') || j$(sonId3).is(':checked')){
			j$(fatherId).prop("checked",true);
			j$(fatherId).val("1");
			var fatherId2 = "#__checkbox_" + fatherId.substring(1);
			j$(fatherId2).val("1");
		} else {
			j$(fatherId).prop("checked",false);
			j$(fatherId).val("0");
			var fatherId2 = "#__checkbox_" + fatherId.substring(1);
			j$(fatherId2).val("0");
		}
	}

	var detailTrArray = [ "excretionTr1", "excretionTr2", "moveTr1", "moveTr2",
			"cleanTr1", "cleanTr2","cleanTr3", "washTr1", "washTr2", "liveCleanTr1","liveCleanTr2", "getupTr", "eatTr",
			"medicalTr", "selfTr",  "clothTr", "beddingTr",
			"buyTr1", "buyTr2", "manageTr1", "manageTr2" ];
			
	function deleteNursingConfirm() {
		var id = '<s:property value="id" escapeHtml="false" escapeJavaScript="true"/>';
		if (id != 0) {
			if (confirm('<s:text name="messages.nursing.delete.confirm"/>') == true) {
				<s:url id="urlDelete" action="nursing!delete.ies" namespace="/">
						<s:param name="id" value="id" />
				</s:url>
				window.location=iesAddToken("${urlDelete}");
			}
		}
	}
	
	function cancelNursingConfirm() {
		var id = '<s:property value="id" escapeHtml="false" escapeJavaScript="true"/>';
		if (id != 0) {
			if (confirm('<s:text name="messages.nursing.cancel.confirm"/>') == true) {
				<s:url id="urlCancel" action="nursing!cancelNursing.ies" namespace="/">
						<s:param name="id" value="id" />
				</s:url>
				window.location=iesAddToken("${urlCancel}");
			}
		}
	}
	
	function approveNursingConfirm() {
		var id = '<s:property value="id" escapeHtml="false" escapeJavaScript="true"/>';
		var finishedFlag = '<s:property value="finishedFlag" />';
		if (id != 0) {
			if (finishedFlag == 1){
			if (confirm('<s:text name="messages.nursing.approve.confirm"/>') == true) {
				<s:url id="urlApprove" action="nursing!approve.ies" namespace="/">
						<s:param name="id" value="id" />
				</s:url>
				window.location=iesAddToken("${urlApprove}");
				}
			}else{
				 alert('<s:text name="messages.nursing.tip.confirm"/>'); 
			}
		  }
		}
	
	function closeDetail() {
		initBodyCareAndLiveHelp();
		j$("#detail").css("display", "none");
	}
	function showDetail() {
		j$("#detail").css("display", "block");
	}
	j$(document)
			.ready(
					function() {
						/* if(!<s:property value="existVoiceAndPhoto" />) {
							j$("#voicePhotoDownload").css("display", "none");
						} */
						
						j$("#downloadPdfNursingRecord_fromDate").datepicker();
						j$("#downloadPdfNursingRecord_fromDate").datepicker("option", "dateFormat",
								"yy-mm-dd");
						j$("#downloadPdfNursingRecord_toDate").datepicker();
						j$("#downloadPdfNursingRecord_toDate").datepicker("option", "dateFormat",
								"yy-mm-dd");
						
						j$("#visitDate").datepicker();
						j$("#visitDate").datepicker("option", "dateFormat",
								"yy-mm-dd");
						j$("#ui-datepicker-div").css('font-size','0.9em')
						var fromTime = '<s:property value="fromTime" />';
						var endTime = '<s:property value="endTime" />';
						for ( var i = 0; i < 24; i++) {
							if (i == fromTime.substring(0, 2)) {
								if (i < 10)
									j$("#fromHour").append(
											"<option selected>0" + i
													+ "</option>");
								else
									j$("#fromHour").append(
											"<option selected>" + i
													+ "</option>");
							} else {
								if (i < 10)
									j$("#fromHour").append(
											"<option>" + "0" + i + "</option>");
								else
									j$("#fromHour").append(
											"<option>" + i + "</option>");
							}
							if (i == endTime.substring(0, 2)) {
								if (i < 10)
									j$("#toHour").append(
											"<option selected>0" + i
													+ "</option>");
								else
									j$("#toHour").append(
											"<option selected>" + i
													+ "</option>");
							} else {
								if (i < 10)
									j$("#toHour").append(
											"<option>0" + i + "</option>");
								else
									j$("#toHour").append(
											"<option>" + i + "</option>");
							}
						}
						for ( var i = 0; i < 60; i++) {

							if (i == fromTime.substring(3, 5)) {
								if (i < 10)
									j$("#fromMin").append(
											"<option selected>0" + i
													+ "</option>");
								else
									j$("#fromMin").append(
											"<option selected>" + i
													+ "</option>");
							} else {
								if (i < 10)
									j$("#fromMin").append(
											"<option>0" + i + "</option>");
								else
									j$("#fromMin").append(
											"<option>" + i + "</option>");
							}
							if (i == endTime.substring(3, 5)) {
								if (i < 10)
									j$("#toMin").append(
											"<option selected>0" + i
													+ "</option>");
								else
									j$("#toMin").append(
											"<option selected>" + i
													+ "</option>");
							} else {
								if (i < 10)
									j$("#toMin").append(
											"<option>0" + i + "</option>");
								else
									j$("#toMin").append(
											"<option>" + i + "</option>");
							}
						}
						initNursing();

						function checkVisitDate() {
							var jObj = j$("#visitDate");
							if (!checkEmpty(jObj,
									"<s:text name='errors.application.date.required'/>"))
								return false;
							if (!checkDateFull(jObj,
									"<s:text name='errors.application.date.format'/>"))
								return false;
							return true;
						}

						function checkTime() {
							return checkFromToTime(j$("#fromHour"),
									j$("#fromMin"), j$("#toHour"),
									j$("#toMin"),
									"<s:text name='errors.application.time.range.wrong'/>");
						}
						
						//check前半时间和后半时间为非数字的情况，input maxlength设置为11
						function seviceTimeCheck(){
							var serviceTime1 = j$("[name='serviceTime1']").val();
							var serviceTime2 = j$("[name='serviceTime2']").val();
							
							if(isNaN(serviceTime1) && isNaN(serviceTime2))
								return false;
							return true;
						}
						
						//check所有输入框项目内容不能包含";"
						function inputSemicolonTextCheck( jObj, msg ){
							var pattern = new RegExp(";");
							if(pattern.test(jObj.val())){
								showDetail();
								AddTip( jObj, msg, "Reg", true );
								
								return false;
							} else {
								delTip( jObj, "Reg", true );
								return true;
							}
						}

						function checkForm() {
							combine_time();
							if (!checkEmpty(j$("#customerCode"), "<s:text name='errors.application.date.required'/>"))
								return false;
							if (!checkEmpty(j$("#serviceCode"), "<s:text name='errors.application.date.required'/>"))
								return false;
							if (!checkEmpty(j$("#userCode"), "<s:text name='errors.application.date.required'/>"))
								return false;
							if (!checkVisitDate())
								return false;
							if (!checkTime())
								return false;
							if (!seviceTimeCheck())
								return false;
							return true;
						}
						j$("#update")
								.click(
										function() {
											if (checkForm()) {
												var message = "";
												
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyExcretionUrinationObserveText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.excretion.urination'/>";
													}else{
														message += "<s:text name='labels.nursing.body.excretion.urination'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyExcretionBowelObserveText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.excretion.bowel'/>";
													}else{
														message += "<s:text name='labels.nursing.body.excretion.bowel'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyEatObserveText1"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.eat'/>";
													}else{
														message += "<s:text name='labels.nursing.body.eat'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyEatObserveText2"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.eat'/>";
													}else{
														message += "<s:text name='labels.nursing.body.eat'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyEatWaterText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.eat.water'/>";
													}else{
														message += "<s:text name='labels.nursing.body.eat.water'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyCleanGownText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.clean.gown'/>";
													}else{
														message += "<s:text name='labels.nursing.body.clean.gown'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyMoveChangeText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.move.change'/>";
													}else{
														message += "<s:text name='labels.nursing.body.move.change'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyMoveMoveHelpText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.move'/>";
													}else{
														message += "<s:text name='labels.nursing.body.move'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyMoveOutOtherText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.move.outother'/>";
													}else{
														message += "<s:text name='labels.nursing.body.move.outother'/>";
													}
												} 
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodyMedicalOtherText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.medical'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}else{
														message += "<s:text name='labels.nursing.body.medical'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_bodySelfOtherText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.body.self.help'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}else{
														message += "<s:text name='labels.nursing.body.self.help'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_liveClothRepairText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.live.cloth.repair'/>";
													}else{
														message += "<s:text name='labels.nursing.live.cloth.repair'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_liveBuyOtherText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.live.buy'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}else{
														message += "<s:text name='labels.nursing.live.buy'/>"+"<s:text name='labels.nursing.body.medical.other'/>";
													}
												}
												if (!inputSemicolonTextCheck(j$("#nursingForm_liveCookNormalText"), "<s:text name='errors.input.semicolon.text.check'/>")) {
													if(message != ""){
														message += "、"+"<s:text name='labels.nursing.live.cook.normal'/>";
													}else{
														message += "<s:text name='labels.nursing.live.cook.normal'/>";
													}
												}
												
												if(message != ""){
													message += "<s:text name='errors.input.semicolon.text.check'/>";
													alert(message);
													return;
												} 
												
												if(isSameUserAndFollower()) {
													alert("<s:text name='errors.common.user.follower.same'/>");
													return;
												} 
												if (confirm('<s:text name="messages.nursing.update.confirm"/>') == true) {
													manageValue();
													j$("#addingUrgency")
															.val(
																	j$(
																			"#adding")
																			.val() == 2 ? 1
																			: 0);
													j$("#addingFirst")
															.val(
																	j$(
																			"#adding")
																			.val() == 1 ? 1
																			: 0);
													calculateFund();
													var id = '<s:property value="id" escapeHtml="false" escapeJavaScript="true"/>';
													j$("#nursing").submit();
													if (id == 0) {
														j$("#nursingForm")
																.attr("action",
																		"nursing!save.ies");
													} else {
														j$("#nursingForm")
																.attr("action",
																		"nursing!update.ies");
													}
													j$("#nursingForm").submit();
												}
											} else {
												alert("<s:text name='errors.common.required'/>");
											}

										});
					});
	
	function combine_time() {
		j$("#fromTime").val(j$("#fromHour").val() + ":" + j$("#fromMin").val());
		j$("#endTime").val(j$("#toHour").val() + ":" + j$("#toMin").val());
	}

	function manageValue() {
		var checkBoxList = j$("#baseServiceRow input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i]).val(j$(checkBoxList[i])[0].checked ? 1 : 0);
			j$(checkBoxList[i])[0].checked = true;
		}
		checkBoxList = j$("#bodyCare input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i]).val(j$(checkBoxList[i])[0].checked ? 1 : 0);
			j$(checkBoxList[i])[0].checked = true;
		}
		checkBoxList = j$("#liveHelp input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i]).val(j$(checkBoxList[i])[0].checked ? 1 : 0);
			j$(checkBoxList[i])[0].checked = true;
		}
	}

	function initNursing() {
		j$("#downloadPdfNursingRecord_fromDate").val('<s:property value="visitDate" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#downloadPdfNursingRecord_toDate").val('<s:property value="visitDate" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#visitDate").val('<s:property value="visitDate" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#todayStateColor").val('<s:property value="todayStateColor" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#todayStateAppetite").val('<s:property value="todayStateAppetite" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#todayStateSleep").val('<s:property value="todayStateSleep" escapeHtml="false" escapeJavaScript="true"/>');
		j$("#todayStateSweat").val('<s:property value="todayStateSweat" escapeHtml="false" escapeJavaScript="true"/>');
		var checkBoxList = j$("#baseServiceRow input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i])[0].checked = j$(checkBoxList[i]).val() == 0 ? false
					: true;
		}
		checkBoxList = j$("#bodyCare input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i])[0].checked = j$(checkBoxList[i]).val() == 0 ? false
					: true;
		}
		checkBoxList = j$("#liveHelp input:checkbox");
		for ( var i = 0; i < checkBoxList.length; i++) {
			j$(checkBoxList[i])[0].checked = j$(checkBoxList[i]).val() == 0 ? false
					: true;
		}

		initBodyCareAndLiveHelp();
	}

	function initBodyCareAndLiveHelp() {
		var checkBoxList = j$("#bodyCareTr input:checkbox");
		for ( var m = 0; m < checkBoxList.length; m++) {
			j$(checkBoxList[m])[0].checked = false;
		}
		checkBoxList = j$("#liveHelpTr input:checkbox");
		for ( var n = 0; n < checkBoxList.length; n++) {
			j$(checkBoxList[n])[0].checked = false;
		}
		for ( var i = 0; i < detailTrArray.length; i++) {
			checkBoxList = j$("#" + detailTrArray[i] + " input:checkbox");
			for ( var j = 0; j < checkBoxList.length; j++) {
				if (j$(checkBoxList[j])[0].checked == true) {
					if (i == 0 || i == 1) {
						j$("#excretion")[0].checked = true;
						break;
					} else if (i == 2 || i == 3) {
						j$("#move")[0].checked = true;
						break;
					} else if (i == 4 || i == 5 || i == 6) {
						j$("#clean")[0].checked = true;
						break;
					} else if (i == 7 || i == 8) {
						j$("#wash")[0].checked = true;
						break;
					} else if (i == 9 || i == 10) {
						j$("#liveClean")[0].checked = true;
						break;
					} else if (i == 11) {
						j$("#getup")[0].checked = true;
						break;
					} else if (i == 12) {
						j$("#eat")[0].checked = true;
						break;
					} else if (i == 13) {
						j$("#medical")[0].checked = true;
						break;
					} else if (i == 14) {
						j$("#self")[0].checked = true;
						break;
					} else if (i == 15) {
						j$("#cloth")[0].checked = true;
						break;
					} else if (i == 16) {
						j$("#bed")[0].checked = true;
						break;
					} else if (i == 17) {
						j$("#buy")[0].checked = true;
						break;
					} else if (i == 19) {
						j$("#manage")[0].checked = true;
						break;
					} else if (i == 20) {
						j$("#manage")[0].checked = true;
						break;
					}
				}
			}
		}
	}
	
	function isSameUserAndFollower() {
		return j$("#userCodeFollow").val() == j$("#userCode").val();
	}
	
	function otherNursing(dir) {
		window.location.href = iesAddToken('<s:url action="nursing!edit" namespace="/" />?id=' + ((dir==1)?'${nextId}':'${previousId}') + "&listType=2");
	}
</script>

<script language="javascript">
	function reCountEndTime() {
		var startTime = parseInt(j$("[name='fromHour']").val()) * 60 + parseInt(j$("[name='fromMin']").val());
		var endTime = parseInt(j$("[name='toHour']").val()) * 60 + parseInt(j$("[name='toMin']").val());
		var serviceTime1 = parseInt(j$("[name='serviceTime1']").val());
		var serviceTime2 = endTime - startTime - serviceTime1;
		if (serviceTime2 < 0) {
			serviceTime2 = 0;
		}
		j$("[name='serviceTime2']").val(serviceTime2);
	}
	
	j$(function(){

		j$("#downloadPdfNursingDialog").dialog({
			title: "利用者別月間記録表印刷",
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
								var url = '<s:url action="pdf-download!customerMonthNursing" includeParams="none" namespace="/" />';
								var param = {};
								param["customerCode"] = j$("#downloadPdfNursing_CustomerCode").val();
								param["selectedYM"] = j$("#downloadPdfNursing_searchServiceYm").val();
								url += "?customerCode=" + param["customerCode"] + "&selectedYM=" + param["selectedYM"];
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
	
	function downloadPDFNursing() {
		j$("#downloadPdfNursingDialog").dialog("open");
	}
	
	j$(function(){

		j$("#downloadPdfNursingRecordDialog").dialog({
			title: "介護記録票印刷 ",
			autoOpen: false,
			resizable: false,
			modal: true,
			width: 400,
			height: 350,
			buttons:[
						{
							text: "ダウンロード", 
							click: function(){
								if(j$("#downloadPdfNursingRecord_fromDate").val() <= j$("#downloadPdfNursingRecord_toDate").val() && j$("#downloadPdfNursingRecord_fromDate").val().length > 0  && j$("#downloadPdfNursingRecord_toDate").val().length > 0) {
									j$(this).dialog("close");
									var url = '<s:url action="pdf-download!customerNursingRecord" includeParams="none" namespace="/" />';
									var param = {};
									param["customerCode"] = j$("#downloadPdfNursingRecord_CustomerCode").val();
									param["fromDate"] = j$("#downloadPdfNursingRecord_fromDate").val();
									param["toDate"] = j$("#downloadPdfNursingRecord_toDate").val();
									if (j$("#downloadPdfNursingRecord_recordingTicket").prop('checked') && j$("#downloadPdfNursingRecord_attachmentTicket").prop('checked')) {
										param["downloadOption"] = 2;
									} else if (j$("#downloadPdfNursingRecord_recordingTicket").prop('checked')) {
										param["downloadOption"] = 0;
									} else if (j$("#downloadPdfNursingRecord_attachmentTicket").prop('checked')) {
										param["downloadOption"] = 1;
									} else {
										param["downloadOption"] = 3;
									}
									
									url += "?customerCode=" + param["customerCode"] + "&fromDate=" + param["fromDate"]+ "&toDate=" + param["toDate"]+ "&downloadOption=" + param["downloadOption"];
									window.location = iesAddToken(url);
							        
					        	} else {
					        		alert("<s:text name='errors.common.start.later.end.1'/>");
					        	}
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
	
	function downloadPDFNursingRecord() {
		j$("#downloadPdfNursingRecordDialog").dialog("open");
	}
	
	function downloadCustomerFile(nursingId, customerCode) {
		var url = '<s:url action="nursing!downloadRecordPhotos" namespace="/" />?id=' + nursingId + "&customerCode=" + customerCode;
		window.location.href = iesAddToken(url);
		//alert(nursingId + "_" + customerCode);
	}
	
	function changeComment(obj) {
		var customerId = j$('#customerCode').find("option:selected").attr("title");
 		getComment(customerId == undefined ? 0 : customerId);
	}
	function getComment(customerId) {
		var url = '<s:url action="comment!getCustomerComment" includeParams="none" namespace="/js" />';
		var itemData = new Object();
		itemData["id"] = customerId;
		j$.post(url, itemData, function(data) {
			if (data.result == "success") {
				j$("#commentContent").val(data.comment);
			} else {
				j$("#commentContent").val("");
			}
		}, "json").done(function() {
		}).fail(function() {
		}).always(function() {
		});
	}
</script>

</head>
<body>
	<div id="nursingContent"
		style="position: relative; min-width: 1100px; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: #000000;">
		<s:form action="nursing" name="nursingForm" id="nursingForm"
			enctype="multipart/form-data">
			<s:hidden name="id" id="id" />
			<div id="detail"
				style="min-width: 900px; z-index: 3; left: 0px; margin-left: 0px; float: left; position: absolute; width: 100%; height: 570px; background-color: #ffffff; display: none;">
				<table style='width: 100%; text-align: left;' cellspacing="0"
					border='0'>
					<tr style="background-color: #91acda;" height="25px">
						<td main-title><s:text name='labels.nursing.bodycare' /></td>
						<td><div
								style="float: right; margin-right: 10px; border-width: 1px; border-style: solid; border-radius: 4px; cursor: pointer; width: 18px; height: 18px; line-height: 18px; text-align: center;"
								onclick="closeDetail();">✕</div></td>
					</tr>
					<tr>
						<td colspan='2'>
							<table border='0' id='bodyCare' cellspacing="0"
								class="content-table">
								<tr color2 id="excretionTr1">
									<td title width="10%"><s:text
											name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.pie' /></td>
									<td width="12%"><s:checkbox id='bodyExcretionwc' name='bodyExcretionwc'
										fieldValue="%{bodyExcretionwc}" /> <s:text
											name='labels.nursing.body.excretion.wc' /></td>
									<td width="15%"><s:checkbox id='bodyExcretionPortablewc' name='bodyExcretionPortablewc'
										fieldValue="%{bodyExcretionPortablewc}" /> <s:text
											name='labels.nursing.body.excretion.portablewc' /></td>
									<td width="15%"><s:checkbox id='bodyExcretionExcange' name='bodyExcretionExcange'
										fieldValue="%{bodyExcretionExcange}" onclick="return false"/> <s:text
											name='labels.nursing.body.excretion.excange' />（
											<s:checkbox id='bodyExcretionDiaper' name='bodyExcretionDiaper'
										fieldValue="%{bodyExcretionDiaper}" onchange="checkBoxFASChange('#bodyExcretionExcange','#bodyExcretionDiaper','#bodyExcretionPants','#bodyExcretionPat');"/> <s:text
											name='labels.nursing.body.excretion.diaper' /></td>
									<td width="10%"><s:checkbox id='bodyExcretionPants' name='bodyExcretionPants'
										fieldValue="%{bodyExcretionPants}" onchange="checkBoxFASChange('#bodyExcretionExcange','#bodyExcretionDiaper','#bodyExcretionPants','#bodyExcretionPat');"/> <s:text
											name='labels.nursing.body.excretion.pants' /></td>
									<td width="12%"><s:checkbox id='bodyExcretionPat' name='bodyExcretionPat'
										fieldValue="%{bodyExcretionPat}" onchange="checkBoxFASChange('#bodyExcretionExcange','#bodyExcretionDiaper','#bodyExcretionPants','#bodyExcretionPat');"/> <s:text
											name='labels.nursing.body.excretion.pat' />）</td>
									<td width="12%"><s:checkbox id='bodyExcretionClean' name='bodyExcretionClean'
										fieldValue="%{bodyExcretionClean}" /> <s:text
											name='labels.nursing.body.excretion.clean' /></td>
									<td width="15%"></td>

								</tr>
								<tr color2 id="excretionTr2">
									<td></td>
									<td colspan='2'><s:checkbox id='bodyExcretionUrinationObserveCheck'
										name='bodyExcretionUrinationObserveCheck'
										fieldValue="%{bodyExcretionUrinationObserveCheck}" onchange="checkBoxInputChange('#nursingForm_bodyExcretionUrinationObserveText');"/>
										<s:text name='labels.nursing.body.excretion.urination' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyExcretionUrinationObserveText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyExcretionUrinationObserveText','#bodyExcretionUrinationObserveCheck');" style="width: 240px;"/></td>

									<td colspan='5'><s:checkbox id='bodyExcretionBowelObserveCheck'
										name='bodyExcretionBowelObserveCheck'
										fieldValue="%{bodyExcretionBowelObserveCheck}" onchange="checkBoxInputChange('#nursingForm_bodyExcretionBowelObserveText');"/>
										<s:text name='labels.nursing.body.excretion.bowel' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyExcretionBowelObserveText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyExcretionBowelObserveText','#bodyExcretionBowelObserveCheck');" style="width: 240px;"/></td>
								</tr>
								<tr color1 id="eatTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.eat' /></td>
									<td colspan='3'><s:checkbox id='bodyEatHelp'
										name='bodyEatHelp' fieldValue="%{bodyEatHelp}" onchange="checkBoxInputChange('#nursingForm_bodyEatObserveText1');checkBoxInputChange('#nursingForm_bodyEatObserveText2');"/>
										<s:text name='labels.nursing.body.eat.help' />&nbsp;&nbsp;主<s:textfield
											cssClass="inputBox" name="bodyEatObserveText1" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyEatObserveText1','#bodyEatHelp');"/>&nbsp;&nbsp;副<s:textfield
											cssClass="inputBox" name="bodyEatObserveText2" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyEatObserveText2','#bodyEatHelp');"/></td>
									<td colspan="2"><s:checkbox id='bodyEatWaterCheck' name='bodyEatWaterCheck'
										fieldValue="%{bodyEatWaterCheck}" onchange="checkBoxInputChange('#nursingForm_bodyEatWaterText');"/> <s:text
											name='labels.nursing.body.eat.water' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyEatWaterText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyEatWaterText','#bodyEatWaterCheck');"/>&nbsp;&nbsp;ml</td>
									<td colspan='2'><s:checkbox id='bodyEatSpecial'
										name='bodyEatSpecial'
										fieldValue="%{bodyEatSpecial}" /> <s:text
											name='labels.nursing.body.eat.special' /></td>
								</tr>
								<tr color2 id="cleanTr1">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.clean' /></td>
									<td><s:checkbox id='bodyCleanAll'
										name='bodyCleanAll'
										fieldValue="%{bodyCleanAll}" /> <s:text
											name='labels.nursing.body.clean.all' /></td>
									<td><s:checkbox id='bodyCleanShower'
										name='bodyCleanShower'
										fieldValue="%{bodyCleanShower}" /> <s:text
											name='labels.nursing.body.clean.shower' /></td>
									<td><s:checkbox id='bodyCleanBath'
										name='bodyCleanBath'
										fieldValue="%{bodyCleanBath}" onclick="return false"/> <s:text
											name='labels.nursing.body.clean.bath' />（
											<s:checkbox id='bodyCleanPartHand'
										name='bodyCleanPartHand'
										fieldValue="%{bodyCleanPartHand}" onchange="checkBoxFASChange('#bodyCleanBath','#bodyCleanPartHand','#bodyCleanPartFoot','#bodyCleanPartOther');"/> <s:text
											name='labels.nursing.body.clean.parthand'/></td>
									<td><s:checkbox id='bodyCleanPartFoot'
										name='bodyCleanPartFoot'
										fieldValue="%{bodyCleanPartFoot}" onchange="checkBoxFASChange('#bodyCleanBath','#bodyCleanPartHand','#bodyCleanPartFoot','#bodyCleanPartOther');"/> <s:text
											name='labels.nursing.body.clean.partfoot' /></td>
									<td><s:checkbox id='bodyCleanPartOther'
										name='bodyCleanPartOther'
										fieldValue="%{bodyCleanPartOther}" onchange="checkBoxFASChange('#bodyCleanBath','#bodyCleanPartHand','#bodyCleanPartFoot','#bodyCleanPartOther');"/> <s:text
											name='labels.nursing.body.clean.partother' />）</td>
									<td><s:checkbox id='bodyClear' name='bodyClear'
										fieldValue="%{bodyClear}" onclick="return false"/> <s:text
											name='labels.nursing.body.clear' />（
											<s:checkbox id='bodyClearAll'
										name='bodyClearAll'
										fieldValue="%{bodyClearAll}" onchange="checkBoxFASChange('#bodyClear','#bodyClearAll','#bodyClearPart','');"/> <s:text
											name='labels.nursing.body.clear.all' /></td>
									<td><s:checkbox id='bodyClearPart'
										name='bodyClearPart'
										fieldValue="%{bodyClearPart}" onchange="checkBoxFASChange('#bodyClear','#bodyClearAll','#bodyClearPart','');"/> <s:text
											name='labels.nursing.body.clear.part' />）</td>
								</tr>
								<tr color2 id="cleanTr2">
									<td></td>
									<td colspan="2"><s:checkbox id='bodyCleanGownCheck' name='bodyCleanGownCheck'
										fieldValue="%{bodyCleanGownCheck}" onchange="checkBoxInputChange('#nursingForm_bodyCleanGownText');"/> <s:text
											name='labels.nursing.body.clean.gown' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyCleanGownText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyCleanGownText','#bodyCleanGownCheck');"/></td>
									<td><s:checkbox id='bodyCleanHair'
										name='bodyCleanHair'
										fieldValue="%{bodyCleanHair}" /> <s:text
											name='labels.nursing.body.clean.hair' /></td>
									<td><s:checkbox id='bodyCleanMouse'
										name='bodyCleanMouse'
										fieldValue="%{bodyCleanMouse}" /> <s:text
											name='labels.nursing.body.clean.mouth' /></td>
									<td><s:checkbox id='bodyCleanFace'
										name='bodyCleanFace'
										fieldValue="%{bodyCleanFace}" onclick="return false"/> <s:text
											name='labels.nursing.body.clean.face' />（
											<s:checkbox id='bodyCleanFaceHair'
										name='bodyCleanFaceHair'
										fieldValue="%{bodyCleanFaceHair}" onchange="checkBoxFASChange('#bodyCleanFace','#bodyCleanFaceHair','#bodyCleanFaceNail','#bodyCleanFaceHigesu');"/> <s:text
											name='labels.nursing.body.clean.facehair' /></td>
									<td colspan="5"><s:checkbox id='bodyCleanFaceNail'
										name='bodyCleanFaceNail'
										fieldValue="%{bodyCleanFaceNail}" onchange="checkBoxFASChange('#bodyCleanFace','#bodyCleanFaceHair','#bodyCleanFaceNail','#bodyCleanFaceHigesu');"/> <s:text
											name='labels.nursing.body.clean.facenail' />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:checkbox id='bodyCleanFaceHigesu' name='bodyCleanFaceHigesu'
										fieldValue="%{bodyCleanFaceHigesu}" onchange="checkBoxFASChange('#bodyCleanFace','#bodyCleanFaceHair','#bodyCleanFaceNail','#bodyCleanFaceHigesu');"/> <s:text
											name='labels.nursing.body.clean.face.higesu' />）</td>
									<td></td>
								</tr>
								<tr color1 id="moveTr1">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.move' /></td>
									<td colspan="2"><s:checkbox id='bodyMoveChangeCheck' name='bodyMoveChangeCheck'
										fieldValue="%{bodyMoveChangeCheck}" onchange="checkBoxInputChange('#nursingForm_bodyMoveChangeText');"/> <s:text
											name='labels.nursing.body.move.change' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyMoveChangeText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyMoveChangeText','#bodyMoveChangeCheck');"/></td>
									<td><s:checkbox id='bodyMoveErrorHelp'
										name='bodyMoveErrorHelp'
										fieldValue="%{bodyMoveErrorHelp}" /> <s:text
											name='labels.nursing.body.move.errorhelp' /></td>
									<td colspan="4"><s:checkbox id='bodyMoveMoveHelpCheck' name='bodyMoveMoveHelpCheck'
										fieldValue="%{bodyMoveMoveHelpCheck}" onchange="checkBoxInputChange('#nursingForm_bodyMoveMoveHelpText');"/> <s:text
											name='labels.nursing.body.move.movehelp' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyMoveMoveHelpText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyMoveMoveHelpText','#bodyMoveMoveHelpCheck');" style="width: 205px;"/></td>
									
								</tr>
								<tr color1 id="moveTr2">
									<td></td>
									<td colspan="3"><s:checkbox id='bodyMoveHelp'
										name='bodyMoveHelp'
										fieldValue="%{bodyMoveHelp}" onclick="return false"/> <s:text
											name='labels.nursing.body.move.out' />（
											<s:checkbox id='bodyMoveOutBuy'
										name='bodyMoveOutBuy'
										fieldValue="%{bodyMoveOutBuy}" onchange="checkBoxFASChange('#bodyMoveHelp','#bodyMoveOutBuy','#bodyMoveOutOtherCheck','');"/> <s:text
											name='labels.nursing.body.move.outbuy' />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:checkbox id='bodyMoveOutOtherCheck' name='bodyMoveOutOtherCheck'
										fieldValue="%{bodyMoveOutOtherCheck}" onchange="checkBoxInputChange('#nursingForm_bodyMoveOutOtherText');checkBoxFASChange('#bodyMoveHelp','#bodyMoveOutBuy','#bodyMoveOutOtherCheck','');"/> <s:text
											name='labels.nursing.body.move.outother' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyMoveOutOtherText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyMoveOutOtherText','#bodyMoveOutOtherCheck');inputCheckBoxChange('#nursingForm_bodyMoveOutOtherText','#bodyMoveHelp');"/>）</td>
									<td colspan="2"><s:checkbox id='bodyMoveDay'
										name='bodyMoveDay' fieldValue="%{bodyMoveDay}" onclick="return false"/>
										<s:text name='labels.nursing.body.move.day' />（
										<s:checkbox id='bodyMoveDayOut'
										name='bodyMoveDayOut'
										fieldValue="%{bodyMoveDayOut}" onchange="checkBoxFASChange('#bodyMoveDay','#bodyMoveDayOut','#bodyMoveDayIn','');"/> <s:text
											name='labels.nursing.body.move.dayout' />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:checkbox id='bodyMoveDayIn'
										name='bodyMoveDayIn'
										fieldValue="%{bodyMoveDayIn}" onchange="checkBoxFASChange('#bodyMoveDay','#bodyMoveDayOut','#bodyMoveDayIn','');"/> <s:text
											name='labels.nursing.body.move.dayin' />）</td>
									<td colspan="2"><s:checkbox id='bodyMoveHostipal' name='bodyMoveHostipal'
										fieldValue="%{bodyMoveHostipal}" /> <s:text
											name='labels.nursing.body.move.hostipal' /></td>
									
								</tr>
								
								<tr color2 id="getupTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.getup' /></td>
									<td><s:checkbox id='bodyGetupHelp'
										name='bodyGetupHelp'
										fieldValue="%{bodyGetupHelp}" /> <s:text
											name='labels.nursing.body.getup.help' /></td>
									<td colspan='6'><s:checkbox id='bodyGetupSleep'
										name='bodyGetupSleep'
										fieldValue="%{bodyGetupSleep}" /> <s:text
											name='labels.nursing.body.getup.sleep' /></td>
								</tr>
								<tr color1 id="medicalTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.medical' /></td>
									<td><s:checkbox id='bodyMedicalHelp'
										name='bodyMedicalHelp'
										fieldValue="%{bodyMedicalHelp}" /> <s:text
											name='labels.nursing.body.medical.help' /></td>
									<td><s:checkbox id='bodyMedicalSure'
										name='bodyMedicalSure'
										fieldValue="%{bodyMedicalSure}" /> <s:text
											name='labels.nursing.body.medical.sure' /></td>
									<td><s:checkbox id='bodyMedicalApp'
										name='bodyMedicalApp'
										fieldValue="%{bodyMedicalApp}" /> <s:text
											name='labels.nursing.body.medical.app' /></td>
									<td colspan='4'><s:checkbox id='bodyMedicalOtherCheck' name='bodyMedicalOtherCheck'
										fieldValue="%{bodyMedicalOtherCheck}" onchange="checkBoxInputChange('#nursingForm_bodyMedicalOtherText');"
										/> <s:text
											name='labels.nursing.body.medical.other' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodyMedicalOtherText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodyMedicalOtherText','#bodyMedicalOtherCheck');" style="width:315px;"/></td>
								</tr>
								<tr color2 id="selfTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.body.self.help' /></td>
									<td><s:checkbox id='bodySelfCook'
										name='bodySelfCook'
										fieldValue="%{bodySelfCook}" /> <s:text
											name='labels.nursing.body.self.cook' /></td>
									<td><s:checkbox id='bodySelfClean'
										name='bodySelfClean'
										fieldValue="%{bodySelfClean}" /> <s:text
											name='labels.nursing.live.clean' /></td>
									<td><s:checkbox id='bodySelfWash'
										name='bodySelfWash'
										fieldValue="%{bodySelfWash}" /> <s:text
											name='labels.nursing.body.self.wash' /></td>
									<td colspan='4'><s:checkbox id='bodySelfOtherCheck' name='bodySelfOtherCheck'
										fieldValue="%{bodySelfOtherCheck}" onchange="checkBoxInputChange('#nursingForm_bodySelfOtherText');"/> <s:text
											name='labels.nursing.body.self.other' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="bodySelfOtherText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_bodySelfOtherText','#bodySelfOtherCheck');" style="width:315px;"/></td>
								</tr>
							</table>
					<tr height="20px">
						<td colspan=2></td>

					</tr>
					<tr style="background-color: #91acda;" height="25px">
						<td main-title><s:text name='labels.nursing.live.name' /></td>
						<td></td>
					</tr>
					<tr>
						<td colspan='2'>
							<table border='0' id='liveHelp' class="content-table"
								cellspacing="0">
								<tr color2 id="liveCleanTr1">
									<td title width="10%"><s:text
											name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.clean' /></td>
									<td width="12%"><s:checkbox id='liveCleanLiveroom' name='liveCleanLiveroom'
										fieldValue="%{liveCleanLiveroom}" /> <s:text
											name='labels.nursing.live.clean.liveroom' /></td>
									<td width="15%"><s:checkbox id='liveCleanBedroom' name='liveCleanBedroom'
										fieldValue="%{liveCleanBedroom}" /> <s:text
											name='labels.nursing.live.clean.bedroom' /></td>
									<td width="15%"><s:checkbox id='liveCleanWc'
										name='liveCleanWc' fieldValue="%{liveCleanWc}" />
										<s:text name='labels.nursing.live.clean.toilet' /></td>
									<td width="10%"><s:checkbox id='liveCleanBathroom' name='liveCleanBathroom'
										fieldValue="%{liveCleanBathroom}" /> <s:text
											name='labels.nursing.live.clean.bathroom' /></td>
									<td width="12%"><s:checkbox id='liveCleanTaisuo' name='liveCleanTaisuo'
										fieldValue="%{liveCleanTaisuo}" /> <s:text
											name='labels.nursing.live.clean.taisuo' /></td>
									<td width="12%"><s:checkbox id='liveCleanLangxia' name='liveCleanLangxia'
										fieldValue="%{liveCleanLangxia}" /> <s:text
											name='labels.nursing.live.clean.langxia' /></td>
									<td width="15%"><s:checkbox id='liveCleanXimiansuo' name='liveCleanXimiansuo'
										fieldValue="%{liveCleanXimiansuo}" /> <s:text
											name='labels.nursing.live.clean.ximiansuo' /></td>

								</tr>
								<tr color2 id="liveCleanTr2">
									<td></td>
									<td><s:checkbox id='liveCleanPwc'
										name='liveCleanPwc'
										fieldValue="%{liveCleanPwc}" /> <s:text
											name='labels.nursing.live.clean.ptoilet' /></td>
									<td colspan='6'><s:checkbox id='liveCleanTrash'
										name='liveCleanTrash'
										fieldValue="%{liveCleanTrash}" /> <s:text
											name='labels.nursing.live.clean.trash' /></td>
								</tr>
								<tr color1 id="washTr1">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.wash' /></td>
									<td><s:checkbox id='liveWashWash'
										name='liveWashWash'
										fieldValue="%{liveWashWash}" /> <s:text
											name='labels.nursing.live.wash.wash' /></td>
									<td><s:checkbox id='liveWashDra'
										name='liveWashDra' fieldValue="%{liveWashDra}" />
										<s:text name='labels.nursing.live.wash.dra' /></td>
									<td><s:checkbox id='liveWashIncorporating'
										name='liveWashIncorporating'
										fieldValue="%{liveWashIncorporating}" /> <s:text
											name='labels.nursing.live.wash.incorporating' /></td>
									<td><s:checkbox id='liveWashReceipt'
										name='liveWashReceipt'
										fieldValue="%{liveWashReceipt}" /> <s:text
											name='labels.nursing.live.wash.receipt' /></td>
									<td colspan='3'><s:checkbox id='liveWashIron'
										name='liveWashIron'
										fieldValue="%{liveWashIron}" /> <s:text
											name='labels.nursing.live.wash.iron' /></td>
								</tr>
								<tr color1 id="washTr2">
									<td></td>
									<td colspan='7'><s:checkbox id='liveWashLaunderette' name='liveWashLaunderette'
										fieldValue="%{liveWashLaunderette}" onclick="return false"/> <s:text
											name='labels.nursing.live.wash.launderette' />（
											<s:checkbox id='liveWashLaunderetteWash' name='liveWashLaunderetteWash'
										fieldValue="%{liveWashLaunderetteWash}" onchange="checkBoxFASChange('#liveWashLaunderette','#liveWashLaunderetteWash','#liveWashLaunderetteDry','');"/> <s:text
											name='labels.nursing.live.wash.launderettewash' />
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:checkbox id='liveWashLaunderetteDry' name='liveWashLaunderetteDry'
										fieldValue="%{liveWashLaunderetteDry}" onchange="checkBoxFASChange('#liveWashLaunderette','#liveWashLaunderetteWash','#liveWashLaunderetteDry','');"/> <s:text
											name='labels.nursing.live.wash.launderettedry' />）</td>
								</tr>
								<tr color2 id="clothTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.cloth' /></td>
									<td colspan="2"><s:checkbox id='liveClothOrg'
										name='liveClothOrg'
										fieldValue="%{liveClothOrg}" /> <s:text
											name='labels.nursing.live.cloth.org' /></td>
									<td colspan='5'><s:checkbox id='liveClothRepairCheck' name='liveClothRepairCheck'
										fieldValue="%{liveClothRepairCheck}" onchange="checkBoxInputChange('#nursingForm_liveClothRepairText');"/> <s:text
											name='labels.nursing.live.cloth.repair' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveClothRepairText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_liveClothRepairText','#liveClothRepairCheck');"/></td>
								</tr>
								<tr color1 id="beddingTr">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.bed' /></td>
									<td colspan='2'><s:checkbox id='liveBeddingMaking' name='liveBeddingMaking'
										fieldValue="%{liveBeddingMaking}" /> <s:text
											name='labels.nursing.live.bedding.making' /></td>
									<td colspan='2'><s:checkbox id='liveBeddingLinenchange' name='liveBeddingLinenchange'
										fieldValue="%{liveBeddingLinenchange}" /> <s:text
											name='labels.nursing.live.bedding.linenchange' /></td>
									<td colspan='3'><s:checkbox id='liveBeddingFuton' name='liveBeddingFuton'
										fieldValue="%{liveBeddingFuton}" /> <s:text
											name='labels.nursing.live.bedding.futon' /></td>
								</tr>
								<tr color2 id="buyTr1">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.buy' /></td>
									<td colspan="2"><s:text
											name='labels.nursing.live.buy.destination' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveBuyDestination" maxlength="30"/></td>
									<td><s:checkbox id='liveBuyFood'
										name='liveBuyFood' fieldValue="%{liveBuyFood}" />
										<s:text name='labels.nursing.live.buy.food' /></td>
									<td><s:checkbox id='liveBuyDaily'
										name='liveBuyDaily'
										fieldValue="%{liveBuyDaily}" /> <s:text
											name='labels.nursing.live.buy.daily' /></td>
									<td><s:checkbox id='liveBuyMedical'
										name='liveBuyMedical'
										fieldValue="%{liveBuyMedical}" /> <s:text
											name='labels.nursing.live.buy.medical' /></td>
									<td colspan='2'><s:checkbox id='liveBuyOtherCheck' name='liveBuyOtherCheck'
										fieldValue="%{liveBuyOtherCheck}" onchange="checkBoxInputChange('#nursingForm_liveBuyOtherText');"/> <s:text
											name='labels.nursing.live.buy.other' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveBuyOtherText" maxlength="30" onchange="inputCheckBoxChange('#nursingForm_liveBuyOtherText','#liveBuyOtherCheck');" style="width:220px;"/></td>
								</tr>
								<tr color2 id="buyTr2">
									<td>&nbsp;</td>
									<td colspan='2'><s:text
											name='labels.nursing.live.buy.deposit' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveBuyDeposit" id="liveBuyDeposit" maxlength="6"
											onkeyup="this.value=this.value.replace(/\D/g,'')" />&nbsp;&nbsp;円</td>
									<td colspan='2'><s:text
											name='labels.nursing.live.buy.usegold' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveBuyUsegold" id="liveBuyUsegold" maxlength="6"
											onkeyup="this.value=this.value.replace(/\D/g,'')" />&nbsp;&nbsp;円</td>
									<td colspan='3'><s:text
											name='labels.nursing.live.buy.refund' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveBuyRefund" id="liveBuyRefund" maxlength="6"
											onkeyup="this.value=this.value.replace(/\D/g,'')"
											readonly="true" />&nbsp;&nbsp;円</td>
								</tr>
								<tr color1 id="manageTr1">
									<td title><s:text name='labels.nursing.special' />&nbsp;<s:text
											name='labels.nursing.live.manage' /></td>
									<td><s:checkbox id='liveCookMise'
										name='liveCookMise'
										fieldValue="%{liveCookMise}" /> <s:text
											name='labels.nursing.live.cook.mise' /></td>

									<td colspan='3'><s:checkbox id='liveCookZen'
										name='liveCookZen' fieldValue="%{liveCookZen}" />
										<s:text name='labels.nursing.live.cook.zen' /></td>
									<td colspan='3'><s:checkbox id='liveCookClean'
										name='liveCookClean'
										fieldValue="%{liveCookClean}" /> <s:text
											name='labels.nursing.live.cook.clean' /></td>
								</tr>
								<tr color1 id="manageTr2">
									<td title>&nbsp;</td>
									<td colspan="7"><s:checkbox id='liveCookNormalCheck' name='liveCookNormalCheck'
										fieldValue="%{liveCookNormalCheck}" onchange="checkBoxInputChange('#nursingForm_liveCookNormalText');"/> <s:text
											name='labels.nursing.live.cook.normal' />&nbsp;&nbsp;<s:textfield
											cssClass="inputBox" name="liveCookNormalText" maxlength="120" onchange="inputCheckBoxChange('#nursingForm_liveCookNormalText','#liveCookNormalCheck');"
											cssStyle="width:700px;" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<table id="contentTable">
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;">
						<table width="100%" border="0">
							<tr>
								<td style="width: 6%; text-align: left;"><s:text
										name="labels.nursing.customer.name" /></td>

								<s:if test="id==0">
									<td style="width: 6%;"><s:select id="customerCode"
											name="customerCode" cssStyle="width:160px;"
											list="customerList" listKey="customerCode"
											listValue="customerName" headerKey="" headerValue="" listTitle="id" onchange="changeComment()"/></td>
								</s:if>
								<s:else>
									<td style="width: 6%;"><s:select id="customerCode"
											name="customerCode" cssStyle="width:160px;" disabled="true"
											list="customerList" listKey="customerCode"
											listValue="customerName" headerKey="" headerValue="" /></td>
								</s:else>

								<td style="text-align: right; width: 5%"><s:text
										name="labels.nursing.charger" /></td>
								<td style="width: 8%;"><s:select id="userCode"
										name="userCode" cssStyle="width:160px;" list="userList"
										listKey="userCode" listValue="userName" headerKey=""
										headerValue="" /></td>
								<td style="text-align: right; width: 5%"><s:text
										name="labels.nursing.user.follow" /></td>
								<td style="width: 8%;"><s:select cssStyle="width:160px;"
										id="userCodeFollow" name="userCodeFollow" list="userList"
										listKey="userCode" listValue="userName" headerKey=""
										headerValue="" /></td>
								<td style="width: 16%;"><div
										style="text-align: right; padding: 0 5px 5px 0; float: right;">
										<div
											style="display:inline-block;width:80px;height:14px;;padding:3px;text-align:center;
			<s:if test="status == 1">background-color:#96af85;</s:if>
			<s:elseif test="status == 2">background-color:#f7f27a;</s:elseif>
			<s:elseif test="status == 0">background-color:#ea9ed4;</s:elseif>
			<s:elseif test="status == 5">background-color:#808080;</s:elseif>
			<s:elseif test="status == 6">background-color:#f39d63;</s:elseif>
			<s:elseif test="status == 7">background-color:#89d6fa;</s:elseif>
			<s:elseif test="status == 8">background-color:#32ce32;</s:elseif>
		border: 1px #cccccc solid;">
											<s:if test="status == 0">
												<s:text name="labels.nursing.status.undo" />
											</s:if>
											<s:elseif test="status == 1">
												<s:text name="labels.nursing.status.finish" />
											</s:elseif>
											<s:elseif test="status == 2">
												<s:text name="labels.nursing.status.finish.update" />
											</s:elseif>
											<s:elseif test="status == 8">
												<s:text name="labels.nursing.status.finish.new" />
											</s:elseif>
											<s:elseif test="status == 3">
												<s:text name="labels.nursing.status.today.order" />
											</s:elseif>
											<s:elseif test="status == 4">
												<s:text name="labels.nursing.status.order" />
											</s:elseif>
											<s:elseif test="status == 5">
												<s:text name="labels.nursing.status.approve" />
											</s:elseif>
											<s:elseif test="status == 6">
												<s:text name="labels.nursing.status.cancel" />
											</s:elseif>
											<s:elseif test="status == 7">
												<s:text name="labels.nursing.status.carryout" />
											</s:elseif>
										</div>
									</div>
									<div id="admit"
										style="display: none; text-align: right; padding: 0 5px 5px 0; float: right;">
										<div
											style="display: inline-block; width: 80px; height: 14px;; padding: 3px; text-align: center; border: 1px #cccccc solid; background: #93D050;">

											<s:text name="labels.nursing.finished.flag" />

										</div>
									</div></td>
							</tr>
							<tr>
								<td style="width: 8%; text-align: left;"><s:text
										name="labels.nursing.date" /></td>
								<td colspan="2"><s:textfield name="visitDate" id="visitDate"
										cssStyle="width:160px;" cssClass="disable-ime" maxlength="15" />&nbsp;<img
									src="<s:url value='/images/icon_calendar_16.png'/>"
									style="width: 14px; height: 14px;" /></td>
								<td colspan="2"><s:hidden id="fromTime" name="fromTime" />
									<s:hidden id="endTime" name="endTime" /> <select
									name="fromHour" id="fromHour" style="width: 48px;"
									onchange="reCountEndTime();"></select>:<select name="fromMin"
									id="fromMin" style="width: 48px;" onchange="reCountEndTime();"></select>
									<s:text name="labels.separator.to" /> <select name="toHour"
									id="toHour" style="width: 48px;" onchange="reCountEndTime();"></select>:<select
									name="toMin" id="toMin" style="width: 48px;"
									onchange="reCountEndTime();"></select></td>
								<td style="width: 8%;" colspan="2"></td>
							</tr>

							<tr>
								<td style="width: 8%; text-align: left;"><s:text
										name="labels.nursing.type" /></td>
								<td style="width: 35%; text-align: left;" colspan="3"><table
										cellspacing="0" align="left" border="0">
										<tr>
											<td><s:select id="serviceCode" name="serviceCode"
													list="services" listKey="code" listValue="name"
													value="serviceCode" headerKey="" headerValue=""></s:select>

											</td>
											<td>（</td>
											<td><s:textfield name="serviceTime1" id="serviceTime1"
													cssStyle="width:50px;" cssClass="disable-ime"
													maxlength="3" onchange="reCountEndTime();" /></td>
											<td>分</td>
											<td>、</td>
											<td><s:textfield name="serviceTime2" id="serviceTime2"
													cssStyle="width:50px;" cssClass="disable-ime"
													maxlength="3" /></td>
											<td>分</td>
											<td>）</td>
										</tr>
									</table></td>
								<td style="width: 8%; text-align: right;"><s:text
										name="labels.nursing.adding" /></td>
								<td><s:hidden name="addingFirst" id="addingFirst" /> <s:hidden
										name="addingUrgency" id="addingUrgency" /> <select
									name="adding" id="adding">
										<option value='0'>
											<s:text name="labels.nursing.adding.no" />
										</option>
										<option value='1' <s:if test="addingFirst==1">selected</s:if>>
											<s:text name="labels.nursing.adding.first" />
										</option>
										<option value='2'
											<s:if test="addingUrgency==1">selected</s:if>>
											<s:text name="labels.nursing.adding.urgent" />
										</option>
								</select></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%">
							<tr id="baseServiceRow">
								<td><s:text name="labels.nursing.base.service" /></td>
								<td><s:checkbox id="baseServicePrepare"
									name="baseServicePrepare"
									fieldValue="%{baseServicePrepare}" /> <s:text
										name="labels.nursing.service.prepare" /></td>
								<td><s:checkbox id="baseHealthCheck"
									name="baseHealthCheck"
									fieldValue="%{baseHealthCheck}" /> <s:text
										name="labels.nursing.health.check" /></td>
								<td><s:checkbox id="baseEnvirWork"
									name="baseEnvirWork"
									fieldValue="%{baseEnvirWork}" /> <s:text
										name="labels.nursing.envir.work" /></td>
								<td><s:checkbox id="baseNursing"
									name="baseNursing" fieldValue="%{baseNursing}" />
									<s:text name="labels.nursing.talk.nurse" /></td>
								<td><s:checkbox id="baseRecord"
									name="baseRecord" fieldValue="%{baseRecord}" />
									<s:text name="labels.nursing.nurse.record" /></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%">
							<tr id="bodyCareTr">
								<td><s:text name="labels.nursing.bodycare" /></td>
								<td><input type="checkbox" id="excretion" disabled=true />
									<s:text name="labels.nursing.body.pie" /></td>
								<td><input type="checkbox" id="eat" disabled=true /> <s:text
										name="labels.nursing.body.eat" /></td>
								<td><input type="checkbox" id="clean" disabled=true /> <s:text
										name="labels.nursing.body.clean" /></td>
								<td><input type="checkbox" id="move" disabled=true /> <s:text
										name="labels.nursing.body.move" /></td>
								<td><input type="checkbox" id="getup" disabled=true /> <s:text
										name="labels.nursing.body.getup" /></td>
								<td><input type="checkbox" id="medical" disabled=true /> <s:text
										name="labels.nursing.body.medical" /></td>
								<td><input type="checkbox" id="self" disabled=true /> <s:text
										name="labels.nursing.body.self.help" /></td>
								<td></td>
							</tr>
							<tr id="liveHelpTr">
								<td><s:text name="labels.nursing.live.name" /></td>
								<td><input type="checkbox" id="liveClean" disabled=true />
									<s:text name="labels.nursing.live.clean" /></td>
								<td><input type="checkbox" id="wash" disabled=true /> <s:text
										name="labels.nursing.live.wash" /></td>
								<td><input type="checkbox" id="cloth" disabled=true /> <s:text
										name="labels.nursing.live.cloth" /></td>
								<td><input type="checkbox" id="bed" disabled=true /> <s:text
										name="labels.nursing.live.bed" /></td>
								<td><input type="checkbox" id="buy" disabled=true /> <s:text
										name="labels.nursing.live.buy" /></td>
								<td><input type="checkbox" id="manage" disabled=true /> <s:text
										name="labels.nursing.live.manage" /></td>
								<td></td>
								<td><s:a href="javascript:showDetail();">
										<s:text name="labels.nursing.detail" />
									</s:a></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%" border="0">
							<tr>
								<td><s:text name="labels.nursing.today.state" /></td>
								<td style="width: 15%"><s:text name="labels.nursing.sweat" /><select
									name="todayStateSweat" id="todayStateSweat">
										<option value='0'>
											<s:text name="labels.nursing.today.sweat.one" />
										</option>
										<option value='1'>
											<s:text name="labels.nursing.today.sweat.two" />
										</option>
								</select></td>
								<td style="width: 25%; text-align: right;"><s:text
										name="labels.nursing.dosomething" /></td>
								<td><s:textfield name="todayStateCrossponding"
										id="todayStateCrossponding" cssStyle="width:300px;"
										cssClass="active-ime" maxlength="30" />&nbsp;<s:text
										name="labels.nursing.bracket.end" /></td>
							</tr>
							<tr>
								<td></td>
								<td><s:text name="labels.nursing.state" /><select
									name="todayStateColor" id="todayStateColor">
										<option value='0'>
											<s:text name="labels.nursing.today.state.one" />
										</option>
										<option value='1'>
											<s:text name="labels.nursing.today.state.two" />
										</option>
										<option value='2'>
											<s:text name="labels.nursing.today.state.three" />
										</option>
								</select></td>
								<td><s:text name="labels.nursing.food" /><select
									name="todayStateAppetite" id="todayStateAppetite">
										<option value='0'>
											<s:text name="labels.nursing.today.appetite.one" />
										</option>
										<option value='1'>
											<s:text name="labels.nursing.today.appetite.two" />
										</option>
										<option value='2'>
											<s:text name="labels.nursing.today.appetite.three" />
										</option>
								</select></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><s:text name="labels.nursing.sleep" /><select
									name="todayStateSleep" id="todayStateSleep">
										<option value='0'>
											<s:text name="labels.nursing.today.sleep.one" />
										</option>
										<option value='1'>
											<s:text name="labels.nursing.today.sleep.two" />
										</option>
										<option value='2'>
											<s:text name="labels.nursing.today.sleep.three" />
										</option>
										<option value='3'>
											<s:text name="labels.nursing.today.sleep.four" />
										</option>
								</select></td>
								<td></td>
								<td><a id="voicePhotoDownload" <s:if test='!existVoiceAndPhoto'>style="display:none;"</s:if> href="javascript:downloadCustomerFile('<s:property value="id" escapeHtml="false" escapeJavaScript="true"/>', '<s:property value="customerCode" escapeHtml="false" escapeJavaScript="true"/>');"><s:text name="labels.nursing.voice.photo.download"/></a></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%">
							<tr>
								<td><s:text name="labels.nursing.record" /></td>
								<td><s:text name="labels.nursing.office.record" /></td>
							</tr>
							<tr>
								<td><s:textarea name="nursingRecord" id="nursingRecord"
										rows="7" maxlength="400" cssStyle="width:450px"
										cssClass="active-ime" /></td>
								<td><s:textarea name="officeRecord" id="officeRecord"
										rows="7" maxlength="300" cssStyle="width:450px;color:blue;"
										cssClass="active-ime" /></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%">
							<tr>
								<td style="width: 14%;"><s:text
										name="labels.nursing.remark" /></td>
								<td><s:textfield name="remark" id="remark"
										cssStyle="width:100%;" cssClass="active-ime" maxlength="45" /></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td
						style="border-width: 1px; border-color: #000000; border-style: solid;"><table
							width="100%">
							<tr>
								<td style="width: 14%;"><s:text
										name="labels.comment.content.title" /></td>
								<td><s:textarea name="commentContent" id="commentContent"
										cssStyle="width:100%; height: 40px;" cssClass="active-ime" maxlength="100" /></td>
							</tr>
						</table></td>
				</tr>
				<tr>
					<td><table style="width: 100%">
							<tr style="font-weight: bold;">
								<td width="10%"><img
									src="<s:url value='/images/p2/QRCode_icon.png'/>"
									style="width: 35px; height: 35px;" /></td>
								<td width="25%"><s:text
										name="labels.nursing.scan.customercode" /> <s:text
										name="labels.separator.label" /> <s:property
										value="scanCustomerCode" /></td>
								<td width="25%"><s:text name="labels.nursing.scan.time" />
									<s:text name="labels.separator.label" /> <s:property
										value="scanTime" /></td>
								<td width="40%"><s:text name="labels.nursing.scan.status" />
									<s:text name="labels.separator.label" /> <s:if
										test="scanStatus == 1">
										<s:text name="labels.QRCode.result.customer.same.address.same" />
									</s:if> <s:elseif test="scanStatus == 2">
										<span style="color: red;"><s:text
												name="labels.QRCode.result.customer.same.address.not" /></span>
									</s:elseif> <s:elseif test="scanStatus == 3">
										<span style="color: red;"><s:text
												name="labels.QRCode.result.customer.not.address.same" /></span>
									</s:elseif> <s:elseif test="scanStatus == 4">
										<span style="color: red;"><s:text
												name="labels.QRCode.result.customer.not.address.not" /></span>
									</s:elseif> <s:else>
										<span style="color: red;"><s:text
												name="labels.QRCode.result.null" /></span>
									</s:else></td>
								
							</tr>
						</table></td>
				</tr>
			</table>
		</s:form>
	</div>
	<table style="width: 100%; height: 30px;">
		<tr>
			<td nowrap><s:a id="update" href="javascript:void(0);"
					style="text-decoration:underline; cursor:pointer; color:black;">
					<s:text name="labels.button.update" />
				</s:a></td>
			<td nowrap><s:if test="triggerFlag==0">
					<s:a href="javascript:deleteNursingConfirm();" style="color:black;">
						<s:text name="labels.button.delete" />
					</s:a>
				</s:if> <s:else>
					<span style="color: #999999;"><s:text
							name="labels.button.delete" /></span>
				</s:else></td>
			<td nowrap><s:if test="listType == 1">
					<s:url id="urlCancel" action="nursing-calendar.ies" namespace="/" />
				</s:if> <s:elseif test="listType == 2">
					<s:url id="urlCancel" action="nursing-list!search.ies"
						namespace="/" />
				</s:elseif> <s:elseif test="listType == 3">
					<s:url id="urlCancel" action="schedule.ies" namespace="/" />
				</s:elseif> <s:elseif test="listType == 4">
					<s:url id="urlCancel" action="plan.ies" namespace="/" />
				</s:elseif> <s:a href="%{urlCancel}" style="color:black;">
					<s:text name="labels.button.back" />
				</s:a></td>

			<td style="width: 35%;"></td>
			<td nowrap style="background-color: #f5f435; padding: 0 5px;"
				align="center" nowrap><s:a
					href="javascript:approveNursingConfirm();"
					style="text-decoration:underline; cursor:pointer;">
					<s:text name="labels.button.approve" />
				</s:a></td>
			<td>&nbsp;</td>
			<td style="background-color: #f5f435; padding: 0 5px;" align="center"
				nowrap><s:a href="javascript:cancelNursingConfirm();"
					style="text-decoration:underline; cursor:pointer;">
					キャンセル扱い
				</s:a></td>
			<td style="width: 10%;"></td>
			<td nowrap><s:a href="javascript:downloadPDFNursingRecord();">
					<s:text name="labels.button.print.achievement" />
				</s:a></td>
			<td style="padding: 0 5px;" align="center" nowrap><s:a
					href="javascript:downloadPDFNursing();"
					style="text-decoration:underline; cursor:pointer;">
					利用者別月間記録表印刷
				</s:a></td>

			<td style="width: 20%;"></td>

			<td nowrap><s:a href="javascript:otherNursing(-1)"
					style="color:black;">
					<s:text name="labels.pager.previous" />
				</s:a></td>
			<td nowrap><s:a href="javascript:otherNursing(1)"
					style="color:black;">
					<s:text name="labels.pager.next" />
				</s:a></td>
		</tr>
	</table>
	<div id="downloadPdfNursingDialog">
		<table cellpadding="8" style="padding: 10px;">
			<tr>
				<td>利用者：</td>
				<td>
					<select id="downloadPdfNursing_CustomerCode" style="width:160px;">
						<s:iterator value="customerList" id='number'> 
							<s:if test="active==1">
		   						<option value="<s:property value='customerCode'/>" <s:if test="[0].customerCode == [1].customerCode">selected = "selected"</s:if>>
		   							<s:property value="customerName"/>
		   						</option> 
		   					</s:if>
						</s:iterator> 	
					</select>
				</td>
			</tr>
			<tr>
				<td>サービス年月：</td>
				<td><s:select id="downloadPdfNursing_searchServiceYm"
						list="yearMonths" listKey="key" listValue="label"
						value="defaultYM"></s:select></td>
			</tr>
		</table>
	</div>

	<div id="downloadPdfNursingRecordDialog">
		<table cellpadding="8" style="padding: 10px;">
			<tr>
				<td>利用者：</td>
				<td>
					<select id="downloadPdfNursingRecord_CustomerCode" style="width:160px;">
						<s:iterator value="customerList" id='number'> 
							<s:if test="active==1">
		   						<option value="<s:property value='customerCode'/>" <s:if test="[0].customerCode == [1].customerCode">selected = "selected"</s:if>>
		   							<s:property value="customerName"/>
		   						</option> 
		   					</s:if>
						</s:iterator> 	
					</select>
				</td>
			</tr>
			<tr>
				<td>開始日：</td>
				<td><s:textfield id="downloadPdfNursingRecord_fromDate"
						cssStyle="width:160px;" cssClass="disable-ime" maxlength="15" />&nbsp;<img
					src="<s:url value='/images/icon_calendar_16.png'/>"
					style="width: 14px; height: 14px;" /></td>
			</tr>
			<tr>
				<td>終了日：</td>
				<td><s:textfield id="downloadPdfNursingRecord_toDate"
						cssStyle="width:160px;" cssClass="disable-ime" maxlength="15" />&nbsp;<img
					src="<s:url value='/images/icon_calendar_16.png'/>"
					style="width: 14px; height: 14px;" /></td>
			</tr>
			<tr>
				<td>出力帳票：</td>
				<td><input id="downloadPdfNursingRecord_recordingTicket" type="checkbox" class="check" checked>&nbsp;介護記録票&nbsp;&nbsp;&nbsp;
				<input id="downloadPdfNursingRecord_attachmentTicket" type="checkbox" class="check">&nbsp;別紙
				</td>
			</tr>
		</table>
	</div>
</body>
</html>