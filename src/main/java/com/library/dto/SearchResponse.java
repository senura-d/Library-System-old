package com.library.dto;

import java.util.List;

public class SearchResponse {
    private boolean success;
    private List<SearchResult> results;
    private List<String> suggestions;
    private int totalCount;
    private long queryTime;
    private String error;

    public SearchResponse() {}

    public static SearchResponse success(List<SearchResult> results, List<String> suggestions, int totalCount, long queryTime) {
        SearchResponse response = new SearchResponse();
        response.success = true;
        response.results = results;
        response.suggestions = suggestions;
        response.totalCount = totalCount;
        response.queryTime = queryTime;
        return response;
    }

    public static SearchResponse error(String errorMessage) {
        SearchResponse response = new SearchResponse();
        response.success = false;
        response.error = errorMessage;
        return response;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public List<SearchResult> getResults() {
        return results;
    }

    public void setResults(List<SearchResult> results) {
        this.results = results;
    }

    public List<String> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<String> suggestions) {
        this.suggestions = suggestions;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public long getQueryTime() {
        return queryTime;
    }

    public void setQueryTime(long queryTime) {
        this.queryTime = queryTime;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
