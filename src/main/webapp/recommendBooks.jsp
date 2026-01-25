<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Recommended Books</title>
    <link rel="stylesheet" href="css/recommend.css">
    <link rel="stylesheet" href="css/index.css">


    <style>
        body { font-family: Arial; background: #f9f9f9; margin: 20px; }
        .book-card { border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; border-radius: 5px; background: #fff; }
        .book-card h3 { margin: 0 0 5px 0; }
        .book-card p { margin: 0; }
    </style>
</head>
<body>
<h2>Recommended Books</h2>

<c:if test="${not empty recommendedBooks}">
    <c:forEach var="book" items="${recommendedBooks}">
        <div class="book-card">
            <h3>${book.title}</h3>
            <p>Available: <c:choose>
                <c:when test="${book.available}">Yes</c:when>
                <c:otherwise>No</c:otherwise>
            </c:choose></p>
        </div>
    </c:forEach>
</c:if>

<c:if test="${empty recommendedBooks}">
    <p>No available books to recommend.</p>
</c:if>

</body>
</html>
