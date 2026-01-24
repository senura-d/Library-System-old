<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard - Library System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* --- GLOBAL RESET --- */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            background-color: #1e1e1e; /* Deep Charcoal Background */
            color: #ecf0f1; /* Light Gray Text */
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* --- SIDEBAR (Left) --- */
        .sidebar {
            width: 260px;
            background-color: #252525;
            display: flex;
            flex-direction: column;
            padding: 30px;
            border-right: 1px solid #333;
        }

        .brand {
            font-size: 20px;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 50px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .brand span { color: #e74c3c; } /* Red Accent */

        /* Menu Items */
        .menu-item {
            text-decoration: none;
            color: #95a5a6;
            padding: 15px;
            margin-bottom: 8px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }
        .menu-item:hover {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
        }
        .menu-item.active {
            background-color: #e74c3c;
            color: white;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        .menu-icon { margin-right: 15px; width: 20px; text-align: center; }

        .logout-btn {
            margin-top: auto;
            color: #e74c3c;
            border: 1px solid #e74c3c;
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            transition: 0.3s;
        }
        .logout-btn:hover { background: #e74c3c; color: white; }


        /* --- MAIN CONTENT (Right) --- */
        .main-content {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .page-title h1 { font-size: 28px; font-weight: 700; margin-bottom: 5px; }
        .page-title p { color: #7f8c8d; font-size: 14px; }

        /* --- STATS GRID --- */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background-color: #2d2d2d;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
            border-left: 4px solid #e74c3c;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-5px); }

        .stat-label { font-size: 12px; color: #95a5a6; font-weight: 600; text-transform: uppercase; margin-bottom: 10px; }
        .stat-value { font-size: 32px; font-weight: 700; color: white; }
        .stat-icon { float: right; font-size: 24px; color: #e74c3c; opacity: 0.5; }

        /* --- QUICK ACTIONS SECTION --- */
        .section-header { margin-bottom: 20px; font-size: 18px; font-weight: 600; color: white; border-left: 4px solid #e74c3c; padding-left: 15px; }

        .action-grid {
            display: flex;
            gap: 20px;
        }

        .action-btn {
            background-color: #e74c3c;
            color: white;
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: 0.3s;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.2);
        }
        .action-btn:hover { background-color: #c0392b; transform: translateY(-2px); }
        .action-btn.secondary { background-color: #2d2d2d; border: 1px solid #444; }
        .action-btn.secondary:hover { border-color: #e74c3c; color: #e74c3c; }

    </style>
</head>
<body>

    <div class="sidebar">
        <div class="brand">🛡️ Admin<span>Panel</span></div>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item active">
            <span class="menu-icon">📊</span> Overview
        </a>

        <a href="${pageContext.request.contextPath}/manage-books" class="menu-item">
            <span class="menu-icon">📚</span> Manage Books
        </a>

        <a href="${pageContext.request.contextPath}/manage-rooms" class="menu-item">
            <span class="menu-icon">🏢</span> Rooms
        </a>

        <a href="${pageContext.request.contextPath}/logout" class="menu-item logout-btn">Log Out</a>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="page-title">
                <h1>Dashboard</h1>
                <p>Welcome back, Admin. System overview.</p>
            </div>
            <div style="display: flex; align-items: center; gap: 15px;">
                <span style="font-size: 14px; color: #95a5a6;">Server Status: </span>
                <span style="color: #2ecc71; font-weight: 600;">● Online</span>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">📚</div>
                <div class="stat-label">Total Books</div>
                <div class="stat-value"><%= request.getAttribute("totalBooks") != null ? request.getAttribute("totalBooks") : "0" %></div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-label">Active Members</div>
                <div class="stat-value"><%= request.getAttribute("totalMembers") != null ? request.getAttribute("totalMembers") : "0" %></div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">⏳</div>
                <div class="stat-label">Issued Books</div>
                <div class="stat-value"><%= request.getAttribute("issuedBooks") != null ? request.getAttribute("issuedBooks") : "0" %></div>
            </div>

            <div class="stat-card" style="border-color: #c0392b;">
                <div class="stat-icon" style="color: #c0392b;">⚠️</div>
                <div class="stat-label" style="color: #e74c3c;">Overdue Alerts</div>
                <div class="stat-value"><%= request.getAttribute("overdueBooks") != null ? request.getAttribute("overdueBooks") : "0" %></div>
            </div>
        </div>

        <div class="section-header">Quick Actions</div>
        <div class="action-grid">

            <a href="${pageContext.request.contextPath}/admin/add_book.jsp" class="action-btn">
                <span>+</span> Add New Book
            </a>

            <a href="#" class="action-btn secondary">
                <span>👤</span> Approve Members
            </a>

            <a href="#" class="action-btn secondary">
                <span>🔄</span> Issue a Book
            </a>
        </div>

        <br><br>
        <div class="section-header">Recent Activity</div>
        <div style="background: #2d2d2d; padding: 20px; border-radius: 12px; color: #7f8c8d; font-size: 14px; text-align: center; border: 1px dashed #444;">
            No recent transactions found.
        </div>

    </div>

</body>
</html>