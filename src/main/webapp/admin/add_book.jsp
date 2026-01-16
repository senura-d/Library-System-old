<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Book - Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* --- DARK THEME RESET --- */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            background-color: #1e1e1e; /* Deep Charcoal Background */
            color: #ecf0f1;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        /* --- CARD DESIGN --- */
        .form-container {
            background-color: #2d2d2d; /* Card Gray */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
            width: 450px;
            border-top: 4px solid #e74c3c; /* Red Accent Top */
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: white;
            font-weight: 700;
        }

        /* --- INPUT FIELDS --- */
        .form-group { margin-bottom: 20px; }

        label {
            display: block;
            margin-bottom: 8px;
            color: #95a5a6;
            font-size: 14px;
            font-weight: 600;
        }

        input, select {
            width: 100%;
            padding: 12px;
            background-color: #383838; /* Input Background */
            border: 1px solid #444;
            border-radius: 8px;
            color: white;
            outline: none;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #e74c3c; /* Red Focus */
            background-color: #404040;
        }

        /* --- BUTTONS --- */
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #e74c3c; /* Red Button */
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-submit:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #95a5a6;
            text-decoration: none;
            font-size: 13px;
        }
        .back-link:hover { color: white; }

    </style>
</head>
<body>

    <div class="form-container">
        <h2>Add New Book</h2>

        <form action="${pageContext.request.contextPath}/add-book" method="post">

            <div class="form-group">
                <label>Book Title</label>
                <input type="text" name="title" required placeholder="e.g. The Great Gatsby">
            </div>

            <div class="form-group">
                <label>Author</label>
                <input type="text" name="author" required placeholder="e.g. F. Scott Fitzgerald">
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="category">
                    <option value="Fiction">Fiction</option>
                    <option value="Science">Science</option>
                    <option value="History">History</option>
                    <option value="Technology">Technology</option>
                    <option value="Education">Education</option>
                </select>
            </div>

            <button type="submit" class="btn-submit">Add Book</button>

            <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">
                ← Back to Dashboard
            </a>
        </form>
    </div>

</body>
</html>