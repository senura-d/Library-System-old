<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Welcome - Library System</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                color: white;
                text-align: center;
            }

            .welcome-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 50px;
                border-radius: 20px;
                border: 1px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            }

            h1 {
                margin: 0 0 10px 0;
                font-size: 2.5em;
            }

            p {
                margin-bottom: 30px;
                opacity: 0.9;
            }

            .btn {
                background-color: white;
                color: #764ba2;
                padding: 15px 30px;
                text-decoration: none;
                border-radius: 30px;
                font-weight: bold;
                font-size: 18px;
                transition: 0.3s;
                display: inline-block;
            }

            .btn:hover {
                background-color: #f0f0f0;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>

    <body>

        <div class="welcome-card">
            <h1>Library System</h1>
            <p>Manage books, students, and more.</p>
            <a href="register.jsp" class="btn">Student Registration</a>
            <br><br>
            <a href="login.jsp" class="btn" style="background-color: #333; color: white;">Member Sign In</a>
            <br><br>
            <a href="search.jsp" class="btn" style="background-color: #667eea; color: white;">Search Books</a>
        </div>

    </body>

    </html>