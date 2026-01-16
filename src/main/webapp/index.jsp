<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome - UpBooks Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            height: 100vh;
            background-color: #4D4D4D; /* Your requested Dark Background */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* The Main Split-Screen Card */
        .container {
            width: 1100px;
            height: 650px;
            background: #383838; /* Slightly darker card background */
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.4);
            display: flex;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* --- LEFT SIDE: THE "FILLER" (Abstract Art) --- */
        .art-section {
            flex: 1.2;
            background: linear-gradient(135deg, #4A90E2 0%, #8E44AD 100%); /* Blue to Purple Gradient */
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Decorative CSS Circles (No Images!) */
        .circle-1 {
            position: absolute;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -50px;
            left: -50px;
        }
        .circle-2 {
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            bottom: -50px;
            right: -50px;
        }

        /* The "Quote" Card in the middle */
        .quote-card {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px); /* Glass effect */
            padding: 40px;
            border-radius: 20px;
            max-width: 80%;
            color: white;
            z-index: 10;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        .quote-text { font-size: 20px; font-weight: 600; font-style: italic; margin-bottom: 20px; line-height: 1.5; }
        .quote-author { font-size: 14px; text-transform: uppercase; letter-spacing: 2px; opacity: 0.8; }

        /* --- RIGHT SIDE: CONTENT --- */
        .content-section {
            flex: 1;
            padding: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
        }

        .brand { font-size: 56px; font-weight: 800; color: #FFFFFF; margin-bottom: 10px; line-height: 1; }
        .brand span { color: #4A90E2; } /* Blue Accent */

        .subtitle { color: #CCCCCC; font-size: 16px; margin-bottom: 50px; line-height: 1.6; }

        .btn-container { display: flex; flex-direction: column; gap: 15px; width: 100%; }

        .btn {
            padding: 18px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            text-align: center;
            transition: 0.3s;
        }

        .btn-primary { background-color: #4A90E2; color: white; border: none; }
        .btn-primary:hover { background-color: #357ABD; transform: translateY(-2px); }

        .btn-secondary { background-color: transparent; color: white; border: 2px solid rgba(255, 255, 255, 0.2); }
        .btn-secondary:hover { border-color: white; background: rgba(255,255,255,0.05); }

        .footer { margin-top: auto; padding-top: 30px; font-size: 12px; color: rgba(255, 255, 255, 0.3); }

    </style>
</head>
<body>

    <div class="container">
        <div class="art-section">
            <div class="circle-1"></div>
            <div class="circle-2"></div>

            <div class="quote-card">
                <div class="quote-text">"A room without books is like a body without a soul."</div>
                <div class="quote-author">- Marcus Tullius Cicero</div>
            </div>
        </div>

        <div class="content-section">
            <div class="brand">UpBooks<span>.</span></div>
            <p class="subtitle">Welcome to your modern digital library. Manage your reading lists, track borrowing, and explore new worlds.</p>

            <div class="btn-container">
                <a href="login.jsp" class="btn btn-primary">Member Sign In</a>
                <a href="register.jsp" class="btn btn-secondary">Create Student Account</a>
            </div>

            <div class="footer">&copy; 2026 UpBooks Library System</div>
        </div>
    </div>

</body>
</html>