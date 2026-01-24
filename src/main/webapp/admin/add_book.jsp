<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Book</title>
    <style>
        body { font-family: sans-serif; padding: 30px; background-color: #f4f4f4; }
        .form-container { background: white; padding: 30px; border-radius: 8px; width: 400px; margin: 0 auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        input, select { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }
        button { width: 100%; padding: 10px; background-color: #27ae60; color: white; border: none; font-weight: bold; cursor: pointer; }
        button:hover { background-color: #219150; }
        a { text-decoration: none; color: #555; display: block; text-align: center; margin-top: 15px; }
    </style>
</head>
<body>

    <div class="form-container">
        <h2 style="text-align: center;">Add New Book</h2>

        <%-- Show Success Message --%>
        <% if(request.getParameter("msg") != null) { %>
            <p style="color: green; text-align: center;">Book Added Successfully!</p>
        <% } %>

        <form action="../add-book" method="post">
            <label>Book Title</label>
            <input type="text" name="title" required>

            <label>Author</label>
            <input type="text" name="author" required>

            <label>Category</label>
            <select name="category">
                <option value="Fiction">Fiction</option>
                <option value="Science">Science</option>
                <option value="History">History</option>
                <option value="Technology">Technology</option>
                <option value="Education">Education</option>
            </select>

            <button type="submit">Save Book</button>
        </form>

        <a href="../dashboard">← Back to Dashboard</a>
    </div>

</body>
</html>