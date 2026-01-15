<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Super Admin Control</title>
    <style>
        body { font-family: sans-serif; padding: 30px; background-color: #f4f4f4; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #333; color: white; }
        .btn { padding: 5px 10px; text-decoration: none; color: white; border-radius: 4px; font-size: 12px; }
        .approve { background-color: #27ae60; }
        .delete { background-color: #c0392b; }
        .back { display: inline-block; margin-bottom: 20px; color: #333; font-weight: bold; text-decoration: none; }
    </style>
</head>
<body>

    <a href="../dashboard" class="back">← Back to Dashboard</a>
    <h2>Manage Admins (Super Admin Only)</h2>

    <%
        // SECURITY CHECK: Kick them out if they are not SUPER_ADMIN
        String role = (String) session.getAttribute("adminRole");
        if (role == null || !role.equals("SUPER_ADMIN")) {
            response.sendRedirect("../dashboard"); // Send them back to safety
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
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Using your password "Askme458"
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db", "root", "Askme458");
                Statement stmt = con.createStatement();
                // Show everyone EXCEPT yourself (Super Admin)
                ResultSet rs = stmt.executeQuery("SELECT * FROM admins WHERE role != 'SUPER_ADMIN'");

                while(rs.next()) {
                    String id = rs.getString("id");
                    String user = rs.getString("username");
                    String status = rs.getString("status");
                    String userRole = rs.getString("role");
        %>
        <tr>
            <td><%= user %></td>
            <td>
                <% if(status.equals("PENDING")) { %>
                    <span style="color: orange; font-weight: bold;">PENDING</span>
                <% } else { %>
                    <span style="color: green; font-weight: bold;">ACTIVE</span>
                <% } %>
            </td>
            <td><%= userRole %></td>
            <td>
                <% if(status.equals("PENDING")) { %>
                    <a href="../manage-admin?action=approve&id=<%= id %>" class="btn approve">Approve</a>
                <% } %>
                <a href="../manage-admin?action=delete&id=<%= id %>" class="btn delete">Remove Access</a>
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