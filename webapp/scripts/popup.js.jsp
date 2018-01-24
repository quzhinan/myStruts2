<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/javascript; charset=UTF-8" %>

/* iemeeting popup */

var _iesPopupUserListSingleSelect_Callback;

function iesPopupUserListSingleSelect(callback) {
	callback(1, "Administrator");
<%-- 	_iesPopupUserListSingleSelect_Callback = callback;
	j$( "#dialog:ui-dialog" ).dialog( "destroy" );
	j$('<div id="ies_popup_user_list_single_select" title="TEST"></div>').dialog({
        bgiframe: true,
        autoOpen: false,
        height: 450,
        width: 600,
        modal: true,
        buttons: {
            '<s:text name="labels.button.cancel"/>': function() {
                    j$(this).dialog('close');
                }
            }
        });
	j$('#ies_popup_user_list_single_select').dialog('open'); --%>
}