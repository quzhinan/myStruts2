/* iemeeting common */

var ies_prev_token = "";

function iesAddTokenSubmit(url) {

	var index = url.indexOf("ietoken=");
	if (index > 0) {
		url = url.substring(0, index);
	} else {
		if (url.indexOf("?") > 0) {
			url += "&";
		} else {
			url += "?";
		}
	}
	url += "ietoken=" + j$.cookie('ietoken');
	
	return url;
}

function iesAddToken(url) {
	if (url.indexOf("download") >= 0 || url.indexOf("csv-load") >= 0) {

	} else {
		var curr_token = j$.cookie('ietoken');
		if (ies_prev_token == curr_token) {
			url = "javascript:void(0);";
		} else {
			url = iesAddTokenSubmit(url);
			ies_prev_token = curr_token;
		}
	}
	return url;
}

function iesCheckAll(formId, isChecked) {
	j$("#" + formId + " input:checkbox").prop("checked", isChecked);
}

function iesClearInput(formId) {
	j$("#" + formId + " input:text").val("");
	j$("#" + formId + " input:checkbox").prop("checked", false);
	j$("#" + formId + " select").each(function(){
		j$(this).find("option:first").prop("selected", true);
	});
}

function iesClearSearch() {
	j$("#" + formId + " input:text").val("");
	j$("#" + formId + " input:checkbox").prop("checked", false);
}

function trimBothSides(text) {
     return text.replace(/(^\s*)|(\s*$)/g,'');
}

function trimLeft(text) {
     return text.replace(/(^\s*)/g,'');
}

function trimRight(text) {
     return text.replace(/(\s*$)/g,'');
}

function scrollToShowItem(itemId, listId) {
	if (itemId == null || itemId.length == 0 || listId == null || listId.length == 0 || 
			j$("#" + itemId).length == 0 || j$("#" + itemId).length == 0) {
		return;
	}
	var item = j$("#" + itemId);
	var list = j$("#" + listId);
	
	if(item.offset().top - list.offset().top > list.height()) {
		list.scrollTop(item.offset().top - list.offset().top - (list.height() / 2) + 30);
	}
}

