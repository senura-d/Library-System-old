<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Security Check: Ensure Admin is logged in
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - Library System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* RESET & FONT */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: #1e1e1e; color: white; display: flex; height: 100vh; overflow: hidden; }

        /* SIDEBAR */
        .sidebar { width: 260px; background-color: #252525; display: flex; flex-direction: column; padding: 30px; border-right: 1px solid #333; height: 100vh; }

        .logo { font-size: 22px; font-weight: 800; color: white; margin-bottom: 40px; display: flex; align-items: center; gap: 10px; }
        .logo span { color: #e74c3c; } /* Red for Admin */

        .menu-item { text-decoration: none; color: #aaa; padding: 12px 15px; margin-bottom: 10px; border-radius: 10px; font-weight: 600; font-size: 14px; display: flex; align-items: center; transition: 0.3s; }
        .menu-item:hover, .menu-item.active { background: rgba(231, 76, 60, 0.1); color: #e74c3c; }
        .menu-icon { margin-right: 15px; font-size: 18px; }

        /* LOGOUT BUTTON (Fixed at Bottom) */
        .logout-btn { margin-top: auto; color: #e74c3c; text-decoration: none; font-weight: 600; padding: 12px; border: 1px solid #e74c3c; text-align: center; border-radius: 8px; transition: 0.3s; }
        .logout-btn:hover { background: #e74c3c; color: white; }

        /* MAIN CONTENT */
        .main-content { flex: 1; padding: 40px; overflow-y: auto; }

        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header h1 { font-size: 28px; }
        .status-badge { background: #2ecc71; color: #000; padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: 800; text-transform: uppercase; }

        /* STATS CARDS */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; }
        .stat-card { background: #2d2d2d; padding: 25px; border-radius: 15px; display: flex; flex-direction: column; justify-content: center; border: 1px solid #333; }
        .stat-title { font-size: 12px; color: #aaa; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px; }
        .stat-value { font-size: 32px; font-weight: 700; color: white; }
        .stat-icon { font-size: 24px; align-self: flex-end; margin-top: -40px; opacity: 0.5; }

        /* QUICK ACTIONS GRID */
        .section-title { font-size: 18px; font-weight: 700; margin-bottom: 20px; border-left: 4px solid #e74c3c; padding-left: 15px; }

        .actions-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px; }

        .action-card {
            background: #2d2d2d;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            text-decoration: none;
            transition: 0.3s;
            border: 1px solid #333;
            display: flex; flex-direction: column; align-items: center; justify-content: center; height: 120px;
        }
        .action-card:hover { transform: translateY(-5px); border-color: #e74c3c; }

        .action-icon { font-size: 30px; margin-bottom: 10px; }
        .action-text { color: white; font-weight: 600; font-size: 14px; }

        /* RECENT ACTIVITY TABLE */
        .table-container { background: #2d2d2d; padding: 20px; border-radius: 15px; border: 1px solid #333; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; color: #aaa; font-size: 12px; text-transform: uppercase; border-bottom: 1px solid #444; }
        td { padding: 15px; border-bottom: 1px solid #333; font-size: 14px; color: #ddd; }
        tr:last-child td { border-bottom: none; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo">Admin<span>Panel</span></div>
        <a href="dashboard.jsp" class="menu-item active"><span class="menu-icon">📊</span> Overview</a>
        <a href="books.jsp" class="menu-item"><span class="menu-icon">📚</span> Manage Books</a>
        <a href="users.jsp" class="menu-item"><span class="menu-icon">👥</span> Users</a>
        <a href="rooms.jsp" class="menu-item"><span class="menu-icon">🏢</span> Rooms</a>
        <a href="../logout" class="logout-btn">Log Out</a>
    </div>

    <div class="main-content">
        <div class="header">
            <div>
                <h1>Dashboard</h1>
                <p style="color: #888; font-size: 14px;">Welcome back, Admin. System overview.</p>
            </div>
            <span class="status-badge">● System Online</span>
        </div>

        <div class="stats-grid">
            <div class="stat-card" style="border-bottom: 4px solid #3498db;">
                <span class="stat-title">Total Books</span>
                <span class="stat-value">120</span>
                <span class="stat-icon">📚</span>
            </div>
            <div class="stat-card" style="border-bottom: 4px solid #9b59b6;">
                <span class="stat-title">Active Members</span>
                <span class="stat-value">45</span>
                <span class="stat-icon">👥</span>
            </div>
            <div class="stat-card" style="border-bottom: 4px solid #f1c40f;">
                <span class="stat-title">Books Issued</span>
                <span class="stat-value">12</span>
                <span class="stat-icon">📖</span>
            </div>
            <div class="stat-card" style="border-bottom: 4px solid #e74c3c;">
                <span class="stat-title">Overdue</span>
                <span class="stat-value">3</span>
                <span class="stat-icon">⚠️</span>
            </div>
        </div>

        <div class="section-title">Quick Actions</div>
        <div class="actions-grid">
            <a href="add_book.jsp" class="action-card">
                <span class="action-icon" style="color: #2ecc71;">➕</span>
                <span class="action-text">Add New Book</span>
            </a>

            <a href="issue_book.jsp" class="action-card">
                <span class="action-icon" style="color: #3498db;">📤</span>
                <span class="action-text">Issue a Book</span>
            </a>

            <a href="return_book.jsp" class="action-card">
                <span class="action-icon" style="color: #e67e22;">📥</span>
                <span class="action-text">Return Book</span>
            </a>

            <a href="approve_members.jsp" class="action-card">
                <span class="action-icon" style="color: #9b59b6;">✅</span>
                <span class="action-text">Approve Users</span>
            </a>
        </div>

        <div class="section-title">Recent System Activity</div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Action</th>
                        <th>User</th>
                        <th>Details</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="color: #2ecc71;">Book Returned</td>
                        <td>S-2026</td>
                        <td>Returned "The Great Gatsby"</td>
                        <td>10 mins ago</td>
                    </tr>
                    <tr>
                        <td style="color: #3498db;">Room Booked</td>
                        <td>MEM-001</td>
                        <td>Reserved "Study Room A"</td>
                        <td>1 hour ago</td>
                    </tr>
                    <tr>
                        <td style="color: #e74c3c;">Login Failed</td>
                        <td>Unknown</td>
                        <td>Failed attempt from IP 192.168.1.5</td>
                        <td>2 hours ago</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>