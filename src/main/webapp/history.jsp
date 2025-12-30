<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>

        :root {
            --primary: #4F46E5;
            --bg-color: #f3f4f6;
            --card-bg: #ffffff;
            --text-dark: #1f2937;
            --text-light: #6b7280;
            --danger: #ef4444;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-color);
            margin: 0; padding: 20px;
            color: var(--text-dark);
        }
        .container { max-width: 1200px; margin: 0 auto; }


        .profile-header {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }


        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .profile-title {
            font-size: 18px;
            font-weight: 500;
            color: var(--text-dark);
            margin: 0;
        }


        .header-actions { display: flex; gap: 10px; }

        .btn {
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
            text-decoration: none;
        }


        .btn-pdf {
            background-color: var(--primary);
            color: white;
        }
        .btn-pdf:hover { opacity: 0.9; }

        .btn-logout {
            background-color: #fee2e2;
            color: var(--danger);
        }
        .btn-logout:hover { background-color: #fecaca; }


        .profile-content {
            display: flex;
            align-items: flex-start;
        }

        .avatar-circle {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #8a2be2, #4b0082);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 40px;
            margin-right: 30px;
        }

        .profile-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 50px;
            row-gap: 20px;
            flex-grow: 1;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 14px;
            color: var(--text-light);
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 16px;
            font-weight: 500;
            color: var(--text-dark);
        }


        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }


        .card-section {
            background: var(--card-bg); padding: 25px; border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 20px;
        }
        h3 { margin-top: 0; border-bottom: 1px solid #eee; padding-bottom: 10px; display: flex; justify-content: space-between; }


        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #f0f0f0; font-size: 14px; }
        th { color: #888; font-weight: 500; }


        .badge { padding: 4px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .badge-returned { background: #d1fae5; color: #065f46; }
        .badge-borrowed { background: #fef3c7; color: #92400e; }
        .badge-overdue { background: #fee2e2; color: #991b1b; }
        .badge-room { background: #e0e7ff; color: #3730a3; }


        .qr-section {
            background: var(--card-bg); padding: 30px; border-radius: 16px;
            text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            height: fit-content;
        }
        .qr-box {
            background: #f8fafc; padding: 20px; border-radius: 12px;
            margin-top: 15px; border: 2px dashed #cbd5e1; display: inline-block;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .qr-box:hover {
            transform: scale(1.02);
            border-color: var(--primary);
        }


        .qr-download-hint {
            font-size: 11px;
            color: var(--text-light);
            margin-top: 8px;
            display: block;
        }


        @media print {
            .header-actions, .qr-section { display: none; }
            .content-grid { display: block; }
            body { background: white; }
        }
    </style>
</head>
<body>

<div class="container">

    <div class="profile-header">
        <div class="header-top">
            <div class="profile-title">Profile Information</div>
            <div class="header-actions">
                <button class="btn btn-logout" onclick="window.location.href='login.jsp'">Logout</button>
            </div>
        </div>

        <div class="profile-content">
            <div class="avatar-circle">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 50px; height: 50px;">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z" />
                </svg>
            </div>
            <div class="profile-details">
                <div class="detail-item">
                    <span class="detail-label">Full Name</span>
                    <span class="detail-value">John Doe</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Student ID</span>
                    <span class="detail-value">NSBM-2024</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Email</span>
                    <span class="detail-value">sgfgvhv123@gmail.com</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Phone</span>
                    <span class="detail-value">+1 234 567 8900</span>
                </div>
            </div>
        </div>
    </div>

    <div class="content-grid">

        <div class="main-content">

            <div class="card-section">
                <h3>📚 Book Transactions (Borrow & Return)</h3>
                <table>
                    <thead>
                    <tr>
                        <th>Book Title</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<String[]> historyList = (List<String[]>) request.getAttribute("bookHistory");
                        // Note: Ensure this matches your Servlet attribute name (bookHistory or historyList)
                        if (historyList != null && !historyList.isEmpty()) {
                            for (String[] record : historyList) {
                                String statusClass = "badge-borrowed";
                                if(record[2].equalsIgnoreCase("RETURNED")) statusClass = "badge-returned";
                                if(record[2].equalsIgnoreCase("OVERDUE")) statusClass = "badge-overdue";
                    %>
                    <tr>
                        <td><b><%= record[0] %></b></td>
                        <td><%= record[1] %></td>
                        <td><span class="badge <%= statusClass %>"><%= record[2] %></span></td>
                    </tr>
                    <%      }
                    } else {
                    %>
                    <tr><td colspan="3" style="text-align:center; color:#888;">No book history found.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="card-section">
                <h3>🏢 Study Room Bookings</h3>
                <table>
                    <thead>
                    <tr>
                        <th>Room Name</th>
                        <th>Date & Time</th>
                        <th>Duration</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%

                        List<String[]> roomList = (List<String[]>) request.getAttribute("roomHistory");
                        if (roomList != null && !roomList.isEmpty()) {
                            for (String[] room : roomList) {
                                String badgeClass = "b-purple";
                                if(room[4].equalsIgnoreCase("COMPLETED")) badgeClass = "badge-returned";
                                if(room[4].equalsIgnoreCase("CANCELLED")) badgeClass = "badge-overdue";
                    %>
                    <tr>
                        <td style="font-weight:600;"><%= room[0] %></td>
                        <td><%= room[1] %> (<%= room[2] %>)</td>
                        <td>Until <%= room[3] %></td>
                        <td><span class="badge <%= badgeClass %>"><%= room[4] %></span></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4" style="text-align:center; color:#888;">No room bookings found.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>

        <div class="qr-section">
            <h3>Digital ID</h3>
            <p style="font-size:12px; color:#888;">Library Access & Borrowing</p>

            <div class="qr-box">
                <img src="QRServlet?id=M123" width="160" height="160" alt="QR Code">
            </div>

            <p style="margin-top:15px; font-weight:bold; color:#4F46E5;">M123</p>
        </div>

    </div>
</div>

</body>
</html>