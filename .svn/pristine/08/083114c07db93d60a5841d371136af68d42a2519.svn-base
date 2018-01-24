<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/validate.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
<style>
#map-canvas {
	height: 260px;
	width: 400px;
	margin: 0px;
	padding: 0px;
}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script>
	var geocoder;
	var map;
	var markersArray = [];
	var marker;

	function addMarker(location) {
		marker = new google.maps.Marker({
			position : location,
			map : map
		});
		map.setCenter(location);
		markersArray.push(marker);
	}

	function deleteOverlays() {
		if (markersArray) {
			for (i in markersArray) {
				markersArray[i].setMap(null);
			}
			markersArray.length = 0;
		}
	}

	function initialize() {
		geocoder = new google.maps.Geocoder();
		var latlng = null;
		if (j$("#latitude").val() != 0 && j$("#longitude").val() != 0) {
			latlng = new google.maps.LatLng(j$("#latitude").val(), j$(
					"#longitude").val());
		} else {
			latlng = new google.maps.LatLng(35.6894875, 139.69170639999993);
		}
		var mapOptions = {
			zoom : 16,
			center : latlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP,
			streetViewControl : false

		}
		map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);
		addMarker(latlng);

		google.maps.event.addListener(map, 'click', function(event) {
			deleteOverlays();
			geocoder.geocode({
				'latLng' : event.latLng
			},
					function(results, status) {
						if (status == google.maps.GeocoderStatus.OK) {
							if (results[0]) {
								addMarker(event.latLng);
								var latlngArray = event.latLng.toString()
										.split(",", 2);
								j$("#latitude")
										.val(
												parseFloat(latlngArray[0]
														.substring(1)));
								j$("#longitude").val(
										parseFloat(latlngArray[1].substring(0,
												latlngArray[1].length - 1)));
								j$("#address")
										.val(results[0].formatted_address);
							}
						} else {
							alert("Geocoder failed due to: " + status);
						}
					});
		});
	}

	function codeAddress() {
		var address = document.getElementById('address').value;
		geocoder.geocode({
			'address' : address
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				var latlngStr = results[0].geometry.location;
				deleteOverlays();
				addMarker(latlngStr);
				var latlngArray = latlngStr.toString().split(",", 2);
				j$("#latitude").val(parseFloat(latlngArray[0].substring(1)));
				j$("#longitude").val(
						parseFloat(latlngArray[1].substring(0,
								latlngArray[1].length - 1)));
			} else {
				alert('Geocode was not successful for the following reason: '
						+ status);
			}
		});
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>
<script language="JavaScript">
	j$(document)
			.ready(
					function() {
						var id = <s:property value="id" escapeHtml="false" escapeJavaScript="true"/>;

						function checkUserCode() {
							if (!checkEmpty(j$("#userCodeShort"),
									"<s:text name='errors.user.code.required'/>"))
								return false;
							if (!checkId(j$("#userCodeShort"),
									"<s:text name='errors.user.code.error'/>"))
								return false;
							return true;
						}

						function checkUserName() {
							if (!checkEmpty(j$("#userName"),
									"<s:text name='errors.user.name.required'/>"))
								return false;
							return true;
						}
						
						function checkSortNum() {
							if (!checkEmpty(j$("#sortNum"),
									"<s:text name='errors.user.sort.number.required'/>"))
								return false;
							return true;
						}

						function checkAddress() {
							if (!checkEmpty(j$("#address"),
									"<s:text name='errors.user.address.required'/>"))
								return false;
							return true;
						}

						function checkOfficeCode() {
							if (!checkEmpty(j$("#officeCode"),
									"<s:text name='errors.office.code.required'/>"))
								return false;
							if (!checkId(j$("#officeCode"),
									"<s:text name='errors.office.code.formaterror'/>"))
								return false;
							return true;
						}

						function checkLongitudeLatitude() {
							if (!checkUnInit(j$("#longitude"),
									"<s:text name='errors.lgdlad.required'/>")
									|| !checkUnInit(j$("#latitude"),
											"<s:text name='errors.lgdlad.required'/>"))
								return false;
							if (!checkPositive(j$("#longitude"),
									"<s:text name='errors.lgdlad.required.positive'/>")
									|| !checkPositive(j$("#latitude"),
											"<s:text name='errors.lgdlad.required.positive'/>"))
								return false;
							return true;
						}

						function checkAppleID() {
							if (j$("#appleID").val().length > 0) {
								if (!checkMail(j$("#appleID"),
										"<s:text name='errors.user.apple.id.format'/>"))
									return false;
							}
							return true;
						}

						function checkEmail() {
							if (j$("#email").val().length > 0)
								if (!checkMail(j$("#email"),
										"<s:text name='errors.email.format'/>"))
									return false;
							return true;
						}

						function checkPhoneNumber() {
							return true;
						}

						function checkPassword() {
							if (!checkPasswordEight(j$("#password1"),
									"<s:text name='errors.user.password.8.24'/>"))
								return false;
							if (!checkPasswordEight(j$("#password2"),
									"<s:text name='errors.user.password.8.24'/>"))
								return false;
							if (!checkPasswordNumbersEnglish(j$("#password1"),
									"<s:text name='errors.user.password.numbers.english'/>"))
								return false;
							if (!checkPasswordNumbersEnglish(j$("#password2"),
									"<s:text name='errors.user.password.numbers.english'/>"))
								return false;
							if (id == 0) {
								if (j$("#cbUseUserCode")[0].checked) {
									j$("#password").val(j$("#userCode").val());
									return true;
								}
							} else {
								if (j$("#cbModifyPassword")[0].checked == false)
									return true;
							}

							if (!checkPasswordSame(
									j$("#password1"),
									j$("#password2"),
									"<s:text name='errors.user.password.required'/>",
									"<s:text name='errors.user.password.verify'/>"))
								return false;
							j$("#password").val(j$("#password1").val());
							return true;
						}

						function checkForm() {
							if (!checkUserCode())
								return false;
							if (!checkUserName())
								return false;
							if (!checkAppleID())
								return false;
							if (!checkSortNum())
								return false;
							if (!checkEmail())
								return false;
							if (!checkPassword())
								return false;
							if (!checkAddress())
								return false;
							if (!checkPhoneNumber())
								return false;
							if (!checkOfficeCode())
								return false;
							if (!checkLongitudeLatitude())
								return false;
							return true;
						}

						j$("#user").submit(function() {
							if (checkForm())
								return true;
							alert("<s:text name='errors.common.required'/>");
							return false;
						});

						//在登陆按钮按下的时候，统一检测
						/* j$("#userCodeShort").blur(checkUserCode);
						j$("#userName").blur(checkUserName);
						j$("#password2").blur(checkPassword);
						j$("#sortNum").blur(checkSortNum);
						j$("#appleID").blur(checkAppleID);
						j$("#email").blur(checkEmail);
						j$("#address").blur(checkAddress);
						j$("#officeCode").blur(checkOfficeCode);
						j$("#phoneNumber").blur(checkPhoneNumber); */

						if (id == 0) {
							j$("#cbUseUserCode").click(
									function() {
										if (j$("#cbUseUserCode")[0].checked) {
											clearValidateTipOfPassword(
													j$("#password1"),
													j$("#password2"));
											j$("#password1").attr("disabled",
													true);
											j$("#password2").attr("disabled",
													true);
											j$("#password1").addClass(
													"readonly");
											j$("#password2").addClass(
													"readonly");
											j$("#tdPassword1 span").hide();
											j$("#tdPassword2 span").hide();
											j$("#password1").val("");
											j$("#password2").val("");
										} else {
											j$("#password1").removeAttr(
													"disabled");
											j$("#password2").removeAttr(
													"disabled");
											j$("#password1").removeClass(
													"readonly");
											j$("#password2").removeClass(
													"readonly");
											j$("#tdPassword1 span").show();
											j$("#tdPassword2 span").show();
										}
									});
						} else {
							j$("#cbModifyPassword")
									.click(
											function() {
												if (j$("#cbModifyPassword")[0].checked) {
													j$("#password1")
															.removeAttr(
																	"disabled");
													j$("#password2")
															.removeAttr(
																	"disabled");
													j$("#password1")
															.removeClass(
																	"readonly");
													j$("#password2")
															.removeClass(
																	"readonly");
													j$("#tdPassword1 span")
															.show();
													j$("#tdPassword2 span")
															.show();
												} else {
													clearValidateTipOfPassword(
															j$("#password1"),
															j$("#password2"));
													j$("#password1").attr(
															"disabled", true);
													j$("#password2").attr(
															"disabled", true);
													j$("#password1").addClass(
															"readonly");
													j$("#password2").addClass(
															"readonly");
													j$("#password1").val("");
													j$("#password2").val("");
													j$("#tdPassword1 span")
															.hide();
													j$("#tdPassword2 span")
															.hide();
												}
											});

							j$("#cbModifyPassword")[0].checked = false;
							j$("#password1").attr("disabled", true);
							j$("#password2").attr("disabled", true);
							j$("#password1").addClass("readonly");
							j$("#password2").addClass("readonly");
							j$("#tdPassword1 span").hide();
							j$("#tdPassword2 span").hide();
						}
						var roleType = "<s:property value='roleType'/>";
						j$("#roleType").val(roleType);

						var superAdminName = '<s:property value="@jp.iesolutions.ienursing.models.User@SUPER_ADMIN_NAME"/>';
						var initFlag = '<s:property value="initFlag"/>';
						var userCodeComp = document
								.getElementById("userCodeShort");

						if (userCodeComp.value == superAdminName
								&& initFlag == '1') {

							var userNameComp = document
									.getElementById("userName");
							var roleTypeComp = document
									.getElementById("roleType");
							var boss = document.getElementById("boss");

							userCodeComp.disabled = true;
							userNameComp.disabled = true;
							roleTypeComp.disabled = true;
							boss.disabled = true;
						}
					});
