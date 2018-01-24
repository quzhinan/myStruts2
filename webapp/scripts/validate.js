function trimBothSidesWithSBC(text) {

    // return text.replace(/^( |[\s ])+|( |[\s ])+$/g, "").replace(/^ +|
	// +$/g,"");
    if(text != null && text != undefined){
    	return text.replace(/(^\s*)|(\s*$)/g,'');
	} else{
		return '';
	}
}


function AddTip( jObj, msg, idMsg, bAutoID ) {
	
	jObj.addClass( "ui-state-error" );
	
	var tips = j$( "#validateTips" );
	
	if( bAutoID )
		idMsg = jObj[0].id + idMsg + "ErrMsg";
	else
		idMsg = idMsg + "ErrMsg";
		
	if( tips.find("#"+idMsg).size() == 0 )
		tips.append("<li id='" + idMsg + "'><span>"+msg+"</span></li>");
		
	tips.addClass( "errorMessage" );
		
	//jObj.focus();
}
	
function delTip( jObj, idMsg, bAutoID ) {
	jObj.removeClass( "ui-state-error" );
		
	var tips = j$( "#validateTips" );
	
	if( bAutoID )
		idMsg = jObj[0].id + idMsg + "ErrMsg";
	else
		idMsg = idMsg + "ErrMsg";
	
	tips.find("#"+idMsg).remove();
		
	if( j$( "#validateTips>li" ).size() == 0 ) {
		tips.removeClass( "errorMessage" );
	}
	else {
		tips.addClass( "errorMessage" );
	}
}

function clearTip( formId ) {
	
	j$( "#validateTips>li" ).remove();
	
	var tips = j$( "#validateTips" );
	
	tips.removeClass( "errorMessage" );
	
	j$("#" + formId + " input:text").removeClass( "ui-state-error" );
	
	j$("#" + formId + " input:checkbox").removeClass( "ui-state-error" );
}

function checkLength( jObj, msg, min, max ) {
	
	if ( jObj.val().length > max || jObj.val().length < min ) {
		AddTip( jObj, msg, "Len", true );
		return false;
	} else {
		delTip( jObj, "Len", true );
		return true;
	}
}
	
function checkRegexp( jObj, regexp, msg ) {
	
	if ( !( regexp.test( jObj.val() ) ) ) {
		AddTip( jObj, msg, "Reg", true );
		return false;
	} else {
		delTip( jObj, "Reg", true );
		return true;
	}
}
function checkFromToDate(jObj1,jObj2,msg){
		
	if(jObj1.val().length == 0 || jObj2.val().length == 0)
		return true;
	
	if(jObj1.val()>(jObj2.val()))
	{
		AddTip( jObj1, msg, 'FTDate', false);
		AddTip( jObj2, msg, 'FTDate', false);
		return false;
	}else{
		delTip( jObj1, 'FTDate', false);
		delTip( jObj2, 'FTDate', false);
		return true;
	}

	return true;
}

function checkFromToTime(jObjFromHour,jObjFromMin,jObjToHour,jObjToMin,msg){
	var strDt1 = "2014-01-01 "+jObjFromHour.val()+":"+jObjFromMin.val() + ":00";
	var strDt2 = "2014-01-01 "+jObjToHour.val()+":"+jObjToMin.val() + ":00";
	strDt1 = strDt1.replace(/-/g,"/");
	strDt2 = strDt2.replace(/-/g,"/");
	var dt1 = new Date(Date.parse(strDt1));
	var dt2 = new Date(Date.parse(strDt2));
	if(dt1>=dt2)
	{
		AddTip( jObjFromHour, msg, 'FTTime', false);
		AddTip( jObjFromMin, msg, 'FTTime', false);
		AddTip( jObjToHour, msg, 'FTTime', false);
		AddTip( jObjToMin, msg, 'FTTime', false);
		return false;
	}else{
		delTip( jObjFromHour, 'FTTime', false);
		delTip( jObjFromMin, 'FTTime', false);
		delTip( jObjToHour, 'FTTime', false);
		delTip( jObjToMin, 'FTTime', false);
		return true;
	}

	return true;
}

function checkListKey( jObj, msg ) {
	if (jObj.val() == 0 ) {
		AddTip( jObj, msg, "Emp", true );
		
		return false;
	} else {
		delTip( jObj, "Emp", true );
		return true;
	}
}

function checkUnInit( jObj, msg ) {
	if (jObj.val() == 0.0 ) {
		AddTip( jObj, msg, "Emp", true );
		
		return false;
	} else {
		delTip( jObj, "Emp", true );
		return true;
	}
}

function checkPositive( jObj, msg ) {
	if (jObj.val() < 0 ) {
		AddTip( jObj, msg, "Emp", true );
		
		return false;
	} else {
		delTip( jObj, "Emp", true );
		return true;
	}
}

