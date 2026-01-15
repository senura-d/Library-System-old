<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Member Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 20px; }
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #764ba2;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
            transition: 0.3s;
        }
        button:hover { background-color: #5a367f; }
        .footer { margin-top: 15px; font-size: 14px; }
        a { color: #764ba2; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <h2>Member Login</h2>

    <%-- Show error message if login failed --%>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red; font-size: 14px;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="login" method="post">
        <input type="email" name="email" required placeholder="Email Address">
        <input type="password" name="password" required placeholder="Password">
        <button type="submit">Sign In</button>
    </form>

    <div class="footer">
        New here? <a href="register.jsp">Create an Account</a>
    </div>
</div>

</body>
</html>