</script>
<s:head />
</head>
<body>

	<s:form action="user">
		<s:hidden name="id" id="id" />

		<table width="100%" class="edit-box" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td class="edit-header"><s:if test="id==0">
						<img src="<s:url value='/images/button_create_16.png'/>"
							class="action-icon" />
						<s:text name="labels.user.title.add" />
					</s:if> <s:else>
						<img src="<s:url value='/images/button_edit_16.png'/>"
							class="action-icon" />
						<s:text name="labels.user.title.edit" />
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
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.code" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="userCodeShort" id="userCodeShort" cssStyle="width:150px;"
									cssClass="disable-ime" maxlength="10" /> <ies:requiredflag /></td>
						</tr>
						<!-- userName -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.name" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="userName" id="userName" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="16" /> <ies:requiredflag /></td>
						</tr>

						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.password" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap" id="tdPassword1">
								<input type="hidden" name="password" id="password"
								value="<s:text name='password'/>" /> <input type="password"
								name="password1" id="password1" style="width: 150px;"
								maxlength="24" /> <ies:requiredflag /> <s:if test="id==0">
				&nbsp;&nbsp;
				<input type='checkbox' id="cbUseUserCode" style="display: none;" />
									<!-- s:text name="labels.user.password.usecode" / -->
								</s:if> <s:else>
			    &nbsp;&nbsp;
				<input type='checkbox' name="modifyPassword" id="cbModifyPassword" />
									<s:text name="labels.user.password.modify" />
								</s:else>

							</td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.password.verify" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap" id="tdPassword2"><input
								type="password" name="password2" id="password2"
								style="width: 150px;" maxlength="24" /> <ies:requiredflag /></td>
							<td rowspan="7">
								<div id="map-canvas"></div>
							</td>
						</tr>
						<!-- userName 片仮名 -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.sort.number" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="sortNum" id="sortNum" cssStyle="width:100px;"
									cssClass="active-ime" maxlength="10" onkeyup="value=value.replace(/\D/g,'')"/><ies:requiredflag /></td>
						</tr>
						<!-- アドレス -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.address" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="address" id="address" cssStyle="width:200px;"
									cssClass="active-ime" maxlength="256" /> <ies:requiredflag />
								<s:hidden id="longitude" name="longitude" /> <s:hidden
									id="latitude" name="latitude" /> <input type="button"
								value="go" onclick="codeAddress()"></td>
						</tr>
						<!-- 電話番号 -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.phone.number" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="phoneNumber" id="phoneNumber" cssStyle="width:250px;"
									cssClass="disable-ime" maxlength="11" /></td>
						</tr>
						<!-- Apple ID -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.apple.id" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="appleID" id="appleID" cssStyle="width:250px;"
									cssClass="disable-ime" maxlength="50" /></td>
						</tr>
						<!-- 電子メール -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.mail" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield name="email"
									id="email" cssStyle="width:250px;" cssClass="disable-ime"
									maxlength="128" /></td>
						</tr>
						<!-- deviceKey -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.device.key" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="deviceKey" id="deviceKey" cssStyle="width:250px;"
									cssClass="disable-ime" maxlength="10" /></td>
						</tr>

						<!-- officeCode -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.office.code" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:select id="officeCode"
									name="officeCode" cssStyle="width:250px;" list="officeList"
									listKey="officeCode" listValue="officeName" headerKey=""
									headerValue="" /> <ies:requiredflag /></td>
						</tr>
						<!-- roleType -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.roletype" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><select name="roleType"
								id="roleType">
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
							<td colspan="3" nowrap="nowrap"
								style="padding: 15px 0px 0px 180px; font-size: 9pt; color: red;">
								<s:text name="labels.symbol.star.explain" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="edit-button"><s:if test="id == 0">
						<s:submit key="labels.button.update" action="user!save"
							cssClass="button2-action" name="update" id="update" />
					</s:if> <s:else>
						<s:submit key="labels.button.update" action="user!update"
							cssClass="button2-action" name="update" id="update" />
					</s:else> <s:url id="url" action="user!cancel.ies" includeParams="none"
						namespace="/" /> <input type="button" id="cancel" name="cancel"
					value="<s:text name="labels.button.cancel"/>" class="button-cancel"
					onclick="window.location=iesAddToken('${url}')" /></td>
			</tr>
		</table>
	</s:form>

</body>
</html>
