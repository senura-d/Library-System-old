<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Search Books - UpBooks</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #4D4D4D;
                color: white;
                display: flex;
                height: 100vh;
                overflow: hidden;
            }

            .sidebar {
                width: 260px;
                background-color: #383838;
                display: flex;
                flex-direction: column;
                padding: 30px;
                border-right: 1px solid rgba(255, 255, 255, 0.05);
            }

            .logo {
                font-size: 24px;
                font-weight: 800;
                color: white;
                margin-bottom: 50px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo span {
                color: #4A90E2;
            }

            .menu-item {
                text-decoration: none;
                color: #AAAAAA;
                padding: 15px;
                margin-bottom: 10px;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
                display: flex;
                align-items: center;
                transition: 0.3s;
            }

            .menu-item:hover {
                background: rgba(255, 255, 255, 0.05);
                color: white;
            }

            .menu-item.active {
                background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
                color: white;
                box-shadow: 0 10px 20px rgba(74, 144, 226, 0.2);
            }

            .menu-icon {
                margin-right: 15px;
                font-size: 18px;
            }

            .user-profile {
                margin-top: auto;
                display: flex;
                align-items: center;
                gap: 15px;
                padding-top: 20px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .avatar {
                width: 40px;
                height: 40px;
                background: #1ABC9C;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }

            .main-content {
                flex: 1;
                padding: 40px;
                overflow-y: auto;
            }

            .page-header {
                margin-bottom: 40px;
            }

            .page-header h1 {
                font-size: 32px;
                font-weight: 800;
                margin-bottom: 10px;
            }

            .page-header p {
                color: #AAAAAA;
                font-size: 15px;
            }

            .search-section {
                background: #383838;
                border-radius: 24px;
                padding: 30px;
                border: 1px solid rgba(255, 255, 255, 0.05);
                margin-bottom: 30px;
            }

            .search-wrapper {
                position: relative;
            }

            .search-input-container {
                display: flex;
                align-items: center;
                background: #4D4D4D;
                border-radius: 50px;
                padding: 16px 24px;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .search-input-container:focus-within {
                border-color: #4A90E2;
                box-shadow: 0 0 0 4px rgba(74, 144, 226, 0.15);
            }

            .search-input-container .search-icon {
                font-size: 20px;
                margin-right: 14px;
                color: #888;
            }

            #search-input {
                flex: 1;
                background: transparent;
                border: none;
                color: white;
                font-size: 16px;
                font-weight: 500;
                outline: none;
            }

            #search-input::placeholder {
                color: #888;
            }

            .search-filters {
                display: flex;
                gap: 14px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .search-filter {
                padding: 12px 20px;
                background: #4D4D4D;
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 50px;
                color: #fff;
                font-size: 13px;
                font-family: 'Poppins', sans-serif;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                appearance: none;
                -webkit-appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23888' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 18px center;
                padding-right: 45px;
            }

            .search-filter:hover {
                border-color: #4A90E2;
            }

            .search-filter:focus {
                outline: none;
                border-color: #4A90E2;
                box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
            }

            .search-filter option {
                background: #383838;
                color: #fff;
                padding: 10px;
            }

            .clear-filters-btn {
                padding: 12px 24px;
                background: transparent;
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 50px;
                color: #AAAAAA;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                font-family: 'Poppins', sans-serif;
            }

            .clear-filters-btn:hover {
                border-color: #E74C3C;
                color: #E74C3C;
            }

            .results-section {
                background: #383838;
                border-radius: 24px;
                padding: 30px;
                border: 1px solid rgba(255, 255, 255, 0.05);
                min-height: 400px;
            }

            .results-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
                padding-bottom: 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            }

            .results-title {
                font-size: 18px;
                font-weight: 700;
            }

            .results-count {
                color: #AAAAAA;
                font-size: 14px;
            }

            .results-count span {
                color: #4A90E2;
                font-weight: 700;
            }

            .results-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 20px;
            }

            .result-card {
                background: #4D4D4D;
                border-radius: 20px;
                padding: 24px;
                transition: all 0.3s ease;
                border: 1px solid rgba(255, 255, 255, 0.05);
                cursor: pointer;
            }

            .result-card:hover {
                transform: translateY(-5px);
                background: #555555;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
                border-color: #4A90E2;
            }

            .result-card-cover {
                height: 120px;
                background: linear-gradient(135deg, #595959 0%, #2b2b2b 100%);
                border-radius: 14px;
                margin-bottom: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 42px;
            }

            .result-card-title {
                font-size: 16px;
                font-weight: 700;
                margin-bottom: 6px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .result-card-title mark {
                background: rgba(74, 144, 226, 0.25);
                color: #4A90E2;
                padding: 1px 4px;
                border-radius: 4px;
            }

            .result-card-author {
                font-size: 13px;
                color: #AAAAAA;
                margin-bottom: 14px;
            }

            .result-card-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .result-card-category {
                font-size: 11px;
                padding: 6px 14px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50px;
                color: #AAAAAA;
                font-weight: 600;
            }

            .result-card-status {
                font-size: 11px;
                padding: 6px 14px;
                border-radius: 50px;
                font-weight: 700;
            }

            .result-card-status.available {
                background: rgba(26, 188, 156, 0.15);
                color: #1ABC9C;
            }

            .result-card-status.borrowed {
                background: rgba(231, 76, 60, 0.15);
                color: #E74C3C;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #AAAAAA;
            }

            .empty-state-icon {
                font-size: 64px;
                margin-bottom: 20px;
                opacity: 0.5;
            }

            .empty-state h3 {
                font-size: 20px;
                font-weight: 700;
                margin-bottom: 10px;
                color: white;
            }

            .empty-state p {
                font-size: 14px;
            }

            .loading-state {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 60px 20px;
                color: #AAAAAA;
            }

            .loading-spinner {
                width: 40px;
                height: 40px;
                border: 4px solid rgba(74, 144, 226, 0.2);
                border-top-color: #4A90E2;
                border-radius: 50%;
                animation: spin 0.8s linear infinite;
                margin-bottom: 16px;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            .keyboard-hints {
                display: flex;
                gap: 16px;
                margin-top: 16px;
                justify-content: center;
            }

            .keyboard-hint {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 12px;
                color: #888;
            }

            .keyboard-hint kbd {
                background: #4D4D4D;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 11px;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }
        </style>
    </head>

    <body>

        <div class="sidebar">
            <div class="logo">Up<span>Books</span></div>

            <a href="member_dashboard.jsp" class="menu-item">
                <span class="menu-icon">🏠</span> Browse Books
            </a>
            <a href="search.jsp" class="menu-item active">
                <span class="menu-icon">🔍</span> Search
            </a>
            <a href="#" class="menu-item">
                <span class="menu-icon">📖</span> My Loans
            </a>
            <a href="#" class="menu-item">
                <span class="menu-icon">🔖</span> Favorites
            </a>
            <a href="#" class="menu-item">
                <span class="menu-icon">⚙️</span> Settings
            </a>

            <div class="user-profile">
                <div class="avatar">S</div>
                <div style="font-size: 14px;">
                    <div style="font-weight: 600;">Student</div>
                    <div style="font-size: 11px; color: #888;">Online</div>
                </div>
                <a href="login.jsp"
                    style="margin-left: auto; color: #e74c3c; text-decoration: none; font-size: 12px;">Logout</a>
            </div>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>🔍 Search Books</h1>
                <p>Find your next great read from our extensive collection</p>
            </div>

            <div class="search-section">
                <div class="search-wrapper" id="search-container">
                    <div class="search-input-container">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="search-input" placeholder="Search by title, author, or category..."
                            autocomplete="off">
                    </div>
                </div>

                <div class="search-filters">
                    <select class="search-filter" data-filter="category" id="filter-category">
                        <option value="">All Categories</option>
                        <option value="Fiction">Fiction</option>
                        <option value="Non-Fiction">Non-Fiction</option>
                        <option value="Science">Science</option>
                        <option value="Technology">Technology</option>
                        <option value="History">History</option>
                        <option value="Biography">Biography</option>
                        <option value="Self-Help">Self-Help</option>
                        <option value="Romance">Romance</option>
                        <option value="Mystery">Mystery</option>
                    </select>
                    <select class="search-filter" data-filter="status" id="filter-status">
                        <option value="">All Status</option>
                        <option value="Available">Available Only</option>
                        <option value="Borrowed">Borrowed</option>
                    </select>
                    <button class="clear-filters-btn" id="clear-filters">Clear Filters</button>
                </div>

                <div class="keyboard-hints">
                    <div class="keyboard-hint"><kbd>↑</kbd><kbd>↓</kbd> Navigate</div>
                    <div class="keyboard-hint"><kbd>Enter</kbd> Select</div>
                    <div class="keyboard-hint"><kbd>Esc</kbd> Close</div>
                </div>
            </div>

            <div class="results-section">
                <div class="results-header">
                    <div class="results-title">Search Results</div>
                    <div class="results-count" id="results-count"></div>
                </div>

                <div id="results-container">
                    <div class="empty-state" id="empty-state">
                        <div class="empty-state-icon">📚</div>
                        <h3>Start searching</h3>
                        <p>Type at least 2 characters to search for books</p>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/search.js"></script>
        <script>
            const resultsContainer = document.getElementById('results-container');
            const resultsCount = document.getElementById('results-count');
            const emptyState = document.getElementById('empty-state');
            const clearFiltersBtn = document.getElementById('clear-filters');

            LibrarySearch.init({
                apiEndpoint: 'api/search'
            });

            window.onBookSelect = function (book) {
                window.location.href = 'book-details?id=' + book.id;
            };

            clearFiltersBtn.addEventListener('click', function () {
                document.getElementById('filter-category').value = '';
                document.getElementById('filter-status').value = '';
                LibrarySearch.clearFilters();
            });

            const originalRenderResults = function (data) {
                resultsContainer.innerHTML = '';

                if (!data || !data.results || data.results.length === 0) {
                    resultsCount.innerHTML = '';
                    resultsContainer.innerHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon">📚</div>
                        <h3>No books found</h3>
                        <p>Try different keywords or adjust your filters</p>
                    </div>
                `;
                    return;
                }

                resultsCount.innerHTML = '<span>' + data.totalCount + '</span> results found in <span>' + data.queryTime + 'ms</span>';

                const grid = document.createElement('div');
                grid.className = 'results-grid';

                data.results.forEach(function (book) {
                    const card = document.createElement('div');
                    card.className = 'result-card';
                    card.onclick = function () {
                        window.onBookSelect(book);
                    };

                    const statusClass = book.status.toLowerCase() === 'available' ? 'available' : 'borrowed';

                    card.innerHTML =
                        '<div class="result-card-cover">📖</div>' +
                        '<div class="result-card-title">' + book.highlightedTitle + '</div>' +
                        '<div class="result-card-author">by ' + book.highlightedAuthor + '</div>' +
                        '<div class="result-card-meta">' +
                        '<span class="result-card-category">' + escapeHtml(book.category) + '</span>' +
                        '<span class="result-card-status ' + statusClass + '">' + escapeHtml(book.status) + '</span>' +
                        '</div>';

                    grid.appendChild(card);
                });

                resultsContainer.appendChild(grid);
            };

            function escapeHtml(text) {
                if (!text) return '';
                const div = document.createElement('div');
                div.textContent = text;
                return div.innerHTML;
            }

            const searchInput = document.getElementById('search-input');
            let debounceTimer = null;

            searchInput.addEventListener('input', function () {
                const query = this.value.trim();

                if (debounceTimer) clearTimeout(debounceTimer);

                if (query.length < 2) {
                    resultsCount.innerHTML = '';
                    resultsContainer.innerHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon">📚</div>
                        <h3>Start searching</h3>
                        <p>Type at least 2 characters to search for books</p>
                    </div>
                `;
                    return;
                }

                resultsContainer.innerHTML = `
                <div class="loading-state">
                    <div class="loading-spinner"></div>
                    <p>Searching...</p>
                </div>
            `;

                debounceTimer = setTimeout(function () {
                    const category = document.getElementById('filter-category').value;
                    const status = document.getElementById('filter-status').value;

                    const params = new URLSearchParams();
                    params.append('q', query);
                    if (category) params.append('category', category);
                    if (status) params.append('status', status);

                    fetch('api/search?' + params.toString())
                        .then(function (response) { return response.json(); })
                        .then(function (data) {
                            if (data.success) {
                                originalRenderResults(data);
                            } else {
                                resultsContainer.innerHTML = `
                                <div class="empty-state">
                                    <div class="empty-state-icon">⚠️</div>
                                    <h3>Search Error</h3>
                                    <p>${escapeHtml(data.error)}</p>
                                </div>
                            `;
                            }
                        })
                        .catch(function (error) {
                            resultsContainer.innerHTML = `
                            <div class="empty-state">
                                <div class="empty-state-icon">⚠️</div>
                                <h3>Connection Error</h3>
                                <p>Unable to connect to the search service</p>
                            </div>
                        `;
                        });
                }, 300);
            });

            document.querySelectorAll('.search-filter').forEach(function (select) {
                select.addEventListener('change', function () {
                    if (searchInput.value.trim().length >= 2) {
                        searchInput.dispatchEvent(new Event('input'));
                    }
                });
            });
        </script>
    </body>

    </html>