<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("memberEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String bookId = request.getParameter("bookId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reading Mode - UpBooks</title>
    <style>
        body { margin: 0; background: #222; color: white; display: flex; flex-direction: column; height: 100vh; }
        .toolbar { padding: 15px; background: #333; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #444; }
        .btn-back { color: #aaa; text-decoration: none; font-family: sans-serif; font-size: 14px; }
        .viewer { flex: 1; display: flex; justify-content: center; align-items: center; background: #1a1a1a; }
        .dummy-page { width: 600px; height: 800px; background: white; color: black; padding: 50px; box-shadow: 0 0 20px black; overflow-y: auto; font-family: serif; line-height: 1.6; }
    </style>
</head>
<body>
    <div class="toolbar">
        <a href="member-dashboard" class="btn-back">← Exit Reader</a>
        <span>Digital Book ID: <%= bookId %></span>
        <div></div>
    </div>
    <div class="viewer">
        <div class="dummy-page">
            <h1>Chapter 1</h1>
            <p>This is a simulated PDF viewer for Book ID <%= bookId %>.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
            <p><strong>(To fully integrate real PDFs, you would use Mozilla PDF.js here)</strong></p>
        </div>
    </div>
</body>
</html>