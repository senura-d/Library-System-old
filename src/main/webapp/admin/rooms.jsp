<%@ page import="com.library.model.Room" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Study Rooms - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); height: 100vh; display: flex; }

        .sidebar { width: 280px; background: white; padding: 30px; display: flex; flex-direction: column; box-shadow: 5px 0 30px rgba(0,0,0,0.05); }
        .brand { font-size: 24px; font-weight: 800; color: #2d3436; margin-bottom: 50px; }
        .brand span { color: #6c5ce7; }
        .menu-item { display: flex; align-items: center; padding: 15px 20px; color: #b2bec3; text-decoration: none; font-weight: 600; border-radius: 15px; margin-bottom: 10px; transition: 0.3s; }
        .menu-item:hover { background: #f5f6fa; color: #6c5ce7; }
        .menu-item.active { background: #6c5ce7; color: white; box-shadow: 0 10px 20px rgba(108, 92, 231, 0.3); }
        .menu-icon { margin-right: 15px; font-size: 18px; }

        .main-content { flex: 1; padding: 50px; overflow-y: auto; }
        h1 { font-size: 28px; font-weight: 800; color: #2d3436; margin-bottom: 30px; }

        .table-container { background: white; padding: 10px; border-radius: 30px; box-shadow: 0 20px 60px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 20px; color: #b2bec3; font-size: 12px; text-transform: uppercase; font-weight: 700; border-bottom: 1px solid #f5f6fa; }
        td { padding: 20px; color: #2d3436; font-size: 14px; font-weight: 600; border-bottom: 1px solid #f5f6fa; }

        /* CUSTOM BADGES FOR ROOMS */
        .badge { padding: 8px 15px; border-radius: 50px; font-size: 12px; font-weight: 700; }
        .badge-open { background: #e0f7fa; color: #00cec9; }
        .badge-full { background: #fab1a0; color: #d63031; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="brand">⚡ Up<span>Books</span></div>
        <a href="admin/dashboard.jsp" class="menu-item"><span class="menu-icon">📊</span> Dashboard</a>
        <a href="dashboard" class="menu-item"><span class="menu-icon">📚</span> Manage Books</a>
        <a href="#" class="menu-item active"><span class="menu-icon">🏢</span> Study Rooms</a>
    </div>

    <div class="main-content">
        <h1>Study Rooms</h1>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Room Name</th>
                        <th>Capacity</th>
                        <th>Current Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Room> rooms = (List<Room>) request.getAttribute("roomList");
                        if (rooms != null) {
                            for (Room r : rooms) {
                    %>
                    <tr>
                        <td><%= r.getName() %></td>
                        <td><%= r.getCapacity() %> Students</td>
                        <td>
                            <% if("Available".equalsIgnoreCase(r.getStatus())) { %>
                                <span class="badge badge-open">Open</span>
                            <% } else { %>
                                <span class="badge badge-full">Occupied</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>