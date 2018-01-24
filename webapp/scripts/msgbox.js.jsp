<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/javascript; charset=UTF-8" %>

j$(document).ready(function(){

	if( j$("#msgDialogJQ").length == 0 ) 
		j$("body").append("<div id='msgDialogJQ'><p id='msgContentJQ'></p></div>");
});

/*
 * icon:
 *   1: alert
 *   2: info
 *   3: notice
 */
function msgBox(msg,title,icon) {
	j$("#msgDialogJQ").dialog( "destroy" );
	j$("#msgContentJQ").empty();
	var str;
	if( icon == 1 )
		str = "<span class='ui-icon ui-icon-alert' style='float:left; margin:0 7px 50px 0;'></span>";
	else
	if( icon == 2 )
		str = "<span class='ui-icon ui-icon-info' style='float:left; margin:0 7px 50px 0;'></span>";
	else
	if( icon == 3 )
		str = "<span class='ui-icon ui-icon-notice' style='float:left; margin:0 7px 50px 0;'></span>";
	j$("#msgContentJQ").append("<p>"+str+msg+"</p>");
	j$("#msgDialogJQ").dialog({
		modal : true,
		title : title,
		resizable : true,
		draggable : true,
		buttons : {
			Ok : function() {
				j$(this).dialog("close");
			}
		}
	});
}

function alertMsgBox(message) {
	msgBox(message,'<s:text name="labels.system.title"/>',1);
}

function confirmBox(msg,title,button1text,button2text,onYes,onNo) {
	j$("#msgDialogJQ").dialog( "destroy" );
	j$("#msgContentJQ").empty();
	j$("#msgContentJQ").append("<p>"+msg+"</p>");
	var buttons = new Object();
	buttons[button1text] = function() {
		j$(this).dialog("close");
		onYes();
	};
	buttons[button2text] = function() {
		j$(this).dialog("close");
		onNo();
	};
	j$("#msgDialogJQ").dialog({
		modal : true,
		title : title,
		resizable : true,
		draggable : true,
		buttons : buttons
	});
}

function askBox(msg,onYes) {
	confirmBox( msg,
		"<s:text name='labels.system.title'/>",
		"<s:text name='labels.button.yes'/>",
		"<s:text name='labels.button.no'/>",
		onYes,
		function(){}
		 );
}
