<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<script language="JavaScript">
	function splitAddress(address) {
		var array = address.split('\\');
		return array[array.length - 1];
	}
	function uploadFileChange(id) {

		j$("#csvName" + id).val(splitAddress(j$("#csvPath" + id).val()));
	}
	document.onreadystatechange = statechange;
	function statechange() {
		if (document.readyState == "complete") {
		}
	}
	function ShowLoad(text) {
		var w = document.documentElement ? (document.documentElement.scrollWidth || 0)
				: (document.body.scrollWidth || 0);
		var h = document.documentElement ? (document.documentElement.scrollHeight || 0)
				: (document.body.scrollHeight || 0);
		var o = document.getElementById("overlay");
		o.style.width = parseInt(w) + 'px';
		o.style.height = parseInt(h) + 'px';
		o.style.background = '#bfbfbf';
		o.style.left = 0;
		o.style.top = 0;
		o.style.filter = 'Alpha(Opacity=45)';
		o.style.MozOpacity = '0.45';
		o.style.opacity = '0.45';
		o.style.display = 'block';
		o.style.position = 'absolute';
		o.style.zIndex = 101;

		var load = document.getElementById("div_load");
		var h1 = document.documentElement ? (document.documentElement.scrollTop || 0)
				: (document.body.scrollTop || 0);
		h1 = Math.max(h1, (window.scrollY || 0));
		var h2 = document.documentElement ? (document.documentElement.clientHeight || 0)
				: (document.body.clientHeight || 0);
		load.innerHTML = text;
		load.style.zIndex = 102;
		load.style.position = 'absolute';
		load.style.display = 'block';
		var h3 = load.clientHeight;
		var w2 = load.clientWidth;
		load.style.left = parseInt((w - w2) / 2) + 'px';
		load.style.top = '100px';
	}
</script>

<s:head />
<style>
div.fakefileinputs {
	position: relative;
}

div.abovefakefile {
	position: absolute;
	top: 0px;
	left: 0px;
}

input.truefileforupload {
	position: relative;
	text-align: right;
	-moz-opacity: 0;
	filter: alpha(opacity :                               0);
	opacity: 0;
	z-index: 2;
	width: 70px;
	margin-left: 375px;
	height: 30px;
	/*ie8*/
	width: 50px\0;
	margin-left: 405px\0;
	height: 25px\0;
	/*ie7*/ +
	width: 20px; +
	margin-left: 400px; +
	height: 27px;
	/*ie6*/
	_width: 20px;
	_height: 20px;
	_margin-left: 400px;
}
</style>

</head>
<body>
	<table width="100%" class="edit-box" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td class="edit-header"><s:text name="labels.button.upload.csv" /></td>
		</tr>
		<tr>
			<td class="edit-error"><s:actionerror /> <s:fielderror /></td>
		</tr>
		<tr>
			<td class="edit-data"><s:form action="data-import!upload"
					name="shainForm" id="shainForm" enctype="multipart/form-data"
					onsubmit="ShowLoad('ロード...');">
					<table width="100%" class="edit-data-box" border="0"
						cellpadding="5" cellspacing="3">
						<tr>
							<td colspan="2"><ul id="validateTips"></ul></td>
						</tr>
						<tr>
							<td align="right"><s:text name="labels.button.upload.user" />
								<s:text name="labels.separator.label" /></td>
							<td>
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='csvPaths' id='csvPath1' onChange='uploadFileChange(1)' />
									<div class='abovefakefile'>
										<input type='text' maxlength="200" name='csvNames' readonly
											id='csvName1' style='z-index: 3; width: 390px;' /> <input
											type='button' value='<s:text name='labels.button.refer'/>'
											id='btnTriger' /> <span style='color: red; font-size: 14px;'>*</span><span
											style="padding-left: 7px;"></span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td align="right"><s:text
									name="labels.button.upload.customer" /> <s:text
									name="labels.separator.label" /></td>
							<td>
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='csvPaths' id='csvPath2' onChange='uploadFileChange(2)' />
									<div class='abovefakefile'>
										<input type='text' maxlength="200" name='csvNames' readonly
											id='csvName2' style='z-index: 3; width: 390px;' /> <input
											type='button' value='<s:text name='labels.button.refer'/>'
											id='btnTriger' /> <span style='color: red; font-size: 14px;'>*</span><span
											style="padding-left: 7px;"></span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td align="right"><s:text name="labels.button.upload.office" />
								<s:text name="labels.separator.label" /></td>
							<td>
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='csvPaths' id='csvPath3' onChange='uploadFileChange(3)' />
									<div class='abovefakefile'>
										<input type='text' maxlength="200" name='csvNames' readonly
											id='csvName3' style='z-index: 3; width: 390px;' /> <input
											type='button' value='<s:text name='labels.button.refer'/>'
											id='btnTriger' /> <span style='color: red; font-size: 14px;'>*</span><span
											style="padding-left: 7px;"></span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td align="right"><s:text
									name="labels.button.upload.nursing" /> <s:text
									name="labels.separator.label" /></td>
							<td>
								<div class='fakefileinputs'>
									<input type='file' class='truefileforupload' size=1
										name='csvPaths' id='csvPath4' onChange='uploadFileChange(4)' />
									<div class='abovefakefile'>
										<input type='text' maxlength="200" name='csvNames' readonly
											id='csvName4' style='z-index: 3; width: 390px;' /> <input
											type='button' value='<s:text name='labels.button.refer'/>'
											id='btnTriger' /> <span style='color: red; font-size: 14px;'>*</span><span
											style="padding-left: 7px;"></span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding-left: 600px;"><s:submit
									key="labels.button.update" cssClass="button2-action"
									name="update" id="update" /></td>
						</tr>
					</table>
				</s:form></td>
		</tr>
	</table>
	<div class="blackLine">
<table class="menuTable" border="0"><tr>
<td></td>
<td></td>
<td><s:url id="urlCalendar" action="nursing-calendar.ies" namespace="/" /><s:a href="%{urlCalendar}"><s:text name="labels.nursing.back"/></s:a></td>
</tr></table>
</div>
</body>
</html>
