<%@ page import="com.library.model.DigitalBook" %>
<%
DigitalBook book = (DigitalBook) request.getAttribute("book");
%>

<h2><%= book.getTitle() %></h2>

<iframe
    src="pdf-viewer?file=<%= book.getFilePath() %>"
    width="100%"
    height="600">
</iframe>
