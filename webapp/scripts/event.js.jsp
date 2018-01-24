<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/javascript; charset=UTF-8" %>

function evt_open_editor_week(eventId, itemType, callbackSuccess, callbackFailed, callbackClose, defval) {

	var url = '<s:url action="event-page" includeParams="none" namespace="/js" />';
	var box = j$("#evt_editor_box");
	if (box.length == 0) {
		box = j$("<div id='evt_editor_box' title='イベント編集'></div>");
		box.appendTo(j$(document.body));
		box.dialog({
			autoOpen: false,
			resizable: false,
			modal: true,
			width: 700,
			height: 580,
			close: function(event, ui) {
				if (callbackClose != undefined) {
					callbackClose();
				}
			}
		});
	} else {
		box.html("");
	}
	
	var buttons = new Array();
	if (eventId > 0) {
		box.dialog("option", "title", "イベント変更");
		if (itemType == 2) {	/* schedule */
			buttons.push(
					{
						text: "実績編集", 
						click: function(){
							evt_modify_item_data(callbackSuccess, callbackFailed, eventId);
						}
					},
					{
						text: "キャンセル扱い", 
						click: function(){
							if (confirm("この訪問サービスをキャンセルしてよろしいですか。") == true) {
								evt_cancel_item_data(callbackSuccess, callbackFailed);
							}
						}
					});
		}
		buttons.push(
				{
					text: "削除", 
					click: function(){
						if (confirm("この訪問サービスを削除してよろしいですか。") == true) {
							evt_delete_item_data(callbackSuccess, callbackFailed);
						}
					}
				}
		);
		if (itemType == 2) {	/* schedule */
			buttons.push(
					{
						text: "コピー", 
						click: function(){
							evt_copy_item_data(callbackSuccess, callbackFailed);
						}
					}
			);
		}
		buttons.push(
				{
					text: "保存", 
					click: function(){
						evt_save_item_data(callbackSuccess, callbackFailed);
					}
				},
				{
					text: "閉じる", 
					click: function(){
						j$(this).dialog("close");
					}
				}
		);
	} else {
		box.dialog("option", "title", "イベント新規");
		buttons.push(
				{
					text: "登録", 
					click: function(){
						evt_save_item_data(callbackSuccess, callbackFailed);
					}
				},
				{
					text: "閉じる", 
					click: function(){
						j$(this).dialog("close");
					}
				}
		);
	}
	box.dialog("option", "buttons", buttons);
	box.dialog({
  		open: function( event, ui ) {
			j$("[name=serviceCode]").focus();
			j$("[name=serviceDate]").datepicker({
				dateFormat: "yymmdd",
				onClose: function(selectedDate) {
					j$("[name=timeStartHour]").focus();
					if (eventId == 0) {
						j$("#serviceYm").val(selectedDate.substring(0, 6));
					}
				}
			});
  		}
	});
	box.load(url, {id: eventId, type: itemType}, function(){
		if (eventId == 0 && defval != undefined) {
			for (var key in defval) {
				box.find("[name='" + key  + "']").val(defval[key]);
			}
		}
		box.dialog("open");
		
		var buttonset = box.parent().find(".ui-dialog-buttonset");
		if (buttonset.find("button").length > 3) {
			var buttons = new Array();
			buttons[0] = buttonset.find("button")[0];
			buttons[1] = buttonset.find("button")[1];
			for (var i=0; i<buttons.length; i++) {
				j$(buttons[i]).find("span").css("background-color", "#f5f435");
				j$(buttons[i]).find("span").css("border-radius", "5px");
			}
			j$(buttons[buttons.length-1]).css("margin-right", "30px");
		}
	});
}

