<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("memberEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #1e1e1e; color: white; font-family: 'Poppins', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .profile-card { background: #2d2d2d; padding: 40px; border-radius: 15px; width: 400px; text-align: center; border-top: 5px solid #667eea; }
        .avatar { width: 80px; height: 80px; background: #667eea; border-radius: 50%; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 30px; font-weight: bold; }
        h2 { margin-bottom: 5px; }
        p { color: #95a5a6; margin-bottom: 30px; }
        .info-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #444; font-size: 14px; }
        .label { color: #95a5a6; }
        .btn-back { display: inline-block; margin-top: 25px; color: white; text-decoration: none; background: #444; padding: 10px 20px; border-radius: 20px; transition: 0.3s; }
        .btn-back:hover { background: #667eea; }
    </style>
</head>
<body>
    <div class="profile-card">
        <div class="avatar"><%= session.getAttribute("memberName").toString().substring(0,1) %></div>
        <h2><%= session.getAttribute("memberName") %></h2>
        <p>Student Member</p>

        <div class="info-row">
            <span class="label">Member ID</span>
            <span><%= session.getAttribute("memberId") %></span>
        </div>
        <div class="info-row">
            <span class="label">Email</span>
            <span><%= session.getAttribute("memberEmail") %></span>
        </div>
        <div class="info-row">
            <span class="label">Status</span>
            <span style="color: #2ecc71;">Active ●</span>
        </div>

        <a href="member-dashboard" class="btn-back">Back to Dashboard</a>
    </div>
</body>
</html>