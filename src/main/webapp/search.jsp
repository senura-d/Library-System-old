<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Books - Library System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .search-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }

        .search-box {
            position: relative;
            margin-bottom: 25px;
        }

        .search-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .search-icon {
            position: absolute;
            left: 20px;
            width: 24px;
            height: 24px;
            fill: #667eea;
        }

        #searchInput {
            width: 100%;
            padding: 18px 20px 18px 55px;
            font-size: 1.1rem;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            outline: none;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        #searchInput:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        #searchInput::placeholder {
            color: #aaa;
        }

        .filters {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            font-size: 0.85rem;
            font-weight: 500;
            color: #555;
            margin-bottom: 6px;
        }

        .filter-group select,
        .filter-group input {
            padding: 12px 15px;
            font-size: 0.95rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            outline: none;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
            background: white;
        }

        .filter-group select:focus,
        .filter-group input:focus {
            border-color: #667eea;
        }

        #searchResults {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            max-height: 400px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
            margin-top: 10px;
            border: 1px solid #e0e0e0;
        }

        #searchResults.active {
            display: block;
        }

        .search-result-item {
            padding: 15px 20px;
            cursor: pointer;
            border-bottom: 1px solid #f0f0f0;
            transition: all 0.2s ease;
        }

        .search-result-item:last-child {
            border-bottom: none;
        }

        .search-result-item:hover,
        .search-result-item.highlighted {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
        }

        .result-title {
            font-weight: 600;
            font-size: 1rem;
            color: #333;
            margin-bottom: 5px;
        }

        .result-meta {
            font-size: 0.85rem;
            color: #777;
        }

        .result-meta span {
            display: inline;
        }

        .result-separator {
            color: #ccc;
        }

        .result-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
            margin-top: 8px;
        }

        .status-available {
            background: #d4edda;
            color: #155724;
        }

        .status-unavailable {
            background: #f8d7da;
            color: #721c24;
        }

        .search-no-results,
        .search-error {
            padding: 30px 20px;
            text-align: center;
            color: #777;
        }

        .search-error {
            color: #dc3545;
        }

        .search-loading {
            padding: 20px;
            text-align: center;
            color: #667eea;
        }

        .loading-spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid #667eea;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 0.8s linear infinite;
            margin-right: 8px;
            vertical-align: middle;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .tips {
            margin-top: 30px;
            padding: 20px;
            background: rgba(102, 126, 234, 0.08);
            border-radius: 12px;
        }

        .tips h3 {
            font-size: 1rem;
            color: #667eea;
            margin-bottom: 10px;
        }

        .tips ul {
            list-style: none;
            padding: 0;
        }

        .tips li {
            font-size: 0.9rem;
            color: #555;
            padding: 5px 0;
            padding-left: 20px;
            position: relative;
        }

        .tips li::before {
            content: '→';
            position: absolute;
            left: 0;
            color: #667eea;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            opacity: 0.9;
            transition: opacity 0.3s;
        }

        .back-link:hover {
            opacity: 1;
        }

        @media (max-width: 600px) {
            .header h1 {
                font-size: 1.8rem;
            }

            .filters {
                grid-template-columns: 1fr;
            }

            .search-container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Search Books</h1>
            <p>Find books by title, author, or category</p>
        </div>

        <div class="search-container">
            <div class="search-box">
                <div class="search-input-wrapper">
                    <svg class="search-icon" viewBox="0 0 24 24">
                        <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                    </svg>
                    <input type="text" id="searchInput" placeholder="Start typing to search books..." autocomplete="off">
                </div>
                <div id="searchResults"></div>
            </div>

            <div class="filters">
                <div class="filter-group">
                    <label for="categoryFilter">Category</label>
                    <select id="categoryFilter">
                        <option value="all">All Categories</option>
                        <option value="fiction">Fiction</option>
                        <option value="non-fiction">Non-Fiction</option>
                        <option value="science">Science</option>
                        <option value="technology">Technology</option>
                        <option value="history">History</option>
                        <option value="biography">Biography</option>
                        <option value="self-help">Self-Help</option>
                        <option value="romance">Romance</option>
                        <option value="mystery">Mystery</option>
                        <option value="fantasy">Fantasy</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="authorFilter">Author</label>
                    <input type="text" id="authorFilter" placeholder="Filter by author name...">
                </div>

                <div class="filter-group">
                    <label for="typeFilter">Type</label>
                    <select id="typeFilter">
                        <option value="all">All Types</option>
                        <option value="book">Book</option>
                        <option value="ebook">E-Book</option>
                        <option value="audiobook">Audiobook</option>
                        <option value="magazine">Magazine</option>
                        <option value="journal">Journal</option>
                    </select>
                </div>
            </div>

            <div class="tips">
                <h3>Search Tips</h3>
                <ul>
                    <li>Type at least 2 characters to start searching</li>
                    <li>Use filters to narrow down your results</li>
                    <li>Press Enter for immediate search</li>
                    <li>Use arrow keys to navigate results</li>
                    <li>Press Escape to close search results</li>
                </ul>
            </div>
        </div>

        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>

    <script src="js/search.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            SearchModule.init({
                searchInputId: 'searchInput',
                resultsContainerId: 'searchResults',
                categoryFilterId: 'categoryFilter',
                authorFilterId: 'authorFilter',
                typeFilterId: 'typeFilter',
                debounceDelay: 300,
                minSearchLength: 2
            });

            document.addEventListener('searchResultSelected', function(e) {
                console.log('Selected book:', e.detail);
            });
        });
    </script>
</body>
</html>
