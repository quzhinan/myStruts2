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

	function weekShow() {
		var customerId = <s:property value="customerId" />;
		var url = '<s:url action="week!loadCustomerWeekList" includeParams="none" namespace="/js" />';
		var itemData = new Object();
		itemData["id"] = customerId;

		j$.post(
						url,
						itemData,
						function(data) {
							if (data.result == "success") {
								j$("#fade_div").css("display", "block");
								j$("#alert_div").css("display", "block");
								var fadeDiv = j$("#fade_div");
								fadeDiv.css("display", "block");
								fadeDiv.css("width", j$(document).width());
								fadeDiv.css("height", j$(document).height());
								j$(".oneWeekDiv").remove();
								j$("#choosedCustomer").html(
										data.customerName + "　様");
								var weekList = data.weekList;
								for (var i = 0; i < weekList.length; i++) {
									var week = weekList[i];

									var oneWeekDiv = j$("div [week"
											+ week.weekFlag + "] .oneWeekDiv");
									if (oneWeekDiv.length == 0) {
										oneWeekDiv = j$("<div class='oneWeekDiv'></div>");
										j$("div [week" + week.weekFlag + "]")
												.append(oneWeekDiv)
									}
									var weekContent = oneWeekDiv.html();
									var helperName = isNaN(week.helper) ? week.helper.userName
											: "";
									var followerName = isNaN(week.follower) ? week.follower.userName
											: "";
									var helperStyle = !isNaN(week.helper) ? " style='background-color: gray;' "
											: "";
									var followerStyle = !isNaN(week.follower) ? " style='background-color: gray;' "
											: "";

									weekContent += ("<div class='content'><span class='rc11'>"
											+ week.textTimeStart
											+ "-"
											+ week.textTimeEnd
											+ "</span>"
											+ "<span class='rc12'>"
											+ week.service.name
											+ "</span>"
											+ "<span class='rc21' " + helperStyle + ">"
											+ helperName
											+ "</span>"
											+ "<span class='rc22' " + followerStyle + ">"
											+ followerName + "</span></div>");

									oneWeekDiv.html(weekContent);
								}
							}
						}, "json").done(function() {
				}).fail(function() {
				}).always(function() {
				});
	}

	j$(document).ready(function() {
		weekShow();
	});
</script>
<s:head />
</head>
<body>
	<div id="fade_div" class="black_overlay"></div>
	<div id="alert_div" class="white_content">
		<div id="choosedCustomer"
			style="text-align: right; width: 90%; height: 30px; position: absolute; right: 120px; top: 20px; font-size: 20px;"></div>

		<table class="content_table"
			style="height: 30px; margin-top: 72px; margin-left: 6px;">
			<tr title>
				<td nowrap="nowrap">日</td>
				<td nowrap="nowrap">月</td>
				<td nowrap="nowrap">火</td>
				<td nowrap="nowrap">水</td>
				<td nowrap="nowrap">木</td>
				<td nowrap="nowrap">金</td>
				<td nowrap="nowrap">土</td>
			</tr>
		</table>
		<div id="content"
			style="width: 930px; height: 300px; position: absolute; left: 0px; top: 105px; text-align: center;overflow-x:hidden; overflow-y: hidden;">
			<table class="content_table">
				<tr content>
					<td style="background-color: #fed3b1;"><div week7></div></td>
					<td><div class=week week1></div></td>
					<td><div class=week week2></div></td>
					<td><div class=week week3></div></td>
					<td><div class=week week4></div></td>
					<td><div class=week week5></div></td>
					<td style="background-color: #fed3b1;"><div class=week week6></div></td>
				</tr>
			</table>

		</div>
	</div>

</body>
</html>
