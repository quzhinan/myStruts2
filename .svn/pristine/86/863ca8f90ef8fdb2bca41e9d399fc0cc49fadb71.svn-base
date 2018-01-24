<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<script language="JavaScript" type="text/javascript">
	setInterval('moveNowTimeRedLine()', timeInterval);
	var requestDate = "";
	function finishChooseDate(dateText) {
		requestDate = dateText;
		var url = '<s:url action="nursing-calendar" namespace="/" />?requestDate=' + dateText;
		window.location.href = iesAddToken(url);

	}
</script>
</head>
<body>
	<div class="calendar_main">

		<div class="job_label">
			<span style="font-size: 1em; height: 60px; line-height: 60px;"><s:text
					name="labels.nursing.charger"></s:text></span>
		</div>

		<div id="time_main_label_id" class="time_main_label"></div>
		<script language="javascript">
			var content = "<span class='time_label' style='left:24px;'>08:00</span>";
			var left = 23;
			var time = 8;
			for (var i = 1; i < 11; i++) {
				time = time + 1;
				var realtime = time;
				if (realtime < 10) {
					realtime = "0" + realtime;
				}
				content = content + "<span class='time_label' style='left:"
						+ (left + 95 * i) + "px;'>" + realtime + ":00</span>";
			}
			j$("#time_main_label_id").html(content);
		</script>
		<div class="content_main">

			<div id="content_now_time_line_div" class="content_now_time_line_div"
				style="height:<s:property value='getMainContentHeight()'/>;"></div>

			<div class="content_line_div"
				style="left: 145px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 240px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 335px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 430px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 525px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 620px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 715px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 810px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 905px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 1000px; height:<s:property value='getMainContentHeight()'/>;"></div>
			<div class="content_line_div"
				style="left: 1095px; height:<s:property value='getMainContentHeight()'/>;"></div>

			<s:iterator status="status" value="resultsList" id="resultsList">


				<div class="content_item"
					style="top:<s:property value='getNowTop(#status.index )'/>;">

					<div class="content_item_user_part">
						<span><font size="2"><s:property
									value="%{#resultsList[0].userCode}" /></font></span> <br /> <span><font
							size="2"><s:property
									value="getUserName(#resultsList[0].userCode)" /></font></span>
					</div>

					<s:iterator status="status" value="#resultsList" id="nursingList">

						<s:url id="url" action="nursing!edit.ies" namespace="/">
							<s:param name="id" value="id" />
							<s:param name="listType" value="1" />
						</s:url>

						<div class="content_item_customer_part"
							style="left:<s:property value='getAbsoluteLeft(#nursingList)'/>;background-color:<s:property value='getBackgroundColor(#nursingList)'/>;"
							onclick="goToDetails('${url}')">
							<span><font size="1"><s:property
										value="#nursingList.fromTime" /></font>~<font size="1"><s:property
										value="#nursingList.endTime" /></font></span>

							<br /> <span><font size="2"><s:property
										value="getCustomerName(#nursingList.customerCode)" /></font></span> <input
								type="hidden" name="id"
								value="<s:property value="#nursingList.id" />" /> <input type="hidden" name="visitDate" value="<s:property value="#nursingList.visitDate" />" />
							 <div style="font-size:11px; height:14px;"><s:text name="labels.nursing.body" /><s:property
										value="getTypeTime(#nursingList.id,0)" /><s:text name="labels.nursing.time.unit" /></div>
										<div style="font-size:11px; height:14px;"><s:text name="labels.nursing.live" /><s:property
										value="getTypeTime(#nursingList.id,1)" /><s:text name="labels.nursing.time.unit" /></div>
						</div>
					</s:iterator>
				</div>
			</s:iterator>
			<script type="text/javascript">
				var allowGoToDetails = true;
				function startEdit() {
					allowGoToDetails = !allowGoToDetails;
					if (allowGoToDetails) {
						Dragging(getDraggingDialog).disable();
						j$("#edit_button").html("編集");
						resetStartAndEndTime();
					} else {
						Dragging(getDraggingDialog).enable();
						j$("#edit_button").html("完了");
					}
				}
				function goToDetails(url) {
					if (allowGoToDetails) {
						window.location = iesAddToken(url);
					}
				}
				function resetStartAndEndTime() {
					var finalData = new Array();
					var index = 0;

					j$(".content_item_customer_part")
							.each(
									function() {
										var userCode = j$(this).children(
												"input[name='id']").val();
										if (requestDate == null
												|| requestDate == "") {
											requestDate = j$(this).children(
													"input[name='visitDate']")
													.val();
										}
										var left = parseInt(j$(this)
												.css("left"));
										var start = 142;
										var pxForPerMinute = 1.583;
										var minutes = (left - start)
												/ pxForPerMinute;
										var hours = minutes / 60;
										var minutes = minutes % 60;
										var spaceTime = 2.5;
										if (Math.abs(minutes - 5) < spaceTime) {
											minutes = 5;
										} else if (Math.abs(minutes - 10) < spaceTime) {
											minutes = 10;
										} else if (Math.abs(minutes - 15) < spaceTime) {
											minutes = 15;
										} else if (Math.abs(minutes - 20) < spaceTime) {
											minutes = 20;
										} else if (Math.abs(minutes - 25) < spaceTime) {
											minutes = 25;
										} else if (Math.abs(minutes - 30) < spaceTime) {
											minutes = 30;
										} else if (Math.abs(minutes - 35) < spaceTime) {
											minutes = 35;
										} else if (Math.abs(minutes - 40) < spaceTime) {
											minutes = 40;
										} else if (Math.abs(minutes - 45) < spaceTime) {
											minutes = 45;
										} else if (Math.abs(minutes - 50) < spaceTime) {
											minutes = 50;
										} else if (Math.abs(minutes - 55) < spaceTime) {
											minutes = 55;
										} else if (minutes - 57.5 >= 0) {
											hours++;
											minutes = "00";
										} else if (minutes - 0 <= spaceTime) {
											minutes = "00";
										}
										hours = hours + 8;
										if(hours == 8) {
											hours = "08";
										} else if(hours == 9) {
											hours = "09";
										}
										var finalTime = parseInt(hours) + ":"
												+ minutes;
										var dataArr = new Array();
										dataArr[0] = userCode;
										dataArr[1] = finalTime;
										finalData[index] = (dataArr);
										index++;

									});
					saveItem(finalData);
				}

				function saveItem(finalData) {
					var url = '<s:url action="nursing-calendar!refreshNursingData" namespace="/" />?finalData=' + finalData + "&requestDate=" + requestDate;
					window.location.href = iesAddToken(url);
				}

				var Dragging = function(validateHandler) { //参数为验证点击区域是否为可移动区域，如果是返回欲移动元素，负责返回null
					var draggingObj = null; //dragging Dialog
					var diffX = 0;
					//var diffY = 0;

					function mouseHandler(e) {
						switch (e.type) {
						case 'mousedown':
							draggingObj = validateHandler(e);//验证是否为可点击移动区域
							if (draggingObj != null) {
								diffX = e.clientX - draggingObj.offsetLeft;
								//diffY = e.clientY - draggingObj.offsetTop;
							}
							break;

						case 'mousemove':
							if (draggingObj) {
								//alert((e.clientX-diffX)+'px');
								draggingObj.style.left = (e.clientX - diffX)
										+ 'px';
								/* 	draggingObj.style.top = (e.clientY - diffY)
											+ 'px'; */
							}
							break;

						case 'mouseup':
							draggingObj = null;
							diffX = 0;
							//diffY = 0;
							break;
						}
					}
					;

					return {
						enable : function() {
							document
									.addEventListener('mousedown', mouseHandler);
							document
									.addEventListener('mousemove', mouseHandler);
							document.addEventListener('mouseup', mouseHandler);
						},
						disable : function() {
							document.removeEventListener('mousedown',
									mouseHandler);
							document.removeEventListener('mousemove',
									mouseHandler);
							document.removeEventListener('mouseup',
									mouseHandler);
						}
					}
				}

				function getDraggingDialog(e) {
					var target = e.target;
					while (target
							&& target.className
									.indexOf('content_item_customer_part') == -1) {
						target = target.offsetParent;
					}
					if (target != null) {
						return target;
					} else {
						return null;
					}
				}
			</script>



		</div>

		<div class="blue_line"></div>
		<table class="items_table" cellpadding="0" cellspacing="0">
			<tr style="height: 100%">
				<s:url id="urlNursingList" action="nursing-list.ies"
					includeParams="none" namespace="/" />
				<td style="height: 100%"><s:a href="%{urlNursingList}">
						<s:text name="labels.welcome.function.visit.appointment" />
					</s:a></td>
				<td><s:url id="urlAdd" action="nursing!add" namespace="/" >
					<s:param name="listType" value="1" />
				</s:url> <s:a
						href="%{urlAdd}">
						<s:text name="labels.welcome.function.visit.new" />
					</s:a></td>
				<td><s:a href="#">
						<s:text name="labels.welcome.function.visit.total" />
					</s:a></td>
				<td><s:a href="#">
						<s:text name="labels.welcome.function.day" />
					</s:a></td>
				<td><s:a href="#">
						<s:text name="labels.welcome.function.month" />
					</s:a></td>

				<s:url id="masterManagerList" action="data-import.ies"
					includeParams="none" namespace="/"></s:url>
				<td><s:a href="%{masterManagerList}">
						<s:text name="labels.welcome.function.master.manage" />
					</s:a></td>
			</tr>
		</table>
	</div>
</body>
</html>



