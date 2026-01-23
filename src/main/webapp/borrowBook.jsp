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
    <title>Borrow & Return - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background-color: #4D4D4D; color: white; font-family: 'Poppins', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { display: flex; gap: 30px; width: 900px; }
        .card { flex: 1; background: #383838; padding: 40px; border-radius: 20px; border: 1px solid rgba(255,255,255,0.05); }
        h2 { border-bottom: 2px solid #555; padding-bottom: 10px; margin-bottom: 20px; }
        input { width: 100%; padding: 12px; background: #2d2d2d; border: 1px solid #444; border-radius: 8px; color: white; margin-bottom: 20px; outline: none; }
        button { width: 100%; padding: 12px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; }
        .btn-borrow { background: #4A90E2; color: white; }
        .btn-return { background: #e74c3c; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 style="color: #4A90E2;">📥 Borrow</h2>
            <form action="BorrowServlet" method="POST">
                <label>Book ID</label>
                <input type="text" name="bookId" value="<%= request.getParameter("bookId") != null ? request.getParameter("bookId") : "" %>" required>
                <label>Member ID</label>
                <input type="text" name="memberId" placeholder="MEM-001" required>
                <button type="submit" class="btn-borrow">Confirm Borrow</button>
            </form>
        </div>
        <div class="card">
            <h2 style="color: #e74c3c;">📤 Return</h2>
            <form action="ReturnServlet" method="POST">
                <label>Book ID</label>
                <input type="text" name="bookId" required>
                <button type="submit" class="btn-return">Process Return</button>
            </form>
        </div>
    </div>
    <a href="member-dashboard" style="position: absolute; bottom: 30px; color: #aaa; text-decoration: none;">← Back to Dashboard</a>
</body>
</html>