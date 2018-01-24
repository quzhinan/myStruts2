<%@ attribute name="url" required="true" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>  

<%!
String changeUrl(String url) {
    int index = url.indexOf('?');
    String head = url.substring(0, index + 1);
    String tail = url.substring(index + 1);
    tail = tail.replace('?', '&');
    String newPageUrl = head + tail;
    return newPageUrl;
}

String returnMark(String url) {
    int index = url.indexOf('?');
   	if(index != -1) {
   		return "&";
   	} else {
   		return "?";
   	}
}
%>
<%
jp.iesolutions.ienursing.util.PaginationSupport pagination =
	(jp.iesolutions.ienursing.util.PaginationSupport)request.getAttribute("pagination");
int current_page_number = pagination.getCurrentPageNumber();
int last_page_number = pagination.getMaxPageNumber();
int page_size = pagination.getPageSize();
%>
<pg:pager items="${pagination.totalCount}" url="${url}"
		export="pageOffset,currentPageNumber=pageNumber" 
		maxPageItems="${pagination.pageSize}" maxIndexPages="10">
	<pg:index>
    <font face=Helvetica size=-1><s:text name="labels.pager.result"/>
<%
if(current_page_number != 1) {
	int prev_page_number_offset = (current_page_number-2)*page_size;
	if( prev_page_number_offset < 0 )
		prev_page_number_offset = 0;
%>
    <pg:first>&nbsp;<a href="<%= changeUrl(pageUrl) %>"><s:text name="labels.pager.first"/></a></pg:first>
    <a href="${url}<%=returnMark(url)%>pager.offset=<%=prev_page_number_offset%>"><s:text name="labels.pager.previous"/></a>
<%
}
%>
    <pg:pages><%
      if (pageNumber.intValue() < 10) { 
        %>&nbsp;<%
      }
      //if (pageNumber == currentPageNumber) { 
      if (pageNumber == current_page_number) { 
        %><b><%= pageNumber %></b><%
      } else { 
        %><a href="<%= changeUrl(pageUrl)  %>"><%= pageNumber %></a><%
      }
    %>
    </pg:pages>
<%
if(current_page_number != last_page_number) {
	int next_page_number_offset = current_page_number*page_size;
%>
    <a href="${url}<%=returnMark(url)%>pager.offset=<%=next_page_number_offset%>"><s:text name="labels.pager.next"/></a>
    <pg:last>&nbsp;<a href="<%= changeUrl(pageUrl)  %>"><s:text name="labels.pager.last"/></a></pg:last>
<%
}
%>
    <br></font>
 	 </pg:index>
</pg:pager>