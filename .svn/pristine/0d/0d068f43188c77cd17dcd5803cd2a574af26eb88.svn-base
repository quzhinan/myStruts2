<%@ taglib prefix="s" uri="/struts-tags"%>

<s:text name="labels.pager.recordCount"/>
<s:if test="pagination.totalCount==0">
0
</s:if>
<s:else>
<s:property value="pagination.offset+1"/>
<s:text name="labels.pager.separator.to"/>
<s:property value="pagination.offset+pagination.itemsCount"/>
</s:else>
<s:text name="labels.pager.separator.total"/>
<s:property value="pagination.totalCount"/>