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
    <title>Book a Room - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #1e1e1e; color: white; font-family: 'Poppins', sans-serif; padding: 40px; display: flex; justify-content: center; }
        .container { width: 900px; }
        .header { border-bottom: 2px solid #667eea; padding-bottom: 10px; margin-bottom: 30px; }
        .room-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }
        .room-card { background: #2d2d2d; padding: 30px; border-radius: 20px; border: 1px solid #444; position: relative; }
        .room-title { font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #667eea; }
        .room-info { font-size: 14px; color: #aaa; margin-bottom: 20px; }

        input[type="date"], select { width: 100%; padding: 12px; background: #1a1a1a; border: 1px solid #444; color: white; border-radius: 8px; margin-bottom: 15px; outline: none; }

        .btn-book { background: #667eea; color: white; border: none; padding: 12px; width: 100%; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 14px; transition: 0.3s; }
        .btn-book:hover { background: #5a6fd6; transform: translateY(-2px); }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📅 Reserve a Study Space</h1>
            <p style="color: #aaa;">Quiet spaces for focus and collaboration.</p>
        </div>

        <div class="room-grid">
            <div class="room-card">
                <div class="room-title">Study Room A</div>
                <div class="room-info">Capacity: 4 People • Whiteboard • Power Outlets</div>
                <form action="RoomServlet" method="post">
                    <input type="hidden" name="roomName" value="Room A">
                    <label style="font-size: 12px; color: #888;">Select Date</label>
                    <input type="date" name="date" required>
                    <label style="font-size: 12px; color: #888;">Select Time</label>
                    <select name="time">
                        <option>09:00 AM - 11:00 AM</option>
                        <option>11:00 AM - 01:00 PM</option>
                        <option>02:00 PM - 04:00 PM</option>
                    </select>
                    <button type="submit" class="btn-book">Confirm Booking</button>
                </form>
            </div>

            <div class="room-card">
                <div class="room-title">Conference Hall</div>
                <div class="room-info">Capacity: 10 People • Projector • AC</div>
                <form action="RoomServlet" method="post">
                    <input type="hidden" name="roomName" value="Conference Hall">
                    <label style="font-size: 12px; color: #888;">Select Date</label>
                    <input type="date" name="date" required>
                    <label style="font-size: 12px; color: #888;">Select Time</label>
                    <select name="time">
                        <option>09:00 AM - 12:00 PM</option>
                        <option>01:00 PM - 04:00 PM</option>
                    </select>
                    <button type="submit" class="btn-book">Confirm Booking</button>
                </form>
            </div>
        </div>
        <a href="member-dashboard" style="display: block; margin-top: 30px; color: #aaa; text-decoration: none; text-align: center;">← Back to Dashboard</a>
    </div>
</body>
</html>