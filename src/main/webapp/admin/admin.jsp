<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Books - Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* --- COPYING YOUR DASHBOARD STYLES SO IT LOOKS UNIFORM --- */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
        body { background-color: #1e1e1e; color: #ecf0f1; display: flex; height: 100vh; overflow: hidden; }

        /* Sidebar */
        .sidebar { width: 260px; background-color: #252525; display: flex; flex-direction: column; padding: 30px; border-right: 1px solid #333; }
        .brand { font-size: 20px; font-weight: 700; color: #ffffff; margin-bottom: 50px; }
        .brand span { color: #e74c3c; }

        .menu-item { text-decoration: none; color: #95a5a6; padding: 15px; margin-bottom: 8px; border-radius: 8px; font-size: 14px; font-weight: 600; display: flex; align-items: center; transition: all 0.3s; }
        .menu-item:hover { background: rgba(231, 76, 60, 0.1); color: #e74c3c; }
        .menu-item.active { background-color: #e74c3c; color: white; box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3); }
        .menu-icon { margin-right: 15px; width: 20px; text-align: center; }
        .logout-btn { margin-top: auto; color: #e74c3c; border: 1px solid #e74c3c; text-align: center; padding: 12px; border-radius: 8px; transition: 0.3s; }
        .logout-btn:hover { background: #e74c3c; color: white; }

        /* Main Content */
        .main-content { flex: 1; padding: 40px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h1 { font-size: 28px; font-weight: 700; }

        /* Table Design */
        .table-container { background-color: #2d2d2d; padding: 20px; border-radius: 12px; box-shadow: 0 10px 20px rgba(0,0,0,0.2); }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { text-align: left; padding: 15px; color: #95a5a6; border-bottom: 1px solid #444; font-size: 14px; }
        td { padding: 15px; border-bottom: 1px solid #333; color: white; font-size: 14px; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #383838; }

        .status-badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .status-available { background-color: rgba(46, 204, 113, 0.2); color: #2ecc71; }
        .status-issued { background-color: rgba(231, 76, 60, 0.2); color: #e74c3c; }

        .add-btn { background-color: #e74c3c; color: white; padding: 10px 20px; text-decoration: none; border-radius: 6px; font-weight: 600; }
        .add-btn:hover { background-color: #c0392b; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="brand">🛡️ Admin<span>Panel</span></div>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
            <span class="menu-icon">📊</span> Overview
        </a>

        <a href="${pageContext.request.contextPath}/manage-books" class="menu-item active">
            <span class="menu-icon">📚</span> Manage Books
        </a>

        <a href="${pageContext.request.contextPath}/manage-rooms" class="menu-item">
            <span class="menu-icon">🏢</span> Rooms
        </a>

        <a href="${pageContext.request.contextPath}/logout" class="menu-item logout-btn">Log Out</a>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Manage Books</h1>
            <a href="${pageContext.request.contextPath}/admin/add_book.jsp" class="add-btn">+ Add New Book</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Book> books = (List<Book>) request.getAttribute("bookList");
                        if (books != null && !books.isEmpty()) {
                            for (Book b : books) {
                    %>
                    <tr>
                        <td>#<%= b.getId() %></td>
                        <td><%= b.getTitle() %></td>
                        <td><%= b.getAuthor() %></td>
                        <td><%= b.getCategory() %></td>
                        <td>
                            <span class="status-badge <%= "Available".equalsIgnoreCase(b.getStatus()) ? "status-available" : "status-issued" %>">
                                <%= b.getStatus() %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #7f8c8d; padding: 30px;">
                            No books found in the database.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>