<%@ page import="java.sql.*" %>
<html>
<head><title>Digital Library</title></head>
<body>

<h2>My Digital Books</h2>

<table border="1">
<tr><th>Title</th><th>Action</th></tr>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM books WHERE is_digital=TRUE");

while(rs.next()) {
%>
<tr>
<td><%= rs.getString("title") %></td>
<td>
    <a href="read-book?id=<%= rs.getInt("book_id") %>">Read</a>
</td>
</tr>
<% } con.close(); %>

</table>

</body>
</html>
