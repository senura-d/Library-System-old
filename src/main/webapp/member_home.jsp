<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Profile</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 50px; background-color: #f4f4f4; }
        .card { background: white; padding: 30px; border-radius: 10px; display: inline-block; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        h1 { color: #764ba2; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Welcome, <%= session.getAttribute("userName") %>!</h1>
        <p>You are logged in as a Member.</p>
        <p>Your Email: <%= session.getAttribute("userEmail") %></p>
        <br>
        <a href="logout" style="color: red; font-weight: bold;">Log Out</a>
    </div>
</body>
</html>