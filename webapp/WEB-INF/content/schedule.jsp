<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ies" tagdir="/WEB-INF/tags/ies"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title><s:text name="labels.header.title" /></title>
<link type="text/css" href="<s:url value='/styles/schedule.css'/>"
	rel="stylesheet" media="all" />
<script language="JavaScript" type="text/javascript"
	src="<s:url value='/scripts/event.js.jsp'/>"></script>
<s:head />
<script language="javascript">

	var clear_message_timer = null;
	var http_post_is_busying = false;
	var send_data_undo_buffer = new Array();
	var search_service_date = '${searchServiceYm}' + formateIntTo2String(${searchServiceDay});

	var schedule_work_time_start = <s:property value="%{getSystemOption('work.time.drag.start')}" />;
	var schedule_work_time_end = <s:property value="%{getSystemOption('work.time.drag.end')}" />;
	var schedule_work_time_unit = <s:property value="%{getSystemOption('work.time.drag.unit')}" />;
	var schedule_work_time_count = (schedule_work_time_end - schedule_work_time_start + 1) * 60 / schedule_work_time_unit;

	var event_item_helper_id_prefix = "event_item_h_";
	var event_item_follower_id_prefix = "event_item_f_";
	var event_helper_id_prefix = "event_helper_";

	var box_event_is_coping_mode = false;
	var box_event_scope_width = 0;
	var box_event_copied = null;
	var box_event_moving = null;
	var box_event_click_point = {x: 0, y: 0};
	var box_event_drag_start_point = {left: 0, top: 0};
	var box_event_drag_direction = 0; // 0:none; 1:x; 2:y;
	
	var window_prev_frame = {width: 0, height: 0};
	
	var events_buffer = new Object();
	
	/* init page - after did load */
	j$(function(){
		
		box_event_scope_width = j$("div.event-row-scope").width();
		
		loadAllEventItems();
		
		j$(window).resize(function(){
			if (box_event_scope_width != j$("div.event-row-scope").width()) {
				redrawAllEventItems();
				box_event_scope_width = j$("div.event-row-scope").width();
			}
			resizeTagsFrame();
		});
		resizeTagsFrame();
		
		j$(document)
			.keydown(function(e) {
				if (e.shiftKey) {
					copyEventItemStart();
			  	}
			})
			.keyup(function(e) {
				copyEventItemStop();
			});
		
		j$("#searchDate").datepicker();
		j$("#searchDate").datepicker("option", "dateFormat", "yy-mm-dd");
		j$("#searchDate").change(function(){
			var searchDate = j$("#searchDate").val();
			var arrSearchDate = searchDate.split("-");
			var searchServiceYm = arrSearchDate[0] + arrSearchDate[1]
			var searchServiceDay = arrSearchDate[2];
			j$("#searchServiceYm").val(searchServiceYm);
			j$("#searchServiceDay").val(searchServiceDay);
		});
		var yearMonth = '<s:property value="searchServiceYm" escapeHtml="false" escapeJavaScript="true"/>';
		var day = '<s:property value="searchServiceDay" escapeHtml="false" escapeJavaScript="true"/>';
		var yearMonthFormat = yearMonth.substring(0,4) + "-" + yearMonth.substring(4,6);
		var dayFormat = null;
		/* if(day.length < 2){
			dayFormat = "0" + day;
		} else {
			dayFormat = day;
		} */
		dayFormat = day.length < 2 ? "0" + day : day;
		var today = yearMonthFormat + "-" + dayFormat;
		j$("#searchDate").val(today);
	});
	
	/* resize tags frame */
	function resizeTagsFrame() {

		if (j$(window).height() != window_prev_frame.height) {
			window_prev_frame.height = j$(window).height();
			var height = window_prev_frame.height-280;
			if (height < 300) height = 300;
			j$("div#scheduleBox div.event-grid").height(height);
		}
	}
	
	/* event item data - do load from db */
	function loadAllEventItems() {
		
		if (http_post_is_busying == true) return;
	
		var url = '<s:url action="schedule" includeParams="none" namespace="/js" />';
		j$.post(url, {}, function(data){
					if (data.result == "success") {
						didLoadAllEventItems(data.events);
					} else {
						j$("#warning_messager").html(data.message);
						j$("#warning_messager").attr("type", "err");
						clearMessageAfter(5);
					}
				}, "json")
				.done(function(){
					http_post_is_busying == true;
				})
				.fail(function(){
					window.location = iesAddToken('<s:url action="welcome" includeParams="none" namespace="/" />');
				})
				.always(function(){
					http_post_is_busying == false;
				});
	}

	/* event item data - did load from db */
	function didLoadAllEventItems(events) {
		for (var i=0; i<events.length; i++) {
			var event = events[i];
			events_buffer["id_" + event.id] = event;
		}
		redrawAllEventItems();
		recountUndist();
	}

	/* event item box - reset all position  */
	function redrawAllEventItems() {
		for (var key in events_buffer) {
			var event = events_buffer[key];
			redrawEventItem(event);
		}
	}

	/* event item box - set position  */
	function redrawEventItem(event) {

		var schedule = (event.achievement.status > 0 ? event.achievement : event.schedule);
		var boxEventHelper = findEventItemBox(event_item_helper_id_prefix + event.id, event.id, "helper", schedule.type);
		var boxEventFollower = findEventItemBox(event_item_follower_id_prefix + event.id, event.id, "follower", schedule.type);

		var timeStartBoxIndex = parseInt((schedule.intTimeStartOfMinute - schedule_work_time_start * 60) / schedule_work_time_unit);
		var timeEndBoxIndex = parseInt((schedule.intTimeEndOfMinute - schedule_work_time_start * 60) / schedule_work_time_unit);

		if (timeStartBoxIndex < 0 || timeStartBoxIndex >= schedule_work_time_count) {

			var boxMore = null;
			var moreIcon = null;
			var helperId = 0
			if ((schedule.helper == null && schedule.follower == null) || schedule.helper == null) {
				helperId = "0";
				if (timeStartBoxIndex < 0) {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-left").find("span");
					var moreCount = parseInt(boxMore.text().substring(3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "<< " + (++moreCount);
				} else {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-right").find("span");
					var moreCount = parseInt(boxMore.text().substring(0, boxMore.text().length - 3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "" + (++moreCount) + " >>";
				}
				boxMore.text(moreIcon);
				boxMore.parent().show();
			}
			if (schedule.helper != null) {
				helperId = schedule.helper.id;
				if (timeStartBoxIndex < 0) {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-left").find("span");
					var moreCount = parseInt(boxMore.text().substring(3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "<< " + (++moreCount);
				} else {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-right").find("span");
					var moreCount = parseInt(boxMore.text().substring(0, boxMore.text().length - 3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "" + (++moreCount) + " >>";
				}
				boxMore.text(moreIcon);
				boxMore.parent().show();
			}
			if (schedule.follower != null) {
				helperId = schedule.follower.id;
				if (timeStartBoxIndex < 0) {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-left").find("span");
					var moreCount = parseInt(boxMore.text().substring(3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "<< " + (++moreCount);
				} else {
					boxMore = j$("#" + event_helper_id_prefix + helperId).find(".event-more-right").find("span");
					var moreCount = parseInt(boxMore.text().substring(0, boxMore.text().length - 3));
					moreCount = isNaN(moreCount) ? 0 : moreCount;
					moreIcon = "" + (++moreCount) + " >>";
				}
				boxMore.text(moreIcon);
				boxMore.parent().show();
			}
		}
		if (timeEndBoxIndex >= schedule_work_time_count) {
			boxEventHelper.find("div[box]").addClass("overflow");
			boxEventFollower.find("div[box]").addClass("overflow");
		} else {
			boxEventHelper.find("div[box]").removeClass("overflow");
			boxEventFollower.find("div[box]").removeClass("overflow");
		}
		if (timeStartBoxIndex < 0 || timeStartBoxIndex >= schedule_work_time_count ||
				schedule.serviceDate != search_service_date) {
			boxEventHelper.parent().detach();
			boxEventFollower.parent().detach();
			delete(events_buffer["id_" + event.id]);
		} else {
			var data = new Object();
			data.unitWidth = (j$("div.event-row-scope").width() / schedule_work_time_count);
			data.left = data.unitWidth * timeStartBoxIndex;
			data.width = data.unitWidth * (timeEndBoxIndex - timeStartBoxIndex);
			data.time = schedule.textTimeStart + "~" + schedule.textTimeEnd;
			data.customer = event.customer.customerName;
			data.service = schedule.service.shortName;
			data.achvstatus = "" + event.achievement.status + (event.achievement.isModified == 1 ? "m" : (event.achievement.isModified == 2 ? "n" : ""));
			data.itemtype = schedule.type;
			data.updateStatus = event.updateStatus;
			data.commentConfirmStatus = event.achievement.commentConfirmStatusShow;

			data.helperId = 0;
			data.flag = "";
			if (schedule.helper != null) {
				data.helperId = schedule.helper.id;
			}
			setEventItemBoxValues(boxEventHelper, data);
			
			if (schedule.follower != null) {
				data.helperId = schedule.follower.id;
				data.flag = "☆";
				setEventItemBoxValues(boxEventFollower, data);
			} else {
				boxEventFollower.parent().detach();
			}
		}
	}

	/* event item box - set event item frame & values (achvstatus, itemtype, helperId, left, width, unitWidth, time, customer, flag, service)  */
	function setEventItemBoxValues(boxEvent, data) {
		boxEvent.attr("achvstatus", data.achvstatus);
		boxEvent.attr("itemType", data.itemtype);
		boxEvent.attr("updstatus", data.updateStatus);
		boxEvent.find("div[box] div[time]").text(data.time);
		boxEvent.find("div[box] div[customer]").text(data.customer);
		boxEvent.find("div[box] div[flag]").text(data.flag);
		boxEvent.find("div[box] div[service]").text(data.service);
		if (data.commentConfirmStatus == 0) {
			boxEvent.find("div[box] div[comment]").css("display","none");
		} else if (data.commentConfirmStatus == 1) {
			boxEvent.find("div[box] div[comment]").css("display","");
			boxEvent.find("div[box] div[comment]").css("color","red");
		} else if (data.commentConfirmStatus == 2) {
			boxEvent.find("div[box] div[comment]").css("display","");
			boxEvent.find("div[box] div[comment]").css("color","rgb(50,50,50)");
		}
		boxEvent.css("left", data.left);
		boxEvent.css("top", 0);
		boxEvent.width(data.width);
		boxEvent.resizable("option", {grid: data.unitWidth});
		boxEvent.parent().appendTo(j$("#" + event_helper_id_prefix + data.helperId));
	}
	
	/* event item box - find event item by tag id  */
	function findEventItemBox(tagId, eventId, type, itemType) {

		var boxEvent = j$("#" + tagId);

		if (boxEvent.length == 0) {
			boxEvent = j$("<div id='" + tagId + "' eventId='" + eventId + "' type='" + type + "'><div box></div></div>");
			boxEvent.find("div[box]")
				.append("<div time></div>")
				.append("<div customer></div>")
				.append("<div flag></div>")
				.append("<div service></div>")
				.append("<div comment>■</div>")
				.append("<div modify>★</div>");
			boxEvent.addClass("event-item");
			
			boxEvent.appendTo("<div class='event-item-box'></div>");
			
			boxEvent.draggable({
				snap: ".event-cell", 
				containment: ".event-row-scope",
				start: function(event, ui){
					box_event_drag_start_point.top = ui.position.top;
					box_event_drag_start_point.left = ui.position.left;
					box_event_drag_direction = 0; // 0:none; 1:x; 2:y;
					moveStartEventItem(j$(this));
				},
				drag: function(event, ui){
					if (box_event_drag_direction == 0) {
						if (Math.abs(ui.position.left - box_event_drag_start_point.left) > 35) {
							box_event_drag_direction = 1;
						} else if (Math.abs(ui.position.top - box_event_drag_start_point.top) > 35) {
							box_event_drag_direction = 2;
						}
					}
					if (box_event_drag_direction == 1) {
						ui.position.top = box_event_drag_start_point.top;
					} else if (box_event_drag_direction == 2) {
						ui.position.left = box_event_drag_start_point.left;
					} else {
						ui.position.top = box_event_drag_start_point.top;
						ui.position.left = box_event_drag_start_point.left;
					}
					moveDoingEventItem(j$(this));
				},
				stop: function(event, ui){
					if (box_event_drag_direction == 1) {
						ui.position.top = box_event_drag_start_point.top;
					} else if (box_event_drag_direction == 2) {
						ui.position.left = box_event_drag_start_point.left;
					} else {
						ui.position.top = box_event_drag_start_point.top;
						ui.position.left = box_event_drag_start_point.left;
					}
					moveStopEventItem(j$(this));
					box_event_drag_start_point.top = 0;
					box_event_drag_start_point.left = 0;
					box_event_drag_direction = 0;
				}
			});
			boxEvent.resizable({
				snap: ".event-cell",
				handles: "e",
				grid: 50,
				start: function(){
					resizeStartEventItem(j$(this));
				},
				resize: function(){
					resizeDoingEventItem(j$(this));
				},
				stop: function(){
					resizeStopEventItem(j$(this));
				}
			});
			
			boxEvent
			.mousedown(function(e){
				box_event_click_point.x = e.pageX;
				box_event_click_point.y = e.pageY;
			})
			.mouseup(function(e){
				if (box_event_click_point.x != e.pageX || box_event_click_point.y != e.pageY) {
					return;
				}
			//})
			//.click(function(){
				j$("div.event-item").css("z-index", 0);
				j$(this).css("z-index", 9);
			//})
			//.dblclick(function(){
				var oldEventId = j$(this).attr("eventId");
				var itemType = j$(this).attr("itemType");
				var statuss = j$(this).attr("achvstatus");
				
				if (itemType == 3) {
					var url = '<s:url action="schedule!toNursingId" includeParams="none" namespace="/js" />';
					j$.post(url, {nursingId: oldEventId}, function(data){
						if (data.nursingId > 0) {
							var url = '<s:url action="nursing!edit" includeParams="none" namespace="/" />';
							window.location = iesAddToken(url + "?id=" + data.nursingId + "&listType=3");
						}
					}, "json")
				} else {
					evt_open_editor(
							statuss == -2, oldEventId, itemType /* 2:Sechedule, 3:Achievement */, 
							function(event, oldId){ /* success */
								if (event.id == 0) {
									delete(events_buffer["id_" + oldId]);
									j$("div.event-item[eventId='" + oldId + "']").parent().detach();
								} else {
									events_buffer["id_" + event.id] = event;
									redrawEventItem(event);
									if (oldId != event.id) {
										redrawEventItem(events_buffer["id_" + oldId]);
									}
								}
								recountUndist();
							}, 
							function(message){ /* failed */
								window.location = iesAddToken(window.location.toString());
							}, 
							function(){ /* close */
							});
				}
			});
		}
		
		return boxEvent;
	}

	/* event item box - copy event item by tag id  */
	function copyEventItemBox(boxEvent) {
		var boxCopiedEvent = j$("<div copied><div box></div></div>").addClass("event-item");
		boxCopiedEvent.appendTo("<div class='event-item-box'></div>");
		boxCopiedEvent.css("left", boxEvent.css("left"));
		boxCopiedEvent.width(boxEvent.width());
		boxCopiedEvent.find("div[box]").html(boxEvent.find("div[box]").html());
		boxEvent.parent().parent().append(boxCopiedEvent.parent());
		
		if (box_event_is_coping_mode == false) {
			boxCopiedEvent.hide();
		}
		
		return boxCopiedEvent;
	}
	
	function recountUndist() {
		var count = 0;
		for (var key in events_buffer) {
			var event = events_buffer[key];
			var schedule = (event.achievement.status > 0 ? event.achievement : event.schedule);
			if (schedule.helper == null) {
				count++
			}
		}
		if (count == 0) {
			j$("#box_undist_count").hide();
		} else {
			j$("#box_undist_count").text(count);
			j$("#box_undist_count").show();
		}
	}

	/* event item box - move start  */
	function moveStartEventItem(boxEvent) {
		box_event_moving = boxEvent;
		box_event_copied = copyEventItemBox(boxEvent);
	}

	/* event item box - moving  */
	function moveDoingEventItem(boxEvent) {
		syncEventiItemFrame(boxEvent);
	}

	/* event item box - move end  */
	function moveStopEventItem(boxEvent) {
		syncEventiItemFrame(boxEvent);
		saveEventItemData(makeEventItemData(box_event_moving), false);
	}

	/* event item box - resize start  */
	function resizeStartEventItem(boxEvent) {
		box_event_moving = boxEvent;	
	}
	
	/* event item box - resizing  */
	function resizeDoingEventItem(boxEvent) {
		syncEventiItemFrame(boxEvent);
	}

	/* event item box - resize stop  */
	function resizeStopEventItem(boxEvent) {
		syncEventiItemFrame(boxEvent);
		saveEventItemData(makeEventItemData(box_event_moving), false);
	}

	/* event item box - sync helper & follower frame  */
	function syncEventiItemFrame(boxEvent) {
		var data = recalcEventItemValues(boxEvent);
		var boxItems = j$("div.event-item[eventId='" + boxEvent.attr("eventId") + "']");
		boxItems.css("left", data.frameLeft);
		boxItems.width(data.frameWidth);
		boxItems.find("div[time]").text(data.timeFromToText);	
	}

	/* event item box - recalculate event values from frame  */
	function recalcEventItemValues(boxEvent) {

		var top = parseInt(boxEvent.css("top"));
		var left = parseInt(boxEvent.css("left"));
		var width = parseInt(boxEvent.width());

		var unitWidth = (j$("div.event-row-scope").width() / schedule_work_time_count);
		var timeStartBoxIndex = Math.round(left / unitWidth);
		var timeEndBoxIndex = Math.round(width / unitWidth) + timeStartBoxIndex;
		var intTimeStartOfMinute = schedule_work_time_start * 60 + timeStartBoxIndex * schedule_work_time_unit;
		var intTimeEndOfMinute = schedule_work_time_start * 60 + timeEndBoxIndex * schedule_work_time_unit;

		var helperId = 0;
		var boxHelper = boxEvent.parent().parent();
		var helperDiffIndex = Math.round(top / 50);
		if (helperDiffIndex == 0) {
			helperId = boxHelper.attr("helperid");
		} else {
			var helperOldIndex = parseInt(boxHelper.attr("index"));
			helperId = j$(j$("div.event-row-scope div.event-row")[helperOldIndex + helperDiffIndex]).attr("helperid");
		}

		var result = new Object();
		result.helperId = helperId;
		result.frameTop = top;
		result.frameLeft = left;
		result.frameWidth = width;
		result.timeStartHour = parseInt(intTimeStartOfMinute / 60);
		result.timeStartMinute = intTimeStartOfMinute % 60;
		result.timeEndHour = parseInt(intTimeEndOfMinute / 60);
		result.timeEndMinute = intTimeEndOfMinute % 60;
		result.timeStart = formateIntTo2String(result.timeStartHour) + formateIntTo2String(result.timeStartMinute);
		result.timeEnd = formateIntTo2String(result.timeEndHour) + formateIntTo2String(result.timeEndMinute);
		result.timeFromToText = 
			formateIntTo2String(result.timeStartHour) + ":" +  
			formateIntTo2String(result.timeStartMinute) + "~" + 
			formateIntTo2String(result.timeEndHour) + ":" + 
			formateIntTo2String(result.timeEndMinute);

		return result;
	}
	function formateIntTo2String(val) {
		return (val < 10 ? "0" + val : "" + val)
	}
	
	/* event item box - copy start  */
	function copyEventItemStart() {
		box_event_is_coping_mode = true;
		if (box_event_copied != null) {
			box_event_copied.show();
		}
	}

	/* event item box - copy stop  */
	function copyEventItemStop() {
		box_event_is_coping_mode = false;
		if (box_event_copied != null) {
			box_event_copied.hide();
		}
	}

	/* event item box - save date 
	   (eventId, type, copied, customerId, serviceYm, serviceCode, serviceDate, timeStart, timeEnd, helperId, followerId, travelTime, additionFirst, additionEmergency) 
	*/
	function saveEventItemData(eventItemData, isUndo) {

		if (http_post_is_busying == true) return;
	
		// box_event_moving, box_event_copied
		var url = '<s:url action="event!save" includeParams="none" namespace="/js" />';
		j$.post(url, eventItemData, function(data){
			
					var oldEventId = eventItemData.eventId;
					
					if (data.result == "success") {
						
						j$("#warning_messager").attr("type", "msg");
						
						var newEvent = data.event;
						
						events_buffer["id_" + newEvent.id] = newEvent;
						redrawEventItem(newEvent);
						if (oldEventId != newEvent.id) {
							redrawEventItem(events_buffer["id_" + oldEventId]);
						}

						if (isUndo == true) {
							send_data_undo_buffer.pop();
							if (send_data_undo_buffer.length == 0) {
								j$("#buttonUndoHelper").hide();
							}
						} else {
							send_data_undo_buffer.push(eventItemData);
						}
						
						recountUndist();
						clearMessageAfter(1);
					} else {
						redrawEventItem(events_buffer["id_" + oldEventId]);
						j$("#warning_messager").attr("type", "err");
						clearMessageAfter(5);
					}
					j$("#warning_messager").html(data.message);
				}, "json")
				.done(function(){
					http_post_is_busying == true;
				})
				.fail(function(){
					window.location = iesAddToken(window.location.toString());
				})
				.always(function(){
					http_post_is_busying == false;
					if (box_event_copied != null) {
						box_event_copied.detach();
						box_event_copied = null;
					}
					box_event_moving = null;
				});
	}
	function makeEventItemData(boxEvent) {
		/* eventId, type, copied, customerId, serviceYm,
		   serviceCode, serviceDate, timeStart, timeEnd, 
		   helperId, followerId, travelTime, additionFirst, additionEmergency
		 */
		var eventId = boxEvent.attr("eventId");
		var event = events_buffer["id_" + eventId];
		var schedule = (event.achievement.status > 0 ? event.achievement : event.schedule);
		var data = recalcEventItemValues(boxEvent);
		
		var result = new Object();
		result.eventId = eventId;
		result.type = schedule.type;
		result.copied = (box_event_copied != null && box_event_is_coping_mode ? 1 : 0);
		result.customerId = event.customer.id;
		result.serviceYm = event.serviceYm;
		result.serviceCode = schedule.service.code;
		result.serviceDate = schedule.serviceDate;
		result.timeStart = data.timeStart;
		result.timeEnd = data.timeEnd;
		result.serviceTime1 = schedule.serviceTime1;
		result.serviceTime2 = schedule.serviceTime2;
		result.helperId = (boxEvent.attr("type") == "helper" ? data.helperId : (schedule.helper == null ? 0 : schedule.helper.id));
		result.followerId = (boxEvent.attr("type") == "follower" ? data.helperId : (schedule.follower == null ? 0 : schedule.follower.id));
		result.travelTime = schedule.travelTime;
		result.additionFirst = schedule.additionFirst;
		result.additionEmergency = schedule.additionEmergency;
		result.remark = event.remark;
		
		return result;
	}

	/* event item box - undo save date  */
	function undoSaveEventItemData() {
		if (send_data_undo_buffer.length > 0) {
			var data = send_data_undo_buffer[send_data_undo_buffer.length - 1];
			saveEventItemData(data, true);
		}
	}

	/* event item box - create date  */
	function createEventItemData() {
		var day = ${searchServiceDay};
		var defval = {serviceYm: "${searchServiceYm}", serviceDate:"${searchServiceYm}" + (day < 10 ? "0" : "") + day };
		evt_open_editor(
				0, 0, 2 /* Sechedule */, 
				function(event){ /* success */
					events_buffer["id_" + event.id] = event;
					redrawEventItem(event);
					recountUndist();
				}, 
				function(message){ /* failed */
					window.location = iesAddToken(window.location.toString());
				}, 
				function(){ /* close */
				}, defval);
	}
	
	/* message box - set clear timer */
	function clearMessageAfter(interval) { // unit is second
		if (clear_message_timer != null) {
			clearTimeout(clear_message_timer);
		}
		clear_message_timer = setTimeout(clearMessageAndTimer, interval * 1000);
	}

	/* message box - clear with timer */
	function clearMessageAndTimer() {
		j$("#warning_messager").html("");
		clear_message_timer = null;
	}

	/* change search date */
	function changeSelectedYmd(ym, day) {
		if (ym != null && ym.length == 6 && day != null && day.length > 0) {
			var url = '<s:url action="schedule" includeParams="none" namespace="/" />';
			window.location = iesAddToken(url + "?searchServiceYm=" + ym + "&searchServiceDay=" + day);
		}
	}
	
	function changeSelectedToday() {
		<s:url id="url" action="schedule" includeParams="none" namespace="/">
			<s:param name="clear" value="true" />
		</s:url>
		window.location=iesAddToken('${url}');
	}
	
	function changePreview(derict, lineHelperId) {
		var view = ${view} + derict;
		var ym = j$("#searchServiceYm").val();
		var day = j$("#searchServiceDay").val();
		if (ym != null && ym.length == 6 && day != null && day.length > 0) {
			var url = '<s:url action="schedule" includeParams="none" namespace="/" />';
			window.location = iesAddToken(url + "?searchServiceYm=" + ym + "&searchServiceDay=" + day + (view != 0 ? "&view=" + view : "") + "&lineHelperId=" + lineHelperId);
		}
	}
	
	/* submit search form */
	function submitForm() {
		//j$("#form_search").submit();
		changeSelectedYmd(j$("#searchServiceYm").val(), j$("#searchServiceDay").val());
	}
	

	j$(function(){

		j$("#downloadPdfHelperMonthShiftDialog").dialog({
			title: "職員別月間シフト印刷",
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
								var url = '<s:url action="pdf-download!helperMonthShift" includeParams="none" namespace="/" />';
								var param = {};
								param["helperId"] = j$("#downloadPdfHelperMonthShift_helperId").val();
								param["selectedYM"] = j$("#downloadPdfHelperMonthShift_selectedYM").val();
								
								url += "?helperId=" + param["helperId"] + "&selectedYM=" + param["selectedYM"];
								window.location = iesAddToken(url);
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
		var mainContainer = j$("#eventGridBox");
		mainContainer.animate({
		    scrollTop: parseInt("<s:property value='scrollOffset'/>")
		}, 0);
	});
	
	function downloadPDFHelperMonthShift() {
		j$("#downloadPdfHelperMonthShiftDialog").dialog("open");
	}
	
</script>
</head>
<body>
	<div id="scheduleBox">
		<div id="headerBox">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td align="left" style="padding-left: 20px;" valign="bottom">
						<div class="sample-icon" type="0"></div>
						<div class="sample-text">予定</div>
						<div class="sample-icon" type="-12"></div>
						<div class="sample-text">実施中</div>
						<div class="sample-icon" type="-11"></div>
						<div class="sample-text">未実施</div>
						<div class="sample-icon" type="-2"></div>
						<div class="sample-text">キャンセル</div>
						<div class="sample-icon" type="3"></div>
						<div class="sample-text">終了</div>
						<div class="sample-icon" type="3m"></div>
						<div class="sample-text">終了（変更）</div>
						<div class="sample-icon" type="3n"></div>
						<div class="sample-text">終了（新規）</div>
						<div class="sample-icon" type="2"></div>
						<div class="sample-text">承認</div>
					</td>
					<td align="left" class="warning">
						<div id="warning_messager" class="warning-box"></div>
					</td>
					<td align="right"><s:form id="form_search" action="schedule">
							<div id="dateBox">
								<!-- 
				<a id="buttonUndoHelper" href="javascript:void(0)" onclick="undoSaveEventItemData();" style="display:none;font-size:15px;">UNDO</a>
				&nbsp;&nbsp;&nbsp;
				 -->
								<table>
									<tr>
										<td><a href="javascript:void(0);"
											onclick="changeSelectedYmd('${prevMonth}', '${prevDay}');">
												<img src="<s:url value='/images/p2/button_left.png'/>"
												width="22" style="margin: 3px 5px 0 0;" />
										</a></td>
										<td>
											<div class="today" onclick="changeSelectedToday();">今日</div>
										</td>
										<td><s:textfield name="searchDate" id="searchDate" cssStyle="width:100px;height:19px;"
										 cssClass="disable-ime" maxlength="15" readonly="true" onchange="submitForm();"/>
										<s:hidden id="searchServiceYm" name="searchServiceYm"  
												cssStyle="font-size:15px;"></s:hidden>
											<s:hidden id="searchServiceDay" name="searchServiceDay"
											 style="font-size: 15px;"></s:hidden></td>
										<td><a href="javascript:void(0);"
											onclick="changeSelectedYmd('${nextMonth}', '${nextDay}');">
												<img src="<s:url value='/images/p2/button_right.png'/>"
												width="22" style="margin: 3px 0 0 5px;" />
										</a></td>
									</tr>
								</table>
							</div>
						</s:form></td>
				</tr>
			</table>
		</div>
		<div id="contentBox">
		
			<s:set name="workTimeStart"
				value="%{getSystemOption('work.time.drag.start')}" />
			<s:set name="workTimeEnd"
				value="%{getSystemOption('work.time.drag.end')}" />
			<s:set name="workTimeUnit"
				value="%{getSystemOption('work.time.drag.unit')}" />
			<s:set name="workTimeUnitCount" value="60/#workTimeUnit" />
			<s:set name="colHeight" value="%{(helperCount+1)*52}" />
			<div class="event event-header">
			
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td>&nbsp</td>
						<td>&nbsp</td>
						<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]"
							status="rowStatus">
							<s:set name="testval" value="#workTimeStart*1+#rowStatus.index" />
							<td class="time"><s:if test="#testval<10">0</s:if>${workTimeStart+rowStatus.index}:00</td>
						</s:iterator>
					</tr>
				</table>
			</div>
			<div id="eventGridBox" class="event event-grid">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td>&nbsp</td>
						<td>&nbsp</td>
						<s:iterator value="new int[#workTimeEnd-#workTimeStart+1]"
							status="rowStatus">
							<s:iterator value="new int[#workTimeUnitCount]"
								status="cellStatus">
								<td>
									<div style="height:${colHeight}px"
										class="event-cell event-col <s:property value="#cellStatus.index==0?'event-hours':'event-minute'"/>"
										hours="${workTimeStart+rowStatus.index}"
										minute="${cellStatus.index*workTimeUnit}"></div>
								</td>
							</s:iterator>
						</s:iterator>
					</tr>
					<tr height="1">
						<td colspan="2">
							<div class="event-rows1" style="top:-${colHeight}px">
								<div class="event-rows2 event-row-title">
									<div class="event-row">
										<div class="undist">未割当</div>
										<div id="box_undist_count" class="undist-count">50</div>
									</div>
									<s:iterator value="helpers" status="rowStatus">
										<s:set name="helperCount" value="%{#rowStatus.count}" />
										<div class="event-row">
											<div>${userCodeShort}<br />${userName}</div>
										</div>
									</s:iterator>
								</div>
							</div>
						</td>
						<td colspan="${(workTimeEnd-workTimeStart+1)*workTimeUnitCount}">
							<div class="event-rows1" style="top:-${colHeight}px;">
								<div class="event-rows2 event-row-scope">
									<div id="event_helper_0" class="event-cell event-row"
										helperId="0" index="0">
										<div class="event-more-left">
											<span onclick="changePreview(-1, 0);">&lt;&lt;</span>
										</div>
										<div class="event-more-right">
											<span onclick="changePreview(1, 0);">&gt;&gt;</span>
										</div>
									</div>
									<s:iterator value="helpers" status="rowStatus">

										<div id="event_helper_${id}" class="event-cell event-row"
											helperId="${id}" index="${rowStatus.index+1}">
											<div class="event-more-left">
												<span onclick="changePreview(-1, ${id});">&lt;&lt;</span>
											</div>
											<div class="event-more-right">
												<span onclick="changePreview(1, ${id});">&gt;&gt;</span>
											</div>
										</div>

									</s:iterator>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" nowrap>
				<div style="padding-left: 30px;">
					<s:a href="javascript:downloadPDFHelperMonthShift();"
						style="text-decoration:underline; cursor:pointer;">
					職員別月間シフト印刷
			</s:a>
				</div>
			</td>
			<%-- <td align="center" nowrap><img
				src="<s:url value='/images/p2/button_actual.png'/>" width="32" /> <br />
				<a
				href="<s:url action="nursing!edit" includeParams="none" namespace="/" ><s:param name="listType" value="3" /></s:url>"
				class="link-action2" style="font-size: 15px;">介護記録・新規</a></td>
			<td nowrap>&nbsp;&nbsp;&nbsp;</td> --%>
			<td align="center" nowrap><img
				src="<s:url value='/images/p2/button_shift.png'/>" width="32" /> <br />
				<a href="javascript:void(0)" onclick="createEventItemData();"
				class="link-action2" style="font-size: 15px;">シフト・新規</a></td>
		</tr>
	</table>

	<div id="downloadPdfHelperMonthShiftDialog">
		<table cellpadding="8" style="padding: 10px;">
			<tr>
				<td>職員：</td>
				<td><s:select id="downloadPdfHelperMonthShift_helperId"
						cssStyle="width:160px;" list="helpers" listKey="id"
						listValue="userName" /></td>
			</tr>
			<tr>
				<td>サービス年月：</td>
				<td><s:select id="downloadPdfHelperMonthShift_selectedYM"
						list="yearMonths" listKey="key" listValue="label"
						value="searchServiceYm" cssStyle="font-size:15px;"></s:select></td>
			</tr>
			<tr>
		</table>
	</div>
</body>
</html>
