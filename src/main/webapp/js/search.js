var SearchModule = (function() {
    var searchTimeout = null;
    var debounceDelay = 300;
    var minSearchLength = 2;
    var searchEndpoint = 'search';
    var resultsContainer = null;
    var searchInput = null;
    var categoryFilter = null;
    var authorFilter = null;
    var typeFilter = null;
    var isLoading = false;

    function init(config) {
        searchInput = document.getElementById(config.searchInputId || 'searchInput');
        resultsContainer = document.getElementById(config.resultsContainerId || 'searchResults');
        categoryFilter = document.getElementById(config.categoryFilterId || 'categoryFilter');
        authorFilter = document.getElementById(config.authorFilterId || 'authorFilter');
        typeFilter = document.getElementById(config.typeFilterId || 'typeFilter');

        if (config.debounceDelay) {
            debounceDelay = config.debounceDelay;
        }

        if (config.minSearchLength) {
            minSearchLength = config.minSearchLength;
        }

        if (searchInput) {
            searchInput.addEventListener('input', handleSearchInput);
            searchInput.addEventListener('keydown', handleKeyDown);
            searchInput.addEventListener('focus', handleFocus);
        }

        if (categoryFilter) {
            categoryFilter.addEventListener('change', triggerSearch);
        }

        if (authorFilter) {
            authorFilter.addEventListener('input', handleFilterInput);
        }

        if (typeFilter) {
            typeFilter.addEventListener('change', triggerSearch);
        }

        document.addEventListener('click', handleClickOutside);
    }

    function handleSearchInput(e) {
        var query = e.target.value.trim();

        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }

        if (query.length < minSearchLength) {
            hideResults();
            return;
        }

        showLoading();

        searchTimeout = setTimeout(function() {
            performSearch(query);
        }, debounceDelay);
    }

    function handleKeyDown(e) {
        if (e.key === 'Escape') {
            hideResults();
            searchInput.blur();
        } else if (e.key === 'Enter') {
            e.preventDefault();
            if (searchTimeout) {
                clearTimeout(searchTimeout);
            }
            performSearch(searchInput.value.trim());
        } else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
            e.preventDefault();
            navigateResults(e.key === 'ArrowDown' ? 1 : -1);
        }
    }

    function handleFocus() {
        var query = searchInput.value.trim();
        if (query.length >= minSearchLength && resultsContainer.children.length > 0) {
            showResults();
        }
    }

    function handleFilterInput() {
        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }

        searchTimeout = setTimeout(function() {
            triggerSearch();
        }, debounceDelay);
    }

    function handleClickOutside(e) {
        if (!searchInput.contains(e.target) && !resultsContainer.contains(e.target)) {
            hideResults();
        }
    }

    function triggerSearch() {
        var query = searchInput.value.trim();
        if (query.length >= minSearchLength) {
            performSearch(query);
        }
    }

    function performSearch(query) {
        if (isLoading) return;
        if (!query || query.length < minSearchLength) {
            hideResults();
            return;
        }

        isLoading = true;
        showLoading();

        var params = new URLSearchParams();
        params.append('q', query);

        if (categoryFilter && categoryFilter.value && categoryFilter.value !== 'all') {
            params.append('category', categoryFilter.value);
        }

        if (authorFilter && authorFilter.value.trim()) {
            params.append('author', authorFilter.value.trim());
        }

        if (typeFilter && typeFilter.value && typeFilter.value !== 'all') {
            params.append('type', typeFilter.value);
        }

        params.append('limit', '10');

        var xhr = new XMLHttpRequest();
        xhr.open('GET', searchEndpoint + '?' + params.toString(), true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                isLoading = false;

                if (xhr.status === 200) {
                    try {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            displayResults(response.results);
                        } else {
                            displayError(response.error || 'Search failed');
                        }
                    } catch (e) {
                        displayError('Invalid response from server');
                    }
                } else {
                    displayError('Network error occurred');
                }
            }
        };

        xhr.onerror = function() {
            isLoading = false;
            displayError('Connection failed');
        };

        xhr.send();
    }

    function displayResults(results) {
        resultsContainer.innerHTML = '';

        if (!results || results.length === 0) {
            var noResults = document.createElement('div');
            noResults.className = 'search-no-results';
            noResults.textContent = 'No books found matching your search';
            resultsContainer.appendChild(noResults);
            showResults();
            return;
        }

        results.forEach(function(item, index) {
            var resultItem = createResultItem(item, index);
            resultsContainer.appendChild(resultItem);
        });

        showResults();
    }

    function createResultItem(item, index) {
        var div = document.createElement('div');
        div.className = 'search-result-item';
        div.setAttribute('data-index', index);
        div.setAttribute('data-id', item.id);

        var titleDiv = document.createElement('div');
        titleDiv.className = 'result-title';
        titleDiv.textContent = item.title;

        var metaDiv = document.createElement('div');
        metaDiv.className = 'result-meta';

        var authorSpan = document.createElement('span');
        authorSpan.className = 'result-author';
        authorSpan.textContent = item.author;

        var separator1 = document.createElement('span');
        separator1.className = 'result-separator';
        separator1.textContent = ' • ';

        var categorySpan = document.createElement('span');
        categorySpan.className = 'result-category';
        categorySpan.textContent = item.category;

        var separator2 = document.createElement('span');
        separator2.className = 'result-separator';
        separator2.textContent = ' • ';

        var typeSpan = document.createElement('span');
        typeSpan.className = 'result-type';
        typeSpan.textContent = item.type;

        metaDiv.appendChild(authorSpan);
        metaDiv.appendChild(separator1);
        metaDiv.appendChild(categorySpan);
        metaDiv.appendChild(separator2);
        metaDiv.appendChild(typeSpan);

        var statusDiv = document.createElement('div');
        statusDiv.className = 'result-status ' + (item.status === 'Available' ? 'status-available' : 'status-unavailable');
        statusDiv.textContent = item.status;

        div.appendChild(titleDiv);
        div.appendChild(metaDiv);
        div.appendChild(statusDiv);

        div.addEventListener('click', function() {
            selectResult(item);
        });

        div.addEventListener('mouseenter', function() {
            highlightResult(index);
        });

        return div;
    }

    function displayError(message) {
        resultsContainer.innerHTML = '';

        var errorDiv = document.createElement('div');
        errorDiv.className = 'search-error';
        errorDiv.textContent = message;
        resultsContainer.appendChild(errorDiv);

        showResults();
    }

    function showLoading() {
        if (resultsContainer.querySelector('.search-loading')) return;

        var loadingDiv = document.createElement('div');
        loadingDiv.className = 'search-loading';
        loadingDiv.innerHTML = '<span class="loading-spinner"></span> Searching...';

        if (resultsContainer.children.length === 0) {
            resultsContainer.appendChild(loadingDiv);
            showResults();
        }
    }

    function showResults() {
        resultsContainer.classList.add('active');
    }

    function hideResults() {
        resultsContainer.classList.remove('active');
    }

    function navigateResults(direction) {
        var items = resultsContainer.querySelectorAll('.search-result-item');
        if (items.length === 0) return;

        var current = resultsContainer.querySelector('.search-result-item.highlighted');
        var currentIndex = current ? parseInt(current.getAttribute('data-index')) : -1;
        var newIndex = currentIndex + direction;

        if (newIndex < 0) newIndex = items.length - 1;
        if (newIndex >= items.length) newIndex = 0;

        highlightResult(newIndex);
    }

    function highlightResult(index) {
        var items = resultsContainer.querySelectorAll('.search-result-item');
        items.forEach(function(item) {
            item.classList.remove('highlighted');
        });

        if (items[index]) {
            items[index].classList.add('highlighted');
            items[index].scrollIntoView({ block: 'nearest' });
        }
    }

    function selectResult(item) {
        searchInput.value = item.title;
        hideResults();

        var event = new CustomEvent('searchResultSelected', { detail: item });
        document.dispatchEvent(event);
    }

    function clearSearch() {
        if (searchInput) {
            searchInput.value = '';
        }
        hideResults();
        resultsContainer.innerHTML = '';
    }

    function setFilters(filters) {
        if (filters.category && categoryFilter) {
            categoryFilter.value = filters.category;
        }
        if (filters.author && authorFilter) {
            authorFilter.value = filters.author;
        }
        if (filters.type && typeFilter) {
            typeFilter.value = filters.type;
        }
    }

    return {
        init: init,
        search: performSearch,
        clear: clearSearch,
        setFilters: setFilters,
        hide: hideResults
    };
})();
