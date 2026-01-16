<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Security: Redirect to login if no session
    if (session.getAttribute("memberEmail") == null) {
        response.sendRedirect("login.jsp?error=Please Login First");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Books - MyLibrary</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        /* --- GLOBAL & DARK THEME --- */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background-color: #1e1e1e; color: #ecf0f1; display: flex; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }

        /* --- SIDEBAR (Same as Dashboard) --- */
        .sidebar {
            width: 260px;
            background: #252525;
            padding: 30px;
            border-right: 1px solid #333;
            display: flex;
            flex-direction: column;
            position: fixed; /* Fixed sidebar */
            height: 100vh;
        }

        .brand { font-size: 22px; font-weight: 700; color: white; margin-bottom: 50px; display: flex; align-items: center; gap: 10px; }
        .brand span { color: #667eea; }

        .menu-item {
            text-decoration: none; color: #95a5a6; padding: 15px; margin-bottom: 10px;
            border-radius: 8px; font-weight: 600; display: flex; align-items: center; transition: 0.3s;
        }
        .menu-item:hover { background: rgba(102, 126, 234, 0.1); color: #667eea; }
        .menu-item.active { background: #667eea; color: white; box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3); }
        .menu-icon { margin-right: 15px; }

        /* --- MAIN CONTENT --- */
        .main-content {
            margin-left: 260px; /* Offset for fixed sidebar */
            flex: 1;
            padding: 40px;
            width: calc(100% - 260px);
        }

        .page-header { margin-bottom: 30px; }
        .page-header h1 { font-size: 28px; font-weight: 700; }
        .page-header p { color: #7f8c8d; }

        /* --- SEARCH CONTAINER --- */
        .search-container {
            background: #2d2d2d;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            margin-bottom: 30px;
            border-top: 4px solid #667eea;
        }

        /* Search Inputs Grid */
        .filters-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 15px;
            align-items: end;
        }

        .input-group { display: flex; flex-direction: column; gap: 8px; }
        .input-group label { font-size: 12px; font-weight: 600; color: #95a5a6; text-transform: uppercase; }

        input, select {
            background: #383838;
            border: 1px solid #444;
            color: white;
            padding: 12px 15px;
            border-radius: 8px;
            outline: none;
            font-size: 14px;
            transition: 0.3s;
        }
        input:focus, select:focus { border-color: #667eea; background: #404040; }

        .btn-search {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            height: 45px;
            transition: 0.3s;
        }
        .btn-search:hover { background: #5a6fd6; transform: translateY(-2px); }

        /* --- RESULTS AREA --- */
        .results-area { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }

        .book-card {
            background: #2d2d2d;
            padding: 20px;
            border-radius: 12px;
            border: 1px solid #333;
            transition: 0.3s;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .book-card:hover { transform: translateY(-5px); border-color: #667eea; }

        .book-title { font-size: 16px; font-weight: 700; color: white; }
        .book-author { font-size: 13px; color: #95a5a6; }
        .book-meta { display: flex; justify-content: space-between; align-items: center; margin-top: auto; padding-top: 15px; border-top: 1px solid #3d3d3d; }

        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-avail { background: rgba(46, 204, 113, 0.2); color: #2ecc71; }
        .badge-issued { background: rgba(231, 76, 60, 0.2); color: #e74c3c; }

        .btn-action {
            font-size: 12px;
            color: #667eea;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-action:hover { text-decoration: underline; }

        /* Loading & Empty States */
        .status-msg { grid-column: 1 / -1; text-align: center; padding: 40px; color: #7f8c8d; }

        /* Responsive */
        @media (max-width: 768px) {
            .filters-grid { grid-template-columns: 1fr; }
            .sidebar { width: 70px; padding: 20px 10px; }
            .brand span, .menu-item span:last-child { display: none; } /* Hide text, keep icons */
            .main-content { margin-left: 70px; width: calc(100% - 70px); }
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="brand">📚 My<span>Library</span></div>

        <a href="member-dashboard" class="menu-item">
            <span class="menu-icon">🏠</span> Dashboard
        </a>

        <a href="search.jsp" class="menu-item active">
            <span class="menu-icon">🔍</span> Search Books
        </a>

        <a href="#" class="menu-item">
            <span class="menu-icon">📖</span> My Books
        </a>

        <a href="#" class="menu-item">
            <span class="menu-icon">🔖</span> Wishlist
        </a>

        <div style="margin-top: auto; padding-top: 20px; border-top: 1px solid #333;">
             <a href="profile.jsp" style="display: flex; align-items: center; gap: 10px; color: #ecf0f1;">
                <div style="width: 30px; height: 30px; background: #667eea; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold;">
                    <%= session.getAttribute("memberName") != null ? session.getAttribute("memberName").toString().substring(0,1) : "U" %>
                </div>
                <span style="font-size: 13px;">Profile</span>
             </a>
        </div>
    </div>

    <div class="main-content">

        <div class="page-header">
            <h1>Search Books</h1>
            <p>Find your next read from our collection.</p>
        </div>

        <div class="search-container">
            <div class="filters-grid">

                <div class="input-group">
                    <label>Title or Keyword</label>
                    <input type="text" id="searchInput" placeholder="Harry Potter..." value="<%= request.getParameter("q") != null ? request.getParameter("q") : "" %>">
                </div>

                <div class="input-group">
                    <label>Author</label>
                    <input type="text" id="authorInput" placeholder="J.K. Rowling">
                </div>

                <div class="input-group">
                    <label>Category</label>
                    <select id="categoryInput">
                        <option value="all">All Categories</option>
                        <option value="Fiction">Fiction</option>
                        <option value="Science">Science</option>
                        <option value="History">History</option>
                        <option value="Technology">Technology</option>
                    </select>
                </div>

                <button onclick="performSearch()" class="btn-search">Search</button>
            </div>
        </div>

        <div id="resultsArea" class="results-area">
            <div class="status-msg">Enter a keyword to start searching...</div>
        </div>

        <div style="margin-top: 30px;">
            <a href="member-dashboard" style="color: #95a5a6; font-size: 13px;">← Back to Dashboard</a>
        </div>

    </div>

    <script>
        // Trigger search if URL has params (e.g. coming from Dashboard)
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const query = urlParams.get('q');
            if(query) {
                document.getElementById('searchInput').value = query;
                performSearch();
            }
        };

        // Allow "Enter" key to search
        document.getElementById("searchInput").addEventListener("keyup", function(event) {
            if (event.key === "Enter") performSearch();
        });

        function performSearch() {
            const query = document.getElementById('searchInput').value;
            const author = document.getElementById('authorInput').value;
            const category = document.getElementById('categoryInput').value;
            const resultsDiv = document.getElementById('resultsArea');

            if (!query && !author) {
                resultsDiv.innerHTML = '<div class="status-msg">Please enter a title or author.</div>';
                return;
            }

            resultsDiv.innerHTML = '<div class="status-msg">Searching... ⏳</div>';

            // Build API URL
            let url = 'search?q=' + encodeURIComponent(query);
            if (author) url += '&author=' + encodeURIComponent(author);
            if (category && category !== 'all') url += '&category=' + encodeURIComponent(category);

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    resultsDiv.innerHTML = ''; // Clear loading

                    if (data.results.length === 0) {
                        resultsDiv.innerHTML = '<div class="status-msg">No books found matching your criteria. 😕</div>';
                        return;
                    }

                    // Loop through results and create cards
                    data.results.forEach(book => {
                        const isAvailable = book.status && book.status.toLowerCase() === 'available';
                        const badgeClass = isAvailable ? 'badge-avail' : 'badge-issued';

                        const card = `
                            <div class="book-card">
                                <div class="book-title">\${book.title}</div>
                                <div class="book-author">by \${book.author}</div>
                                <div style="font-size: 12px; color: #7f8c8d; margin-top: 5px;">\${book.category}</div>
                                <div class="book-meta">
                                    <span class="badge \${badgeClass}">\${book.status}</span>
                                    <span class="btn-action">Details →</span>
                                </div>
                            </div>
                        `;
                        resultsDiv.innerHTML += card;
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    resultsDiv.innerHTML = '<div class="status-msg" style="color: #e74c3c;">Something went wrong. Try again.</div>';
                });
        }
    </script>
</body>
</html>