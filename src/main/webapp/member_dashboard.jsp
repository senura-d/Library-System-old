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
    <title>Student Dashboard - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* RESET & FONT */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: #4D4D4D; color: white; display: flex; height: 100vh; overflow: hidden; }

        /* SIDEBAR */
        .sidebar { width: 260px; background-color: #383838; display: flex; flex-direction: column; padding: 30px; border-right: 1px solid rgba(255,255,255,0.05); height: 100vh; }
        .logo { font-size: 24px; font-weight: 800; color: white; margin-bottom: 40px; display: flex; align-items: center; gap: 10px; }
        .logo span { color: #4A90E2; }

        /* MENU */
        .menu-item { text-decoration: none; color: #AAAAAA; padding: 12px 15px; margin-bottom: 10px; border-radius: 12px; font-weight: 600; font-size: 14px; display: flex; align-items: center; transition: 0.3s; }
        .menu-item:hover, .menu-item.active { background: rgba(255,255,255,0.05); color: white; }
        .menu-icon { margin-right: 15px; font-size: 18px; }

        /* PROFILE SECTION (FIXED) */
        .user-profile {
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .avatar {
            width: 40px; height: 40px;
            background: #4A90E2;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: bold; color: white; font-size: 18px;
        }
        .user-info { display: flex; flex-direction: column; }
        .user-name { font-size: 14px; font-weight: 600; color: white; }
        .user-status { font-size: 11px; color: #2ecc71; }
        .logout-btn { margin-left: auto; color: #e74c3c; text-decoration: none; font-size: 14px; font-weight: 600; }

        /* MAIN CONTENT */
        .main-content { flex: 1; padding: 40px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .welcome-text h1 { font-size: 28px; font-weight: 700; margin-bottom: 5px; }
        .search-form { display: flex; align-items: center; background: #383838; padding: 10px 20px; border-radius: 50px; border: 1px solid rgba(255,255,255,0.05); width: 350px; }
        .search-form input { background: transparent; border: none; color: white; outline: none; margin-left: 10px; width: 100%; }

        /* BOOKS */
        .book-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 25px; }
        .book-card { background: #383838; border-radius: 20px; padding: 20px; text-align: center; border: 1px solid rgba(255,255,255,0.05); transition: 0.3s; }
        .book-card:hover { transform: translateY(-5px); background: #404040; border-color: #4A90E2; }
        .book-cover { height: 120px; background: #2b2b2b; border-radius: 12px; margin-bottom: 15px; display: flex; align-items: center; justify-content: center; font-size: 40px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">Up<span>Books</span></div>
        <a href="member-dashboard.jsp" class="menu-item active"><span class="menu-icon">🏠</span> Dashboard</a>
        <a href="borrowBook.jsp" class="menu-item"><span class="menu-icon">📚</span> Borrow Book</a>
        <a href="returnBook.jsp" class="menu-item"><span class="menu-icon">↩️</span> Return Book</a>
        <a href="roomBooking.jsp" class="menu-item"><span class="menu-icon">📅</span> Book Study Room</a>
        <a href="history.jsp" class="menu-item"><span class="menu-icon">📜</span> History</a>
        <a href="profile.jsp" class="menu-item"><span class="menu-icon">👤</span> My Profile</a>

        <div class="user-profile">
            <div class="avatar">
                <%= session.getAttribute("memberName") != null ? session.getAttribute("memberName").toString().substring(0,1) : "U" %>
            </div>
            <div class="user-info">
                <span class="user-name"><%= session.getAttribute("memberName") != null ? session.getAttribute("memberName") : "Student" %></span>
                <span class="user-status">● Online</span>
            </div>
            <a href="logout" class="logout-btn">Log Out</a>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="welcome-text">
                <h1>Welcome Back!</h1>
                <p>Manage your library activity.</p>
            </div>
            <form action="search.jsp" method="get" class="search-form">
                <button type="submit" style="background:none; border:none; color:white;">🔍</button>
                <input type="text" name="q" placeholder="Search title or author...">
            </form>
        </div>

        <h3 style="margin-bottom: 20px; border-left: 4px solid #4A90E2; padding-left: 10px;">New Arrivals</h3>
        <div class="book-grid">
            <div class="book-card"><div class="book-cover">📘</div><h4>The Great Gatsby</h4><p style="color:#aaa; font-size:12px;">F. Scott Fitzgerald</p></div>
            <div class="book-card"><div class="book-cover">📕</div><h4>Atomic Habits</h4><p style="color:#aaa; font-size:12px;">James Clear</p></div>
            <div class="book-card"><div class="book-cover">📗</div><h4>Clean Code</h4><p style="color:#aaa; font-size:12px;">Robert C. Martin</p></div>
            <div class="book-card"><div class="book-cover">📙</div><h4>Design Patterns</h4><p style="color:#aaa; font-size:12px;">Gang of Four</p></div>
        </div>
    </div>
</body>
</html>