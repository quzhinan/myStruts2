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
	src="<s:url value='/jquery/ui/jquery.ui.datepicker.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/jquery/ui/i18n/jquery.ui.datepicker-ja.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/ajaxFileUploader/ajaxfileupload.js'/>"></script>
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/validate.js'/>"></script>
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
								j$("#latitude").val(parseFloat(latlngArray[0].substring(1)));
								j$("#longitude").val(parseFloat(latlngArray[1].substring(0, latlngArray[1].length - 1)));
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
	j$(document)
			.ready(
					function() {
						var id = <s:text name="id"/>;
						function checkCustomerCode() {
							if (!checkEmpty(j$("#customerCode"),
									"<s:text name='errors.customer.code.required'/>"))
								return false;
							if (!checkId(j$("#customerCode"),
									"<s:text name='errors.customer.code.error'/>"))
								return false;
							return true;
						}
						
						function checkCustomerCodeFake() {
							if (!checkId(j$("#customerCodeFake"),
									"<s:text name='errors.customer.code.fake.error'/>"))
								return false;
							return true;
						}

						function checkCustomerName() {
							if (!checkEmpty(j$("#customerName"),
									"<s:text name='errors.customer.name.required'/>"))
								return false;
							return true;
						}

						function checkCustomerNameKana() {
							if (!checkEmpty(j$("#customerNameKana"),
									"<s:text name='errors.customer.namekana.required'/>"))
								return false;
							return true;
						}

						function checkAddress() {
							if (!checkEmpty(j$("#address"),
									"<s:text name='errors.customer.address.required'/>"))
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
						
						function checkPhoneNumber() {

							return true;
						}

						function checkEmail() {
							if (j$("#email").val().length > 0)
								if (!checkMail(j$("#email"),
										"<s:text name='errors.email.format'/>"))
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

						function checkUserCode() {
							if (!checkEmpty(j$("#userCode"),
									"<s:text name='errors.usercode.required'/>"))
								return false;
							if (!checkId(j$("#userCode"),
									"<s:text name='errors.usercode.formaterror'/>"))
								return false;
							return true;
						}

						function checkForm() {
							if (!checkCustomerCode())
								return false;
							if (!checkCustomerCodeFake())
								return false;
							if (!checkCustomerName())
								return false;
							if (!checkCustomerNameKana())
								return false;
							if (!checkEmail())
								return false;
							if (!checkPhoneNumber())
								return false;
							if (!checkAddress())
								return false;
							if (!checkUserCode())
								return false;
							if (!checkOfficeCode())
								return false;
							if (!checkLongitudeLatitude())
								return false;
							return true;
						}

						j$("#customer").submit(function() {
							if (checkForm())
								return true;
							alert("<s:text name='errors.common.required'/>");
							return false;
						});

						//在登陆按钮按下的时候，统一检测
						/* j$("#customerCode").blur(checkCustomerCode);
						j$("#customerName").blur(checkCustomerName);
						j$("#email").blur(checkEmail);
						j$("#address").blur(checkAddress);
						j$("#phoneNumber").blur(checkPhoneNumber);
						j$("#customerNameKana").blur(checkCustomerNameKana);
						j$("#userCode").blur(checkUserCode);
						j$("#officeCode").blur(checkOfficeCode); */

					});
</script>
<s:head />
</head>
<body>

	<s:form action="customer" enctype="multipart/form-data">
		<s:hidden name="id" id="id" />
		<table width="100%" class="edit-box" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td class="edit-header"><s:if test="id==0">
						<img src="<s:url value='/images/button_create_16.png'/>"
							class="action-icon" />
						<s:text name="labels.customer.title.add" />
					</s:if> <s:else>
						<img src="<s:url value='/images/button_edit_16.png'/>"
							class="action-icon" />
						<s:text name="labels.customer.title.edit" />
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
						<!-- customerCode -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.code" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="customerCode" id="customerCode" cssStyle="width:150px;"
									cssClass="disable-ime" maxlength="20" /> <ies:requiredflag /></td>
							<td rowspan="9">
								<div id="map-canvas"></div>
							</td>
						</tr>
						<!-- customerCodeFake -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.code.true" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="customerCodeFake" id="customerCodeFake" cssStyle="background-color:lightGray; width:150px;"
									cssClass="disable-ime" maxlength="20" /><%-- <span style="font-size:10px;">(必要な状況に入力して。)</span> --%></td>
						</tr>
						<!-- customerName -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.name" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="customerName" id="customerName" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="30" /> <ies:requiredflag /></td>
						</tr>
						<!-- customerName 片仮名 -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.name.katakana" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="customerNameKana" id="customerNameKana"
									cssStyle="width:150px;" cssClass="active-ime" maxlength="30" />
								<ies:requiredflag /></td>
						</tr>
						<!-- アドレス -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.address" /> <s:text
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
									name="labels.customer.phone.number" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="phoneNumber" id="phoneNumber" cssStyle="width:250px;"
									cssClass="disable-ime" maxlength="11" />
								</td>
						</tr>
						<!-- 電子メール -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.mail" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield name="email"
									id="email" cssStyle="width:250px;" cssClass="disable-ime"
									maxlength="128" /></td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.carepdf" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap">
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='pdfNurse' id='uploadcataFile1'
										onChange='uploadFileChange(1)' />
									<div class='abovefakefile'>
										<input type='text' name='nursePlanePDF' id='uploadFileName1'
											style='z-index: 3; width: 290px;'
											value='<s:property value="nursePlanePDF" />' readonly />
										<ies:requiredflag />
										<input type='button'
											value='<s:text name='labels.button.refer'/>' id='btnTriger' />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.medicalpdf" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap">
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='medicalContact' id='uploadcataFile2'
										onChange='uploadFileChange(2)' />
									<div class='abovefakefile'>
										<input type='text' name='contectPDF' id='uploadFileName2'
											style='z-index: 3; width: 290px;'
											value='<s:property value="contectPDF" />' readonly />
										<ies:requiredflag />
										<input type='button'
											value='<s:text name='labels.button.refer'/>' id='btnTriger' />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.amentity" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap">
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='amentityPdf' id='uploadcataFile3'
										onChange='uploadFileChange(3)' />
									<div class='abovefakefile'>
										<input type='text' name='amentity' id='uploadFileName3'
											style='z-index: 3; width: 290px;'
											value='<s:property value="amentity" />' readonly />
										<ies:requiredflag />
										<input type='button'
											value='<s:text name='labels.button.refer'/>' id='btnTriger' />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.customer.usercode" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap">
									<s:select id="userCode" name="userCode"
										cssStyle="width:250px;" list="userList"
										listKey="userCode" listValue="userName" 
										 headerKey="" headerValue=""/>
										 <ies:requiredflag />
							</td>
						</tr>
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.user.office.code" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:select id="officeCode" name="officeCode"
										cssStyle="width:250px;" list="officeList"
										listKey="officeCode" listValue="officeName" 
										 headerKey="" headerValue=""/><ies:requiredflag /></td>
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
						<s:submit key="labels.button.update" action="customer!save"
							cssClass="button2-action" name="update" id="update" />
					</s:if> <s:else>
						<s:submit key="labels.button.update" action="customer!update"
							cssClass="button2-action" name="update" id="update" />
					</s:else> <s:url id="url" action="customer!cancel.ies" includeParams="none"
						namespace="/" /> <input type="button" id="cancel" name="cancel"
					value="<s:text name="labels.button.cancel"/>" class="button-cancel"
					onclick="window.location=iesAddToken('${url}');" /></td>
			</tr>
		</table>
	</s:form>

</body>
</html>
