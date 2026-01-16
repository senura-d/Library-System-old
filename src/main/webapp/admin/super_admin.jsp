<%@ page import="java.sql.*" %>
<%@ page import="com.library.dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Super Admin Control</title>
    <style>
        body { font-family: sans-serif; padding: 30px; background-color: #1e1e1e; color: white; }
        table { width: 100%; border-collapse: collapse; background: #2d2d2d; margin-top: 20px; }
        th, td { padding: 10px; border-bottom: 1px solid #444; text-align: left; color: #ddd; }
        th { background-color: #e74c3c; color: white; }
        .btn { padding: 5px 10px; text-decoration: none; color: white; border-radius: 4px; font-size: 12px; }
        .approve { background-color: #27ae60; }
        .delete { background-color: #c0392b; }
        .back { display: inline-block; margin-bottom: 20px; color: #aaa; font-weight: bold; text-decoration: none; }
    </style>
</head>
<body>

    <a href="dashboard.jsp" class="back">← Back to Dashboard</a>
    <h2>Manage Admins (Super Admin Only)</h2>

    <%
        // SECURITY CHECK
        String role = (String) session.getAttribute("adminRole");
        if (role == null || !role.equals("SUPER_ADMIN")) {
            response.sendRedirect("dashboard.jsp");
            return;
        }
    %>

    <table>
        <tr>
            <th>Username</th>
            <th>Status</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Connection con = DBConnection.getConnection();
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM admins WHERE role != 'SUPER_ADMIN'");

                while(rs.next()) {
                    String id = rs.getString("id");
                    String user = rs.getString("username");
                    String status = rs.getString("status");
                    String userRole = rs.getString("role");
        %>
        <tr>
            <td><%= user %></td>
            <td><%= status %></td>
            <td><%= userRole %></td>
            <td>
                <% if("PENDING".equals(status)) { %>
                    <a href="manage-admin?action=approve&id=<%= id %>" class="btn approve">Approve</a>
                <% } %>
                <a href="manage-admin?action=delete&id=<%= id %>" class="btn delete">Remove</a>
            </td>
        </tr>
        <%
                }
                con.close();
            } catch(Exception e) { e.printStackTrace(); }
        %>
    </table>

</body>
</html>