function evt_open_editor(isCancel, eventId, itemType, callbackSuccess, callbackFailed, callbackClose, defval) {

	var url = '<s:url action="event-page" includeParams="none" namespace="/js" />';
	var box = j$("#evt_editor_box");
	if (box.length == 0) {
		box = j$("<div id='evt_editor_box' title='イベント編集'></div>");
		box.appendTo(j$(document.body));
		box.dialog({
			autoOpen: false,
			resizable: false,
			modal: true,
			width: 700,
			height: 620,
			close: function(event, ui) {
				if (callbackClose != undefined) {
					callbackClose();
				}
			}
		});
	} else {
		box.html("");
	}
	
	var buttons = new Array();
	if (eventId > 0) {
		box.dialog("option", "title", "イベント変更");
		if (itemType == 2) {	/* schedule */
			if(isCancel) {
				buttons.push(
					{
						text: "実績編集", 
						click: function(){
							evt_modify_item_data(callbackSuccess, callbackFailed, eventId);
						}
					},
					{
						text: "キャンセル解除", 
						click: function(){
							if (confirm("この訪問サービスをキャンセル解除してよろしいですか。") == true) {
								evt_not_cancel_item_data(callbackSuccess, callbackFailed);
							}
						}
					});
			} else {
				buttons.push(
					{
						text: "実績編集", 
						click: function(){
							evt_modify_item_data(callbackSuccess, callbackFailed, eventId);
						}
					},
					{
						text: "キャンセル扱い", 
						click: function(){
							if (confirm("この訪問サービスをキャンセルしてよろしいですか。") == true) {
								evt_cancel_item_data(callbackSuccess, callbackFailed);
							}
						}
					});
			}
			
		}
		buttons.push(
				{
					text: "削除", 
					click: function(){
						var isPlus = j$("input[name='achievementExist']").val();
						var msg = "この訪問サービスを削除してよろしいですか。" + (isPlus == "true" ? "（注意：訪問記録が存在します。）" : "");
						if (confirm(msg) == true) {
							evt_delete_item_data(callbackSuccess, callbackFailed);
						}
					}
				}
		);
		if (itemType == 2) {	/* schedule */
			buttons.push(
					{
						text: "コピー", 
						click: function(){
							evt_copy_item_data(callbackSuccess, callbackFailed);
						}
					}
			);
		}
		buttons.push(
				{
					text: "保存", 
					click: function(){
						evt_save_item_data(callbackSuccess, callbackFailed);
					}
				},
				{
					text: "閉じる", 
					click: function(){
						j$(this).dialog("close");
					}
				}
		);
	} else {
		box.dialog("option", "title", "イベント新規");
		buttons.push(
				{
					text: "登録", 
					click: function(){
						evt_save_item_data(callbackSuccess, callbackFailed);
					}
				},
				{
					text: "閉じる", 
					click: function(){
						j$(this).dialog("close");
					}
				}
		);
	}
	box.dialog("option", "buttons", buttons);
	box.dialog({
  		open: function( event, ui ) {
			j$("[name=serviceCode]").focus();
			j$("[name=serviceDate]").datepicker({
				dateFormat: "yymmdd",
				onClose: function(selectedDate) {
					j$("[name=timeStartHour]").focus();
					if (eventId == 0) {
						j$("#serviceYm").val(selectedDate.substring(0, 6));
					}
				}
			});
  		}
	});
	var customerId;
	if (defval == undefined) {
		customerId = 0;
	} else {
		if (defval['customerId'] != null) {
			customerId = defval['customerId'];
		} else {
			customerId = -1;
		}
	}
	box.load(url, {id: eventId, type: itemType, defaultCustomerId: customerId}, function(){
		if (eventId == 0 && defval != undefined) {
			for (var key in defval) {
				box.find("[name='" + key  + "']").val(defval[key]);
			}
		}
		box.dialog("open");
		
		var buttonset = box.parent().find(".ui-dialog-buttonset");
		if (buttonset.find("button").length > 3) {
			var buttons = new Array();
			buttons[0] = buttonset.find("button")[0];
			buttons[1] = buttonset.find("button")[1];
			for (var i=0; i<buttons.length; i++) {
				j$(buttons[i]).find("span").css("background-color", "#f5f435");
				j$(buttons[i]).find("span").css("border-radius", "5px");
			}
			j$(buttons[buttons.length-1]).css("margin-right", "30px");
		}
	});
}


function evt_save_item_data(callbackSuccess, callbackFailed) {
	var url = '<s:url action="event!save" includeParams="none" namespace="/js" />';
	evt_post_item_data(url, callbackSuccess, callbackFailed);
}

function evt_copy_item_data(callbackSuccess, callbackFailed) {
	var url = '<s:url action="event!copy" includeParams="none" namespace="/js" />';
	evt_post_item_data(url, callbackSuccess, callbackFailed);
}

function evt_delete_item_data(callbackSuccess, callbackFailed) {
	var url = '<s:url action="event!delete" includeParams="none" namespace="/js" />';
	evt_post_item_data(url, callbackSuccess, callbackFailed);
}

function evt_cancel_item_data(callbackSuccess, callbackFailed) {
	var url = '<s:url action="event!cancel" includeParams="none" namespace="/js" />';
	evt_post_item_data(url, callbackSuccess, callbackFailed);
}

function evt_not_cancel_item_data(callbackSuccess, callbackFailed) {
	var url = '<s:url action="event!notCancel" includeParams="none" namespace="/js" />';
	evt_post_item_data(url, callbackSuccess, callbackFailed);
}

function evt_modify_item_data(callbackSuccess, callbackFailed, eventId) {
	var url = '<s:url action="schedule!toNursingId" includeParams="none" namespace="/js" />';
	j$.post(url, {nursingId: eventId}, function(data){
		if (data.nursingId > 0) {
			var url = '<s:url action="nursing!edit" includeParams="none" namespace="/" />';
			window.location = iesAddToken(url + "?id=" + data.nursingId + "&listType=3");
		}
	}, "json")
}

function evt_post_item_data(url, callbackSuccess, callbackFailed) {
	var box = j$("#evt_editor_box");
	var itemData = evt_make_item_data();

	box.find("div.evt-message").html("&nbsp;");
	j$.post(url, itemData, function(data){
				var oldId = box.find("[name=eventId]").val();
				if (data.result == "success") {
					box.dialog("close");
					if (callbackSuccess != undefined) {
						callbackSuccess(data.event, oldId);
					}
				} else {
					box.find("div.evt-message").html(data.message);
				}
			}, "json")
			.done(function(){
			})
			.fail(function(){
				if (callbackFailed != undefined) {
					callbackFailed("");
				}
			})
			.always(function(){
			});
}

function evt_make_item_data() {
	/* eventId, type, copied, customerId, serviceYm,
	   serviceCode, serviceDate, timeStart, timeEnd, 
	   helperId, followerId, travelTime, additionFirst, additionEmergency
	 */
	var result = new Object();
	var box = j$("#evt_editor_box");
	
	box.find(".item-data").each(function(){
		if (j$(this).is("[type=checkbox]")) {
			if (j$(this).is(":checked")) {
				result[j$(this).attr("name")] = 1;
			} else {
				result[j$(this).attr("name")] = 0;
			}
		} else {
			result[j$(this).attr("name")] = j$(this).val();
		}
	});
	result.timeStart = result.timeStartHour + result.timeStartMinute;
	result.timeEnd = result.timeEndHour + result.timeEndMinute;
	
	return result;
}