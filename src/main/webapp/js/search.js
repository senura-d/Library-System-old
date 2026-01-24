const LibrarySearch = (function () {
    const CONFIG = {
        debounceDelay: 300,
        minQueryLength: 2,
        maxSuggestions: 5,
        apiEndpoint: '/LibrarySystem/api/search',
        animationDuration: 200
    };

    let debounceTimer = null;
    let currentRequest = null;
    let selectedSuggestionIndex = -1;
    let isResultsVisible = false;

    const elements = {
        searchInput: null,
        searchContainer: null,
        resultsDropdown: null,
        suggestionsContainer: null,
        filtersContainer: null,
        loadingIndicator: null
    };

    const state = {
        query: '',
        category: '',
        author: '',
        type: '',
        status: '',
        results: [],
        suggestions: []
    };

    function init(config = {}) {
        Object.assign(CONFIG, config);

        elements.searchInput = document.getElementById('search-input');
        elements.searchContainer = document.getElementById('search-container');

        if (!elements.searchInput || !elements.searchContainer) {
            return;
        }

        createSearchComponents();
        attachEventListeners();
    }

    function createSearchComponents() {
        elements.resultsDropdown = document.createElement('div');
        elements.resultsDropdown.className = 'search-results-dropdown';
        elements.resultsDropdown.id = 'search-results-dropdown';

        elements.suggestionsContainer = document.createElement('div');
        elements.suggestionsContainer.className = 'search-suggestions';
        elements.suggestionsContainer.id = 'search-suggestions';

        const resultsContent = document.createElement('div');
        resultsContent.className = 'search-results-content';
        resultsContent.id = 'search-results-content';

        elements.loadingIndicator = document.createElement('div');
        elements.loadingIndicator.className = 'search-loading';
        elements.loadingIndicator.innerHTML = '<div class="search-spinner"></div><span>Searching...</span>';
        elements.loadingIndicator.style.display = 'none';

        elements.resultsDropdown.appendChild(elements.suggestionsContainer);
        elements.resultsDropdown.appendChild(elements.loadingIndicator);
        elements.resultsDropdown.appendChild(resultsContent);

        elements.searchContainer.style.position = 'relative';
        elements.searchContainer.appendChild(elements.resultsDropdown);

        injectStyles();
    }

    function attachEventListeners() {
        elements.searchInput.addEventListener('input', handleInput);
        elements.searchInput.addEventListener('keydown', handleKeydown);
        elements.searchInput.addEventListener('focus', handleFocus);

        document.addEventListener('click', handleClickOutside);

        const filterSelects = document.querySelectorAll('.search-filter');
        filterSelects.forEach(select => {
            select.addEventListener('change', handleFilterChange);
        });
    }

    function handleInput(e) {
        const query = e.target.value.trim();
        state.query = query;

        if (debounceTimer) {
            clearTimeout(debounceTimer);
        }

        if (query.length < CONFIG.minQueryLength) {
            hideResults();
            return;
        }

        showLoading();

        debounceTimer = setTimeout(() => {
            performSearch();
        }, CONFIG.debounceDelay);
    }

    function handleKeydown(e) {
        const suggestions = elements.suggestionsContainer.querySelectorAll('.suggestion-item');
        const results = document.querySelectorAll('.search-result-item');
        const totalItems = suggestions.length + results.length;

        switch (e.key) {
            case 'ArrowDown':
                e.preventDefault();
                selectedSuggestionIndex = Math.min(selectedSuggestionIndex + 1, totalItems - 1);
                updateSelection(suggestions, results);
                break;
            case 'ArrowUp':
                e.preventDefault();
                selectedSuggestionIndex = Math.max(selectedSuggestionIndex - 1, -1);
                updateSelection(suggestions, results);
                break;
            case 'Enter':
                e.preventDefault();
                if (selectedSuggestionIndex >= 0) {
                    if (selectedSuggestionIndex < suggestions.length) {
                        selectSuggestion(suggestions[selectedSuggestionIndex].textContent);
                    } else {
                        const resultIndex = selectedSuggestionIndex - suggestions.length;
                        if (results[resultIndex]) {
                            results[resultIndex].click();
                        }
                    }
                } else {
                    performSearch();
                }
                break;
            case 'Escape':
                hideResults();
                elements.searchInput.blur();
                break;
        }
    }

    function handleFocus() {
        if (state.query.length >= CONFIG.minQueryLength && state.results.length > 0) {
            showResults();
        }
    }

    function handleClickOutside(e) {
        if (!elements.searchContainer.contains(e.target)) {
            hideResults();
        }
    }

    function handleFilterChange(e) {
        const filterType = e.target.dataset.filter;
        state[filterType] = e.target.value;

        if (state.query.length >= CONFIG.minQueryLength) {
            performSearch();
        }
    }

    function performSearch() {
        if (currentRequest) {
            currentRequest.abort();
        }

        const params = new URLSearchParams();
        params.append('q', state.query);

        if (state.category) params.append('category', state.category);
        if (state.author) params.append('author', state.author);
        if (state.type) params.append('type', state.type);
        if (state.status) params.append('status', state.status);

        const controller = new AbortController();
        currentRequest = controller;

        showLoading();

        fetch(`${CONFIG.apiEndpoint}?${params.toString()}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            },
            signal: controller.signal
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Search request failed');
                }
                return response.json();
            })
            .then(data => {
                hideLoading();

                if (data.success) {
                    state.results = data.results || [];
                    state.suggestions = data.suggestions || [];
                    renderResults(data);
                } else {
                    renderError(data.error || 'Search failed');
                }
            })
            .catch(error => {
                if (error.name === 'AbortError') {
                    return;
                }
                hideLoading();
                renderError('Failed to connect to search service');
            });
    }

    function renderResults(data) {
        renderSuggestions(data.suggestions);

        const resultsContent = document.getElementById('search-results-content');
        resultsContent.innerHTML = '';

        if (data.results.length === 0) {
            resultsContent.innerHTML = `
                <div class="search-no-results">
                    <span class="no-results-icon">📚</span>
                    <p>No books found for "${escapeHtml(state.query)}"</p>
                    <span class="no-results-hint">Try different keywords or filters</span>
                </div>
            `;
        } else {
            const header = document.createElement('div');
            header.className = 'search-results-header';
            header.innerHTML = `<span>${data.totalCount} result${data.totalCount !== 1 ? 's' : ''}</span><span class="query-time">${data.queryTime}ms</span>`;
            resultsContent.appendChild(header);

            data.results.forEach((result, index) => {
                const resultItem = createResultItem(result, index);
                resultsContent.appendChild(resultItem);
            });
        }

        showResults();
    }

    function renderSuggestions(suggestions) {
        elements.suggestionsContainer.innerHTML = '';

        if (!suggestions || suggestions.length === 0) {
            elements.suggestionsContainer.style.display = 'none';
            return;
        }

        elements.suggestionsContainer.style.display = 'block';

        suggestions.slice(0, CONFIG.maxSuggestions).forEach((suggestion, index) => {
            const item = document.createElement('div');
            item.className = 'suggestion-item';
            item.dataset.index = index;
            item.innerHTML = `<span class="suggestion-icon">🔍</span>${escapeHtml(suggestion)}`;

            item.addEventListener('click', () => selectSuggestion(suggestion));
            item.addEventListener('mouseenter', () => {
                selectedSuggestionIndex = index;
                updateSelectionHighlight();
            });

            elements.suggestionsContainer.appendChild(item);
        });
    }

    function createResultItem(result, index) {
        const item = document.createElement('div');
        item.className = 'search-result-item';
        item.dataset.id = result.id;
        item.dataset.index = index;
        item.tabIndex = 0;

        const statusClass = result.status.toLowerCase() === 'available' ? 'status-available' : 'status-borrowed';
        const statusIcon = result.status.toLowerCase() === 'available' ? '✓' : '✗';

        item.innerHTML = `
            <div class="result-icon">📖</div>
            <div class="result-content">
                <div class="result-title">${result.highlightedTitle}</div>
                <div class="result-author">by ${result.highlightedAuthor}</div>
                <div class="result-meta">
                    <span class="result-category">${escapeHtml(result.category)}</span>
                    <span class="result-status ${statusClass}">${statusIcon} ${escapeHtml(result.status)}</span>
                </div>
            </div>
            <div class="result-action">
                <span class="view-btn">View</span>
            </div>
        `;

        item.addEventListener('click', () => handleResultClick(result));

        return item;
    }

    function handleResultClick(result) {
        hideResults();

        if (typeof window.onBookSelect === 'function') {
            window.onBookSelect(result);
        } else {
            window.location.href = `book-details?id=${result.id}`;
        }
    }

    function selectSuggestion(suggestion) {
        elements.searchInput.value = suggestion;
        state.query = suggestion;
        selectedSuggestionIndex = -1;
        performSearch();
    }

    function updateSelection(suggestions, results) {
        suggestions.forEach(s => s.classList.remove('selected'));
        results.forEach(r => r.classList.remove('selected'));

        if (selectedSuggestionIndex >= 0) {
            if (selectedSuggestionIndex < suggestions.length) {
                suggestions[selectedSuggestionIndex].classList.add('selected');
                suggestions[selectedSuggestionIndex].scrollIntoView({ block: 'nearest' });
            } else {
                const resultIndex = selectedSuggestionIndex - suggestions.length;
                if (results[resultIndex]) {
                    results[resultIndex].classList.add('selected');
                    results[resultIndex].scrollIntoView({ block: 'nearest' });
                }
            }
        }
    }

    function updateSelectionHighlight() {
        const allItems = elements.resultsDropdown.querySelectorAll('.suggestion-item, .search-result-item');
        allItems.forEach((item, index) => {
            item.classList.toggle('selected', index === selectedSuggestionIndex);
        });
    }

    function showLoading() {
        if (elements.loadingIndicator) {
            elements.loadingIndicator.style.display = 'flex';
        }
    }

    function hideLoading() {
        if (elements.loadingIndicator) {
            elements.loadingIndicator.style.display = 'none';
        }
    }

    function showResults() {
        if (elements.resultsDropdown) {
            elements.resultsDropdown.classList.add('visible');
            isResultsVisible = true;
        }
    }

    function hideResults() {
        if (elements.resultsDropdown) {
            elements.resultsDropdown.classList.remove('visible');
            isResultsVisible = false;
            selectedSuggestionIndex = -1;
        }
    }

    function renderError(message) {
        const resultsContent = document.getElementById('search-results-content');
        resultsContent.innerHTML = `
            <div class="search-error">
                <span class="error-icon">⚠️</span>
                <p>${escapeHtml(message)}</p>
            </div>
        `;
        elements.suggestionsContainer.style.display = 'none';
        showResults();
    }

    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function injectStyles() {
        if (document.getElementById('library-search-styles')) return;

        const styles = document.createElement('style');
        styles.id = 'library-search-styles';
        styles.textContent = `
            .search-results-dropdown {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: #383838;
                border-radius: 20px;
                box-shadow: 0 25px 80px rgba(0, 0, 0, 0.5);
                margin-top: 12px;
                max-height: 500px;
                overflow-y: auto;
                opacity: 0;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.3s ease;
                z-index: 1000;
                border: 1px solid rgba(255, 255, 255, 0.05);
                font-family: 'Poppins', sans-serif;
            }

            .search-results-dropdown.visible {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .search-results-dropdown::-webkit-scrollbar {
                width: 6px;
            }

            .search-results-dropdown::-webkit-scrollbar-track {
                background: transparent;
            }

            .search-results-dropdown::-webkit-scrollbar-thumb {
                background: rgba(255, 255, 255, 0.15);
                border-radius: 3px;
            }

            .search-results-dropdown::-webkit-scrollbar-thumb:hover {
                background: rgba(255, 255, 255, 0.25);
            }

            .search-suggestions {
                border-bottom: 1px solid rgba(255, 255, 255, 0.08);
                padding: 10px 0;
            }

            .suggestion-item {
                padding: 14px 24px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 14px;
                color: #AAAAAA;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .suggestion-item:hover,
            .suggestion-item.selected {
                background: rgba(74, 144, 226, 0.12);
                color: #4A90E2;
            }

            .suggestion-icon {
                opacity: 0.7;
                font-size: 16px;
            }

            .search-loading {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 14px;
                padding: 30px;
                color: #AAAAAA;
                font-size: 14px;
                font-weight: 500;
            }

            .search-spinner {
                width: 22px;
                height: 22px;
                border: 3px solid rgba(74, 144, 226, 0.2);
                border-top-color: #4A90E2;
                border-radius: 50%;
                animation: searchSpin 0.8s linear infinite;
            }

            @keyframes searchSpin {
                to { transform: rotate(360deg); }
            }

            .search-results-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 14px 24px;
                font-size: 11px;
                color: #AAAAAA;
                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                text-transform: uppercase;
                letter-spacing: 1px;
                font-weight: 600;
            }

            .query-time {
                color: #4A90E2;
                font-weight: 700;
            }

            .search-result-item {
                display: flex;
                align-items: center;
                gap: 18px;
                padding: 18px 24px;
                cursor: pointer;
                transition: all 0.2s ease;
                border-bottom: 1px solid rgba(255, 255, 255, 0.03);
            }

            .search-result-item:last-child {
                border-bottom: none;
            }

            .search-result-item:hover,
            .search-result-item.selected {
                background: rgba(74, 144, 226, 0.08);
            }

            .result-icon {
                width: 52px;
                height: 52px;
                background: linear-gradient(135deg, #595959 0%, #2b2b2b 100%);
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                flex-shrink: 0;
            }

            .result-content {
                flex: 1;
                min-width: 0;
            }

            .result-title {
                font-size: 15px;
                font-weight: 700;
                color: #FFFFFF;
                margin-bottom: 5px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .result-title mark {
                background: rgba(74, 144, 226, 0.25);
                color: #4A90E2;
                padding: 1px 4px;
                border-radius: 4px;
                font-weight: 700;
            }

            .result-author {
                font-size: 12px;
                color: #AAAAAA;
                margin-bottom: 10px;
                font-weight: 500;
            }

            .result-author mark {
                background: rgba(74, 144, 226, 0.2);
                color: #4A90E2;
                padding: 1px 4px;
                border-radius: 4px;
            }

            .result-meta {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .result-category {
                font-size: 11px;
                padding: 5px 12px;
                background: rgba(255, 255, 255, 0.06);
                border-radius: 50px;
                color: #AAAAAA;
                font-weight: 600;
            }

            .result-status {
                font-size: 11px;
                padding: 5px 12px;
                border-radius: 50px;
                font-weight: 700;
            }

            .status-available {
                background: rgba(26, 188, 156, 0.15);
                color: #1ABC9C;
            }

            .status-borrowed {
                background: rgba(231, 76, 60, 0.15);
                color: #E74C3C;
            }

            .result-action {
                flex-shrink: 0;
            }

            .view-btn {
                padding: 10px 20px;
                background: transparent;
                border: 1px solid #4A90E2;
                color: #4A90E2;
                border-radius: 10px;
                font-size: 13px;
                font-weight: 600;
                transition: all 0.3s ease;
                font-family: 'Poppins', sans-serif;
            }

            .search-result-item:hover .view-btn {
                background: #4A90E2;
                color: #FFFFFF;
                box-shadow: 0 8px 20px rgba(74, 144, 226, 0.25);
            }

            .search-no-results,
            .search-error {
                padding: 50px 24px;
                text-align: center;
                color: #AAAAAA;
            }

            .no-results-icon,
            .error-icon {
                font-size: 56px;
                display: block;
                margin-bottom: 18px;
                opacity: 0.6;
            }

            .search-no-results p,
            .search-error p {
                font-size: 15px;
                font-weight: 600;
                margin: 0;
            }

            .no-results-hint {
                font-size: 13px;
                color: #888888;
                margin-top: 10px;
                display: block;
                font-weight: 400;
            }

            .search-error {
                color: #E74C3C;
            }
        `;

        document.head.appendChild(styles);
    }

    function setFilter(filterType, value) {
        if (state.hasOwnProperty(filterType)) {
            state[filterType] = value;
            if (state.query.length >= CONFIG.minQueryLength) {
                performSearch();
            }
        }
    }

    function clearFilters() {
        state.category = '';
        state.author = '';
        state.type = '';
        state.status = '';

        document.querySelectorAll('.search-filter').forEach(select => {
            select.value = '';
        });

        if (state.query.length >= CONFIG.minQueryLength) {
            performSearch();
        }
    }

    function getState() {
        return { ...state };
    }

    return {
        init: init,
        setFilter: setFilter,
        clearFilters: clearFilters,
        getState: getState,
        search: performSearch
    };
})();

document.addEventListener('DOMContentLoaded', function () {
    LibrarySearch.init();
});
