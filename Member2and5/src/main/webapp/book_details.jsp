<h2>${book.title}</h2>
<p>Author: ${book.author}</p>
<p>Category: ${book.category}</p>

<c:choose>
    <c:when test="${book.available}">
        <span style="color:green">Available</span>
    </c:when>
    <c:otherwise>
        <span style="color:red">Not Available</span>
    </c:otherwise>
</c:choose>
