<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Account - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            height: 100vh;
            background-color: #4D4D4D;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            width: 1100px;
            height: 700px;
            background: #383838;
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.4);
            display: flex;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* ART SECTION (LEFT) */
        .art-section {
            flex: 1;
            background: linear-gradient(135deg, #1ABC9C 0%, #3498DB 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .square-1 {
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 40px;
            transform: rotate(45deg);
            top: -50px;
            left: -50px;
        }
        .square-2 {
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 30px;
            transform: rotate(20deg);
            bottom: 50px;
            right: 50px;
        }

        .quote-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 20px;
            max-width: 80%;
            color: white;
            z-index: 10;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            text-align: center;
        }
        .quote-text { font-size: 18px; font-weight: 600; font-style: italic; margin-bottom: 15px; line-height: 1.5; }
        .quote-author { font-size: 12px; text-transform: uppercase; letter-spacing: 2px; opacity: 0.8; }

        /* FORM SECTION (RIGHT) */
        .form-section {
            flex: 1.2;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
        }

        h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; color: #FFFFFF; }
        p { color: #CCCCCC; font-size: 14px; margin-bottom: 30px; }

        .form-group { margin-bottom: 15px; }
        label { display: block; font-size: 12px; font-weight: 700; color: #AAAAAA; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px; }

        input {
            width: 100%;
            padding: 16px;
            background: #4A4A4A;
            border: 1px solid #5A5A5A;
            border-radius: 12px;
            font-size: 14px;
            color: white;
            outline: none;
            transition: 0.3s;
        }
        input:focus { border-color: #1ABC9C; background: #505050; }

        .btn-register {
            width: 100%;
            padding: 16px;
            background-color: #1ABC9C;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 15px;
        }
        .btn-register:hover { background-color: #16a085; transform: translateY(-2px); }

        .links { margin-top: 30px; font-size: 13px; color: #AAAAAA; text-align: center; }
        .links a { color: #1ABC9C; text-decoration: none; font-weight: 700; }
    </style>
</head>
<body>
    <div class="container">
        <div class="art-section">
            <div class="square-1"></div>
            <div class="square-2"></div>
            <div class="quote-card">
                <div class="quote-text">"Education is the passport to the future, for tomorrow belongs to those who prepare for it today."</div>
                <div class="quote-author">- Malcolm X</div>
            </div>
        </div>

        <div class="form-section">
            <h1>Student Sign Up</h1>
            <p>Create your account to start borrowing books.</p>

            <form action="register" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullname" placeholder="e.g. John Doe" required>
                </div>
                <div class="form-group">
                    <label>Student ID (Username)</label>
                    <input type="text" name="username" placeholder="e.g. S-2026" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create a strong password" required>
                </div>
                <button type="submit" class="btn-register">Create Account</button>
            </form>

            <div class="links">
                Already have an account? <a href="login.jsp">Sign In</a>
            </div>
        </div>
    </div>
</body>
</html>