function checkEmpty( jObj, msg ) {
	if( jObj.val().length == 0 ) {
		AddTip( jObj, msg, "Emp", true );
		
		return false;
	} else {
		delTip( jObj, "Emp", true );
		return true;
	}
}

function checkPasswordEight(jPwd, msg) {
	if(jPwd.attr("disabled")) return true;
	var p = jPwd.val();
	
	if( p.length < 8 || p.length > 24 ) {
		AddTip( jPwd, msg, "Emp", true );
		return false;
	} else {
		delTip( jPwd, "Emp", true );
		return true;
	}
}

function checkPasswordNumbersEnglish(jPwd, msg) {
	if(jPwd.attr("disabled")) return true;
	var p = jPwd.val();
	var reg = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/);;
	if(!reg.test(p)) {
		AddTip( jPwd, msg, "Emp", true );
		return false;
	} else {
		delTip( jPwd, "Emp", true );
		return true;
	}
}

function checkPasswordSame( jPwd1, jPwd2, msgRequired, msgdiff ) {

	var p1 = jPwd1.val();
	
	if( p1.length == 0 ) {
		AddTip( jPwd1, msgRequired, "Emp", true );
		return false;
	} else {
		delTip( jPwd1, "Emp", true );
	}
	
	var p2 = jPwd2.val();
	
	if( p1 != p2 ) {
		AddTip( jPwd2, msgdiff, "Pas", true );
		return false;
	} else {
		delTip( jPwd2, "Pas", true );
		return true;
	}
}

function checkTimeEndBiggerThanTimeStart(timeStartHourObject, timeStart, timeEnd, msg) {
	if(timeStart >= timeEnd) {
		AddTip( timeStartHourObject, msg, "Emp", true );
		return false;
	} else {
		delTip( timeStartHourObject, "Emp", true );
		return true;
	}
}

function checkTimeCorrect(timeStartHourObject, timeTotal, time1, time2, msg) {
	if(timeTotal != (time1 + time2)) {
		AddTip( timeStartHourObject, msg, "Emp", true );
		return false;
	} else {
		delTip( timeStartHourObject, "Emp", true );
		return true;
	}
}

function checkMustNotSame( jPwd1, jPwd2, msgSame) {

	var p1 = jPwd1.val();

	var p2 = jPwd2.val();
	
	if( p1 == p2 ) {
		AddTip( jPwd2, msgSame, "Pas", true );
		return false;
	} else {
		delTip( jPwd2, "Pas", true );
		return true;
	}
}

function clearValidateTipOfPassword( jPwd1, jPwd2 ) {
	delTip( jPwd1, "Emp", true );
	delTip( jPwd2, "Pas", true );
}

function checkPassword( jObj, msg ) {
	return checkRegexp( jObj, /^([0-9a-zA-Z])+$/, msg );
}

function checkMail( jObj, msg ) {
	return checkRegexp( jObj, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, msg )
}

//YYYY-MM-DD or YYYY-M-D
function checkDate( jObj, msg ) {
	var regex = new RegExp(/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29))$/);
	return checkRegexp( jObj, regex, msg );
}

//YYYY-MM-DD
function checkDateFull( jObj, msg ) {
	var regex = new RegExp(/^((((1[6-9]|[2-9]\d)\d{2})-(0[13578]|1[02])-(0[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0[13456789]|1[012])-(0[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-02-(0[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-02-29))$/);
	return checkRegexp( jObj, regex, msg );
}

function checkDateTime( jObj, msg ) {
	var regex = new RegExp(/^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$/);
	return checkRegexp( jObj, regex, msg );
}

function checkInteger( jObj, msg ) {
	var regex = new RegExp(/^-?[1-9]\d*$/);
	return checkRegexp( jObj, regex, msg );
}

function checkNumber( jObj, msg ) {
	var regex = new RegExp(/^-?[0-9]*(\.[0-9]*)?$/);
	return checkRegexp( jObj, regex, msg );
}
	
function IsDateTime(text) {
	var regex = new RegExp(/^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$/);
	return regex.test(text);
}

function checkId(jObj,msg){
	if (jObj.val().length > 0) {
		if (jObj.val().match(/[^0-9A-Za-z]+/)) {
			AddTip(jObj, msg, "idmsg", true);
			return false;
		} else {
			delTip(jObj, "idmsg", true);
			return true;
		}
	} else {
		delTip(jObj, "idmsg", true);
		return true;
	}
}

function CompareFromToDate(jObjFromDate,jObjToDate){
	var strDt1 = jObjFromDate.val() + " " + "00:00:00";
	var strDt2 = jObjToDate.val() + " " + "00:00:00";
	if( strDt1 === strDt2 )
		return 0;
	strDt1 = strDt1.replace(/-/g,"/");
	strDt2 = strDt2.replace(/-/g,"/");
	var dt1 = new Date(Date.parse(strDt1));
	var dt2 = new Date(Date.parse(strDt2));
	if(dt1>dt2)
		return 1
	return -1;
}
