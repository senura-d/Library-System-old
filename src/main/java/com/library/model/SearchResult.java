package com.library.model;

public class SearchResult {
    private int id;
    private String title;
    private String author;
    private String category;
    private String type;
    private String status;
    private double relevanceScore;

    public SearchResult() {}

    public SearchResult(int id, String title, String author, String category, String type, String status, double relevanceScore) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.type = type;
        this.status = status;
        this.relevanceScore = relevanceScore;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getRelevanceScore() { return relevanceScore; }
    public void setRelevanceScore(double relevanceScore) { this.relevanceScore = relevanceScore; }

    public String toJson() {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"id\":").append(id).append(",");
        sb.append("\"title\":\"").append(escapeJson(title)).append("\",");
        sb.append("\"author\":\"").append(escapeJson(author)).append("\",");
        sb.append("\"category\":\"").append(escapeJson(category)).append("\",");
        sb.append("\"type\":\"").append(escapeJson(type)).append("\",");
        sb.append("\"status\":\"").append(escapeJson(status)).append("\",");
        sb.append("\"relevanceScore\":").append(relevanceScore);
        sb.append("}");
        return sb.toString();
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
