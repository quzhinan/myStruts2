<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title><s:text name="labels.header.title" /></title>
<s:head />
<style type="text/css">
.inputbox {
	width: 200px;
	height: 20px;
}
</style>

<script type="text/javascript">
function clearForm(){
	document.getElementById("usercode").value="";
	document.getElementById("password").value="";
}
</script>
</head>
<body>
	<table border="0" cellspacing="0" cellpadding="0">
		<tr style="background-color: #EFEFEF;">
			<td valign="top">
				<table class="login-description" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td class="bg-image"><img
							src="<s:url value='/images/description.png'/>"
							class="action-icon" style="width:580px; height:398px"/></td>
					</tr>
				</table>
			</td>
			
			<td valign="top"><s:form action="login" id="login-form"
					name="login-form">
					<table class="login-box" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td nowrap="nowrap" align="left" class="login-line1">&nbsp;

							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" align="left" class="login-line2">&nbsp;

							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" align="left"
								style="padding: 0px; width: 180px; word-break: break-all;">
								<br /> <font color="red"> <s:actionerror /> <s:fielderror />
							</font>
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" align="left"
								style="padding-top: 0px; padding-bottom: 0px;">&nbsp;</td>
						</tr>
						<tr>
							<td align="left"><s:label key="labels.login.usercode" /> <br />
								<s:textfield name="usercode" id="usercode" maxlength="10"
									cssClass="inputbox disable-ime" style="width:170px;" /></td>
						</tr>
						<tr>
							<td align="left"><s:label key="labels.login.password" /> <br />
								<s:password name="password" id="password" maxlength="30"
									cssClass="inputbox" style="width:170px;" /></td>
						</tr>
						<tr>
							<td align="right" style="padding-top: 20px;"><br /> <s:submit
									key="labels.button.login" name="login" id="login"
									cssClass="button3-action" style="width:80px;font-size:14px;" />
								<input type="button" value="<s:text name ='labels.button.clear'/>" name="clear"
									Class="button-cancel" style="width:80px;font-size:14px;" onclick="clearForm();"/>
							</td>
						</tr>
						<tr>
							<td height="100%" align="right">&nbsp;</td>
						</tr>
					</table>
				</s:form></td>
		</tr>
	</table>


</body>
</html>
