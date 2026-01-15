<%@ page import="com.library.model.Member" %>
<%@ page import="com.library.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: sans-serif; padding: 30px; background-color: #f4f4f4; }
        h2 { color: #333; border-bottom: 2px solid #6c5ce7; padding-bottom: 10px; display: inline-block; }

        /* Table Styles */
        table { width: 100%; border-collapse: collapse; background: white; margin-bottom: 40px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #6c5ce7; color: white; }
        tr:hover { background-color: #f1f1f1; }

        /* Button Styles */
        .btn-logout { background-color: #c0392b; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; float: right; }
        .btn-super { background-color: #d35400; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold; margin-right: 10px; }
        .btn-add { background-color: #27ae60; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-weight: bold; }

        .action-bar { text-align: center; margin: 20px 0; }
    </style>
</head>
<body>

    <a href="logout" class="btn-logout">Log Out</a>

    <h1>Admin Dashboard</h1>

    <div class="action-bar">
        <%-- Only show Orange Button if user is SUPER_ADMIN --%>
        <%
            String role = (String) session.getAttribute("adminRole");
            if (role != null && role.equals("SUPER_ADMIN")) {
        %>
            <a href="admin/super_admin.jsp" class="btn-super">★ Manage Admins</a>
        <% } %>

        <a href="admin/add_book.jsp" class="btn-add">+ Add New Book</a>
    </div>

    <h2>Registered Members</h2>
    <table>
        <tr>
            <th>Member ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        <%
            List<Member> members = (List<Member>) request.getAttribute("membersList");
            if (members != null) {
                for (Member m : members) {
        %>
        <tr>
            <td><%= m.getMemberId() %></td>
            <td><%= m.getFullName() %></td>
            <td><%= m.getEmail() %></td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <h2>Library Inventory</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            // This is the variable that was duplicated before. Now it's only here once.
            List<Book> books = (List<Book>) request.getAttribute("booksList");
            if (books != null) {
                for (Book b : books) {
        %>
        <tr>
            <td><%= b.getId() %></td>
            <td><%= b.getTitle() %></td>
            <td><%= b.getAuthor() %></td>
            <td><%= b.getCategory() %></td>
            <td>
            <% if(b.isAvailable()) { %>
                <span style="color: green; font-weight: bold;">Available</span>
            <% } else { %>
                <span style="color: red; font-weight: bold;">Borrowed</span>
            <% } %>
            </td>
                    <span style="color: green; font-weight: bold;">Available</span>
                <% } else { %>
                    <span style="color: red; font-weight: bold;">Borrowed</span>
                <% } %>
            </td>
            <td>
                <a href="delete-book?id=<%= b.getId() %>"
                   style="color: white; background: #c0392b; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 12px;"
                   onclick="return confirm('Are you sure you want to delete this book?');">
                   Delete
                </a>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>

</body>
</html>