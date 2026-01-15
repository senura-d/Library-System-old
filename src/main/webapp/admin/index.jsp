<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Portal</title>
    <style>
        body { background-color: #222; color: white; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background-color: #333; padding: 40px; border-radius: 8px; text-align: center; width: 300px; border: 1px solid #444; }
        input { width: 100%; padding: 10px; margin: 10px 0; background: #444; border: 1px solid #555; color: white; }
        button { width: 100%; padding: 10px; background: #e74c3c; color: white; border: none; font-weight: bold; cursor: pointer; }
        button:hover { background: #c0392b; }
        a { color: #aaa; font-size: 12px; }

        /* This makes the error text red */
        .error { color: #e74c3c; margin-bottom: 10px; font-size: 13px; }
        /* This makes the success text green */
        .success { color: #2ecc71; margin-bottom: 10px; font-size: 13px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Access</h2>

        <%-- Show messages if login fails or registration succeeds --%>
        <% if(request.getParameter("error") != null) { %>
            <p class="<%= request.getParameter("error").contains("Sent") ? "success" : "error" %>">
                <%= request.getParameter("error") %>
            </p>
        <% } %>

        <form action="../admin-auth" method="post">
            <input type="text" name="username" placeholder="Admin Username" required>
            <input type="password" name="password" placeholder="Secret Password" required>
            <button type="submit">Unlock Dashboard</button>
        </form>

        <br>
        <%-- HERE IS THE LINK YOU WERE LOOKING FOR --%>
        <a href="register.jsp">Request Admin Access</a>

    </div>
</body>
</html>