<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Request Admin Access</title>
    <style>
        body { background-color: #222; color: white; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background-color: #333; padding: 40px; border-radius: 8px; text-align: center; width: 350px; border: 1px solid #444; }
        input { width: 100%; padding: 10px; margin: 10px 0; background: #444; border: 1px solid #555; color: white; }
        button { width: 100%; padding: 10px; background: #e74c3c; color: white; border: none; font-weight: bold; cursor: pointer; }
        button:hover { background: #c0392b; }
        a { color: #aaa; font-size: 12px; }
        h2 { margin-bottom: 5px; }
        p { color: #888; font-size: 12px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Apply for Admin Access</h2>
        <p>Your account must be approved by a Super Admin.</p>

        <form action="../admin-register" method="post">
            <input type="text" name="username" placeholder="Choose a Username" required>
            <input type="password" name="password" placeholder="Choose a Password" required>
            <button type="submit">Submit Request</button>
        </form>
        <br>
        <a href="index.jsp">Back to Login</a>
    </div>
</body>
</html>