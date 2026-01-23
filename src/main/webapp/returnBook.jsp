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
    <title>Return Book - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #4D4D4D; color: white; font-family: 'Poppins', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }

        .container {
            background: #383838;
            padding: 50px;
            border-radius: 20px;
            width: 500px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
        }

        h2 { margin-bottom: 30px; color: #e74c3c; display: flex; align-items: center; justify-content: center; gap: 10px; }

        .form-group { text-align: left; margin-bottom: 20px; }
        label { display: block; color: #aaa; font-size: 12px; font-weight: bold; margin-bottom: 8px; text-transform: uppercase; }

        input {
            width: 100%;
            padding: 15px;
            background: #2d2d2d;
            border: 1px solid #444;
            border-radius: 10px;
            color: white;
            outline: none;
            font-size: 14px;
        }
        input:focus { border-color: #e74c3c; }

        .btn-return {
            width: 100%;
            padding: 15px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            transition: 0.3s;
        }
        .btn-return:hover { background: #c0392b; }

        .back-link { display: block; margin-top: 20px; color: #aaa; text-decoration: none; font-size: 13px; }
        .back-link:hover { color: white; }
    </style>
</head>
<body>

    <div class="container">
        <h2>↩️ Return Book</h2>
        <p style="color: #aaa; margin-bottom: 30px; font-size: 14px;">Enter the Book ID to return it to the library.</p>

        <form action="ReturnServlet" method="post">
            <div class="form-group">
                <label>Book ID</label>
                <input type="number" name="bookId" placeholder="Enter Book ID" required>
            </div>

            <input type="hidden" name="memberId" value="<%= session.getAttribute("memberId") %>">

            <button type="submit" class="btn-return">Confirm Return</button>
        </form>

        <a href="member_dashboard.jsp" class="back-link">← Back to Dashboard</a>
    </div>

</body>
</html>