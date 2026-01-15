<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Library Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); /* Purple/Blue gradient */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box; /* Keeps padding inside width */
            font-size: 14px;
            transition: 0.3s;
        }
        input:focus {
            border-color: #764ba2;
            outline: none;
            box-shadow: 0 0 5px rgba(118, 75, 162, 0.3);
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #764ba2;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
            transition: background 0.3s;
        }
        button:hover {
            background-color: #5a367f;
        }
        .footer {
            margin-top: 15px;
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Student Sign Up</h2>

    <form action="register" method="post">
        <input type="text" name="fullname" required placeholder="Full Name" autocomplete="off">
        <input type="text" name="sid" required placeholder="Student ID (e.g., S-101)">
        <input type="email" name="email" required placeholder="Email Address">
        <input type="password" name="password" required placeholder="Password">

        <button type="submit">Create Account</button>
    </form>

    <div class="footer">Library Management System 2026</div>
</div>

</body>
</html>