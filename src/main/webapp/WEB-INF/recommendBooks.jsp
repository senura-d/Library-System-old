<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Recommended Books</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recommend.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f9f9f9; padding: 20px; }
        .book-container { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; }
        .book-card {
            background: white; width: 200px; padding: 15px;
            border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .book-card:hover { transform: translateY(-5px); }
        .book-title { font-size: 16px; font-weight: bold; margin-bottom: 5px; color: #333; }
        .book-meta { font-size: 13px; color: #666; }
        .status-badge {
            display: inline-block; padding: 4px 8px; border-radius: 12px;
            font-size: 11px; margin-top: 10px; font-weight: bold;
        }
        .available { background: #d1fae5; color: #065f46; }
        .unavailable { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>

<h2 style="text-align: center; margin-bottom: 30px;">Recommended For You</h2>

<div style="text-align: center; margin-bottom: 30px;">
    <a href="recommendations" style="margin: 0 10px; text-decoration: none; color: #667eea;">All</a>
    <a href="recommendations?category=Programming" style="margin: 0 10px; text-decoration: none; color: #667eea;">Programming</a>
    <a href="recommendations?category=Web" style="margin: 0 10px; text-decoration: none; color: #667eea;">Web</a>
</div>

<div class="book-container">
    <c:if test="${not empty recommendedBooks}">
        <c:forEach var="book" items="${recommendedBooks}">
            <div class="book-card">
                <div class="book-title">${book.title}</div>
                <div class="book-meta">by ${book.author}</div>
                <div class="book-meta">${book.category}</div>

                <div>
                    <c:choose>
                        <c:when test="${book.available}">
                            <span class="status-badge available">Available</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge unavailable">Out of Stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <c:if test="${empty recommendedBooks}">
        <p>No available books to recommend in this category.</p>
    </c:if>
</div>

</body>
</html>