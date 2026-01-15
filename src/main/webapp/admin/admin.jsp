<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Books - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* Reusing global styles for consistency */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); height: 100vh; display: flex; }

        /* SIDEBAR (Copy of Dashboard Sidebar) */
        .sidebar { width: 280px; background: white; padding: 30px; display: flex; flex-direction: column; box-shadow: 5px 0 30px rgba(0,0,0,0.05); }
        .brand { font-size: 24px; font-weight: 800; color: #2d3436; margin-bottom: 50px; }
        .brand span { color: #6c5ce7; }
        .menu-item { display: flex; align-items: center; padding: 15px 20px; color: #b2bec3; text-decoration: none; font-weight: 600; border-radius: 15px; margin-bottom: 10px; transition: 0.3s; }
        .menu-item:hover { background: #f5f6fa; color: #6c5ce7; }
        .menu-item.active { background: #6c5ce7; color: white; box-shadow: 0 10px 20px rgba(108, 92, 231, 0.3); }
        .menu-icon { margin-right: 15px; font-size: 18px; }

        /* CONTENT */
        .main-content { flex: 1; padding: 50px; overflow-y: auto; }
        .header-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h1 { font-size: 28px; font-weight: 800; color: #2d3436; }

        /* BUTTONS */
        .btn-add { background: #6c5ce7; color: white; padding: 12px 25px; border-radius: 50px; text-decoration: none; font-weight: 700; box-shadow: 0 5px 15px rgba(108, 92, 231, 0.3); transition: 0.2s; }
        .btn-add:hover { transform: translateY(-2px); }

        /* MODERN TABLE */
        .table-container { background: white; padding: 10px; border-radius: 30px; box-shadow: 0 20px 60px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 20px; color: #b2bec3; font-size: 12px; text-transform: uppercase; font-weight: 700; border-bottom: 1px solid #f5f6fa; }
        td { padding: 20px; color: #2d3436; font-size: 14px; font-weight: 600; border-bottom: 1px solid #f5f6fa; }
        tr:last-child td { border-bottom: none; }

        /* STATUS BADGES */
        .badge { padding: 8px 15px; border-radius: 50px; font-size: 12px; font-weight: 700; }
        .badge-available { background: #e0f7fa; color: #00cec9; }
        .badge-borrowed { background: #fab1a0; color: #d63031; }

        .btn-delete { color: #d63031; text-decoration: none; font-size: 12px; padding: 5px 10px; background: #fff0f0; border-radius: 10px; }
        .btn-delete:hover { background: #d63031; color: white; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="brand">⚡ Up<span>Books</span></div>
        <a href="admin/dashboard.jsp" class="menu-item"><span class="menu-icon">📊</span> Dashboard</a>
        <a href="#" class="menu-item active"><span class="menu-icon">📚</span> Manage Books</a>
        <a href="manage-rooms" class="menu-item"><span class="menu-icon">🏢</span> Study Rooms</a>
    </div>

    <div class="main-content">
        <div class="header-row">
            <h1>Book Inventory</h1>
            <a href="admin/add_book.jsp" class="btn-add">+ Add Book</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Book> books = (List<Book>) request.getAttribute("bookList");
                        if (books != null) {
                            for (Book b : books) {
                    %>
                    <tr>
                        <td>#<%= b.getId() %></td>
                        <td><%= b.getTitle() %></td>
                        <td><%= b.getAuthor() %></td>
                        <td><%= b.getCategory() %></td>
                        <td>
                            <% if("Available".equals(b.getStatus())) { %>
                                <span class="badge badge-available">Available</span>
                            <% } else { %>
                                <span class="badge badge-borrowed">Out</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="delete-book?id=<%= b.getId() %>" class="btn-delete">Delete</a>
                        </td>
                    </tr>
                    <%      }
                        } else { %>
                    <tr><td colspan="6" style="text-align:center; padding: 40px; color: #b2bec3;">No books found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>