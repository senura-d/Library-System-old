<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Dashboard - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* --- GLOBAL RESET --- */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            background-color: #4D4D4D; /* Main Dark Background */
            color: white;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* --- SIDEBAR --- */
        .sidebar {
            width: 260px;
            background-color: #383838; /* Slightly darker than body */
            display: flex;
            flex-direction: column;
            padding: 30px;
            border-right: 1px solid rgba(255,255,255,0.05);
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            color: white;
            margin-bottom: 50px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo span { color: #4A90E2; } /* Blue Accent */

        .menu-item {
            text-decoration: none;
            color: #AAAAAA;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }
        .menu-item:hover { background: rgba(255,255,255,0.05); color: white; }

        .menu-item.active {
            background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
            color: white;
            box-shadow: 0 10px 20px rgba(74, 144, 226, 0.2);
        }

        .menu-icon { margin-right: 15px; font-size: 18px; }

        .user-profile {
            margin-top: auto;
            display: flex;
            align-items: center;
            gap: 15px;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .avatar {
            width: 40px;
            height: 40px;
            background: #1ABC9C;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        /* --- MAIN CONTENT --- */
        .main-content {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .welcome-text h1 { font-size: 28px; font-weight: 700; margin-bottom: 5px; }
        .welcome-text p { color: #AAAAAA; font-size: 14px; }

        /* Search Bar */
        .search-box {
            background: #383838;
            padding: 12px 20px;
            border-radius: 50px;
            display: flex;
            align-items: center;
            border: 1px solid rgba(255,255,255,0.05);
            width: 300px;
        }
        .search-box input {
            background: transparent;
            border: none;
            color: white;
            outline: none;
            margin-left: 10px;
            width: 100%;
        }

        /* --- BOOK GRID --- */
        .section-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-left: 4px solid #4A90E2; padding-left: 15px; }

        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        /* The Glass Book Card */
        .book-card {
            background: #383838;
            border-radius: 20px;
            padding: 20px;
            transition: 0.3s;
            border: 1px solid rgba(255,255,255,0.05);
            position: relative;
            overflow: hidden;
        }
        .book-card:hover {
            transform: translateY(-5px);
            background: #404040;
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
            border-color: #4A90E2;
        }

        .book-cover {
            height: 140px;
            background: linear-gradient(135deg, #595959 0%, #2b2b2b 100%);
            border-radius: 12px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }

        .book-title { font-size: 16px; font-weight: 700; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .book-author { font-size: 12px; color: #AAAAAA; margin-bottom: 15px; }

        .btn-borrow {
            width: 100%;
            padding: 10px;
            background: #383838;
            border: 1px solid #4A90E2;
            color: #4A90E2;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 13px;
            transition: 0.3s;
        }
        .btn-borrow:hover {
            background: #4A90E2;
            color: white;
        }

    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">Up<span>Books</span></div>

        <a href="#" class="menu-item active">
            <span class="menu-icon">🏠</span> Browse Books
        </a>
        <a href="#" class="menu-item">
            <span class="menu-icon">📖</span> My Loans
        </a>
        <a href="#" class="menu-item">
            <span class="menu-icon">🔖</span> Favorites
        </a>
        <a href="#" class="menu-item">
            <span class="menu-icon">⚙️</span> Settings
        </a>

        <div class="user-profile">
            <div class="avatar">S</div>
            <div style="font-size: 14px;">
                <div style="font-weight: 600;">Student</div>
                <div style="font-size: 11px; color: #888;">Online</div>
            </div>
            <a href="login.jsp" style="margin-left: auto; color: #e74c3c; text-decoration: none; font-size: 12px;">Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="welcome-text">
                <h1>Welcome Back!</h1>
                <p>Discover your next great read.</p>
            </div>
            <div class="search-box">
                <span>🔍</span>
                <input type="text" placeholder="Search for books...">
            </div>
        </div>

        <div class="section-title">New Arrivals</div>

        <div class="book-grid">
            <div class="book-card">
                <div class="book-cover">📘</div> <div class="book-title">The Great Gatsby</div>
                <div class="book-author">F. Scott Fitzgerald</div>
                <button class="btn-borrow">Borrow Book</button>
            </div>

            <div class="book-card">
                <div class="book-cover">📕</div>
                <div class="book-title">Atomic Habits</div>
                <div class="book-author">James Clear</div>
                <button class="btn-borrow">Borrow Book</button>
            </div>

            <div class="book-card">
                <div class="book-cover">📗</div>
                <div class="book-title">Clean Code</div>
                <div class="book-author">Robert C. Martin</div>
                <button class="btn-borrow">Borrow Book</button>
            </div>

            <div class="book-card">
                <div class="book-cover">📙</div>
                <div class="book-title">Java Programming</div>
                <div class="book-author">Herbert Schildt</div>
                <button class="btn-borrow">Borrow Book</button>
            </div>

             <div class="book-card">
                <div class="book-cover">📓</div>
                <div class="book-title">Design Patterns</div>
                <div class="book-author">Gang of Four</div>
                <button class="btn-borrow">Borrow Book</button>
            </div>
        </div>
    </div>

</body>
</html>