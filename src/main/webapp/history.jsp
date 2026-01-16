<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%
    // Redirect if accessing directly without Servlet
    if (request.getAttribute("historyList") == null) {
        response.sendRedirect("history");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My History</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #1e1e1e; color: white; font-family: 'Poppins', sans-serif; padding: 40px; }
        .container { max-width: 900px; margin: 0 auto; }
        h1 { border-bottom: 2px solid #667eea; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; background: #2d2d2d; margin-top: 20px; }
        th, td { padding: 15px; border-bottom: 1px solid #444; text-align: left; }
        .badge { padding: 5px 10px; border-radius: 10px; font-size: 11px; font-weight: bold; }
        .Borrowed { background: #f39c12; color: white; }
        .Returned { background: #2ecc71; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📜 My Activity History</h1>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Item Details</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, String>> history = (List<Map<String, String>>) request.getAttribute("historyList");
                    if (history != null) {
                        for (Map<String, String> item : history) {
                %>
                <tr>
                    <td><%= item.get("date") %></td>
                    <td><%= item.get("type") %></td>
                    <td><%= item.get("item") %></td>
                    <td><span class="badge <%= item.get("status") %>"><%= item.get("status") %></span></td>
                </tr>
                <%      }
                    } %>
            </tbody>
        </table>
        <br>
        <a href="member-dashboard" style="color: #aaa;">← Back to Dashboard</a>
    </div>
</body>
</html>