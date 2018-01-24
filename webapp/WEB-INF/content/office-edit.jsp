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
						var id = <s:text name="id"/>;

						function checkOfficeName() {
							if (!checkEmpty(j$("#officeName"),
									"<s:text name='errors.office.name.required'/>"))
								return false;
							return true;
						}

						function checkAddress() {
							if (!checkEmpty(j$("#address"),
									"<s:text name='errors.office.address.required'/>"))
								return false;
							return true;
						}
						
						function checkPhoneNumber() {
							if (!checkEmpty(j$("#phoneNumber"),
									"<s:text name='errors.phonenumber.required'/>"))
								return false;
								if (!checkNumber(j$("#phoneNumber"),
									"<s:text name='errors.phonenumber.formaterror'/>"))
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
									"<s:text name='errors.office.lgdlad.required'/>")
									|| !checkUnInit(j$("#latitude"),
											"<s:text name='errors.office.lgdlad.required'/>"))
								return false;
							if (!checkPositive(j$("#longitude"),
							"<s:text name='errors.lgdlad.required.positive'/>")
								|| !checkPositive(j$("#latitude"),
									"<s:text name='errors.lgdlad.required.positive'/>"))
							return false;
							return true;
						}

						function checkForm() {
							if (!checkOfficeCode())
								return false;
							if (!checkOfficeName())
								return false;
							if (!checkAddress())
								return false;
							if (!checkLongitudeLatitude())
								return false;
							if (!checkPhoneNumber())
								return false;
							return true;
						}

						j$("#office").submit(function() {
							if (checkForm())
								return true;
							alert("<s:text name='errors.common.required'/>");
							return false;
						});
						
						//在登陆按钮按下的时候，统一检测
						/* j$("#officeCode").blur(checkOfficeCode);
						j$("#officeName").blur(checkOfficeName);
						j$("#address").blur(checkAddress);
						j$("#phoneNumber").blur(checkPhoneNumber); */

					});
</script>
<s:head />
</head>
<body>

	<s:form>
		<s:hidden name="id" id="id" />
		<table width="100%" class="edit-box" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td class="edit-header"><s:if test="id==0">
						<img src="<s:url value='/images/button_create_16.png'/>"
							class="action-icon" />
						<s:text name="labels.office.title.add" />
					</s:if> <s:else>
						<img src="<s:url value='/images/button_edit_16.png'/>"
							class="action-icon" />
						<s:text name="labels.office.title.edit" />
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
									name="labels.office.code" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="officeCode" id="officeCode" cssStyle="width:150px;"
									cssClass="disable-ime" maxlength="10" /> <ies:requiredflag /></td>
							<td rowspan="9">
								<div id="map-canvas"></div>
							</td>
						</tr>
						<!-- officeName -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.office.name" /> <s:text
									name="labels.separator.label" /></td>
							<td colspan="2" class="input" nowrap="nowrap"><s:textfield
									name="officeName" id="officeName" cssStyle="width:150px;"
									cssClass="active-ime" maxlength="30" /> <ies:requiredflag /></td>
						</tr>
						<!-- アドレス -->
						<tr>
							<td class="label" nowrap="nowrap"><s:text
									name="labels.office.address" /> <s:text
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
									name="labels.office.phone.number" /> <s:text
									name="labels.separator.label" /></td>
							<td class="input" nowrap="nowrap"><s:textfield
									name="phoneNumber" id="phoneNumber" cssStyle="width:250px;"
									cssClass="disable-ime" maxlength="11" /><ies:requiredflag /></td>
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
						<s:submit key="labels.button.update" action="office!save"
							cssClass="button2-action" name="update" id="update" />
					</s:if> <s:else>
						<s:submit key="labels.button.update" action="office!update"
							cssClass="button2-action" name="update" id="update" />
					</s:else> <s:url id="url" action="office!cancel.ies" includeParams="none"
						namespace="/" /> <input type="button" id="cancel" name="cancel"
					value="<s:text name="labels.button.cancel"/>" class="button-cancel"
					onclick="window.location=iesAddToken('${url}')" /></td>
			</tr>
		</table>
	</s:form>

</body>
</html>
