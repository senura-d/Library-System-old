<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In - UpBooks</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* --- GLOBAL RESET --- */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }

        body {
            height: 100vh;
            background-color: #4D4D4D; /* Dark Background */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* --- MAIN CARD CONTAINER --- */
        .container {
            width: 1000px;
            height: 600px;
            background: #383838; /* Dark Card Background */
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.4);
            display: flex;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* --- LEFT SIDE: LOGIN FORM --- */
        .form-section {
            flex: 1;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
        }

        h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; color: #FFFFFF; }
        p { color: #CCCCCC; font-size: 14px; margin-bottom: 40px; }

        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 12px; font-weight: 700; color: #AAAAAA; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px; }

        /* Dark Inputs */
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
        input::placeholder { color: #888; }
        input:focus { border-color: #4A90E2; background: #505050; }

        .btn-submit {
            width: 100%;
            padding: 16px;
            background-color: #4A90E2; /* Bright Blue Button */
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-submit:hover { background-color: #357ABD; transform: translateY(-2px); }

        .links { margin-top: 30px; font-size: 13px; color: #AAAAAA; text-align: center; }
        .links a { color: #4A90E2; text-decoration: none; font-weight: 700; }
        .links a:hover { text-decoration: underline; }

        /* --- RIGHT SIDE: ABSTRACT ART & QUOTE --- */
        .art-section {
            flex: 1.1; /* Slightly wider */
            /* Purple to Blue Gradient */
            background: linear-gradient(135deg, #8E44AD 0%, #4A90E2 100%);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Abstract Circles */
        .circle-1 {
            position: absolute;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            top: -50px;
            right: -50px;
        }
        .circle-2 {
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            bottom: 50px;
            left: 50px;
        }

        /* The Quote Card */
        .quote-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px); /* Glass Effect */
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
        /* Add this inside the <style> tag in login.jsp */
        .btn-login {
            width: 100%;
            padding: 14px;
            background-color: #4a90e2; /* Nice Blue Color */
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 15px;
        }

        .btn-login:hover {
            background-color: #357abd; /* Darker Blue on Hover */
        }

    </style>
</head>
<body>

    <div class="container">
        <div class="form-section">
            <h1>Welcome Back</h1>
            <p>Please enter your details to sign in.</p>

            <% String error = request.getParameter("error");
               if (error != null) { %>
                <div style="background: rgba(231, 76, 60, 0.2); border: 1px solid #e74c3c; color: #ffadad; padding: 10px; border-radius: 8px; margin-bottom: 20px; font-size: 13px;">
                    ⚠️ Invalid Username or Password
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="input-group">
                    <label>Username or Email</label>
                    <input type="text" name="username" placeholder="Enter student ID or Email" required>
                </div>

                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="........" required>
                </div>

                <button type="submit" class="btn-login">Sign In</button>
            </form>

            <div class="links">
                Don't have an account? <a href="register.jsp">Create One</a>
            </div>
        </div>

        <div class="art-section">
            <div class="circle-1"></div>
            <div class="circle-2"></div>

            <div class="quote-card">
                <div class="quote-text">"The only thing that you absolutely have to know, is the location of the library."</div>
                <div class="quote-author">- Albert Einstein</div>
            </div>
        </div>
    </div>

</body>
</html>