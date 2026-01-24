package com.library.dto;

public class SearchResult {
    private int id;
    private String title;
    private String author;
    private String category;
    private String status;
    private String type;
    private String highlightedTitle;
    private String highlightedAuthor;
    private double relevanceScore;

    public SearchResult() {}

    public SearchResult(int id, String title, String author, String category, String status, String type) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.status = status;
        this.type = type;
        this.highlightedTitle = title;
        this.highlightedAuthor = author;
        this.relevanceScore = 0.0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getHighlightedTitle() {
        return highlightedTitle;
    }

    public void setHighlightedTitle(String highlightedTitle) {
        this.highlightedTitle = highlightedTitle;
    }

    public String getHighlightedAuthor() {
        return highlightedAuthor;
    }

    public void setHighlightedAuthor(String highlightedAuthor) {
        this.highlightedAuthor = highlightedAuthor;
    }

    public double getRelevanceScore() {
        return relevanceScore;
    }

    public void setRelevanceScore(double relevanceScore) {
        this.relevanceScore = relevanceScore;
    }
}
