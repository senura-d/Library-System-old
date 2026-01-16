<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("memberEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Profile - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #4D4D4D; color: white; font-family: 'Poppins', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }

        .profile-card {
            background: #383838;
            padding: 40px;
            border-radius: 20px;
            width: 450px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border-top: 5px solid #4A90E2;
        }

        .avatar { width: 100px; height: 100px; background: #4A90E2; border-radius: 50%; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 40px; font-weight: bold; color: white; }
        h2 { margin-bottom: 5px; font-size: 24px; }
        p { color: #95a5a6; margin-bottom: 30px; font-size: 14px; }

        .info-group { text-align: left; background: #2d2d2d; padding: 15px; border-radius: 10px; margin-bottom: 10px; border: 1px solid #444; }
        .label { font-size: 11px; text-transform: uppercase; color: #aaa; display: block; margin-bottom: 5px; }
        .value { font-size: 15px; font-weight: 600; color: white; }

        /* QR SECTION */
        .qr-section { margin-top: 20px; padding-top: 20px; border-top: 1px solid #444; }
        .qr-img { background: white; padding: 10px; border-radius: 10px; margin-top: 10px; }

        .btn-back { display: inline-block; margin-top: 25px; color: #4A90E2; text-decoration: none; font-size: 14px; font-weight: 600; }
        .btn-back:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="profile-card">
        <div class="avatar">
            <%= session.getAttribute("memberName") != null ? session.getAttribute("memberName").toString().substring(0,1) : "U" %>
        </div>

        <h2><%= session.getAttribute("memberName") %></h2>
        <p>Student Member</p>

        <div class="info-group">
            <span class="label">Email</span>
            <div class="value"><%= session.getAttribute("memberEmail") %></div>
        </div>

        <div class="info-group">
            <span class="label">Member ID</span>
            <div class="value"><%= session.getAttribute("memberId") %></div>
        </div>

        <div class="qr-section">
            <span class="label">Digital Member Card</span>
            <img src="QRServlet?text=<%= session.getAttribute("memberId") %>" class="qr-img" width="120" height="120" alt="QR Code">
        </div>

        <a href="member-dashboard.jsp" class="btn-back">← Back to Dashboard</a>
    </div>

</body>
</html>