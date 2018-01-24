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
<s:head />
</head>
<body>
	<div class="home-menu">
		<s:if test="canDoAction('plan')">
			<s:url id="url" action="plan" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrPlan"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_plan.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.plan.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_plan.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.plan.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('shift')">
			<s:url id="url" action="shift" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrShift"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_shift.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.shift.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_shift.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.shift.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('schedule')">
			<s:url id="url" action="schedule" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrSchedule"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_schedule.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.schedule.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_schedule.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.schedule.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('nursing')">
			<s:url id="url" action="nursing-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrAchievement"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_achievement.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.achievement.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_achievement.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.achievement.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('week')">
			<s:url id="url" action="week-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrWeek"/>
				<s:param name="clear" value="true"/>
				<s:param name="tab" value="1"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_week.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.week.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_week.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.week.short" /></div>
			</div>
		</s:else>
		<!--  Modify for Comment - start -->
		<s:if test="canDoAction('comment')">
			<s:url id="url" action="comment-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMgrComment"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_comment.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.comment.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_comment.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.manager.comment.short" /></div>
			</div>
		</s:else>
		<!--  Modify for Comment - end -->
	</div>
	<div class="home-menu">
		<s:if test="canDoAction('customer')">
			<s:url id="url" action="customer-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMstCustomer"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_customer.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.customer.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_customer.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.customer.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('user')">
			<s:url id="url" action="user-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMstUser"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_user.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.user.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_user.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.user.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('office')">
			<s:url id="url" action="office-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMstOffice"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_office.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.office.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_office.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.office.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('master')">
			<s:url id="url" action="master" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMstMaster"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_master.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.master.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_master.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.master.short" /></div>
			</div>
		</s:else>
		<s:if test="canDoAction('service')">
			<s:url id="url" action="service-list" includeParams="none" namespace="/" >
				<s:param name="menuid" value="menuIdMstService"/>
				<s:param name="clear" value="true"/>
			</s:url>
			<div onclick="window.location=iesAddToken('${url}')">
				<div><img src="<s:url value='/images/icon_page_menu_service.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.service.short" /></div>
			</div>
		</s:if>
		<s:else>
			<div class="disabled">
				<div><img src="<s:url value='/images/icon_page_menu_service.png'/>" border="0"/></div>
				<div><s:text name="labels.menu.master.service.short" /></div>
			</div>
		</s:else>
		<!--  Modify for Comment - start -->
		<div class="disabled"></div>
		<!--  Modify for Comment - end -->
	</div>
	<s:url id="url" action="uploadcsv" includeParams="none" namespace="/" >
				
			</s:url>
	
</body>
</html>
