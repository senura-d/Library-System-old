package com.library.controller;

import com.library.dao.DBConnection;
import com.library.dto.SearchResult;
import com.library.dto.SearchResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

@WebServlet("/api/search")
public class SearchServlet extends HttpServlet {

    private static final int MAX_RESULTS = 20;
    private static final int MAX_SUGGESTIONS = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Access-Control-Allow-Origin", "*");

        PrintWriter out = response.getWriter();
        long startTime = System.currentTimeMillis();

        String query = sanitizeInput(request.getParameter("q"));
        String category = sanitizeInput(request.getParameter("category"));
        String author = sanitizeInput(request.getParameter("author"));
        String type = sanitizeInput(request.getParameter("type"));
        String status = sanitizeInput(request.getParameter("status"));

        if (query == null || query.trim().isEmpty()) {
            out.print(toJson(SearchResponse.error("Search query is required")));
            return;
        }

        if (query.length() < 2) {
            out.print(toJson(SearchResponse.error("Search query must be at least 2 characters")));
            return;
        }

        if (query.length() > 100) {
            query = query.substring(0, 100);
        }

        try {
            SearchResponse searchResponse = performSearch(query, category, author, type, status, startTime);
            out.print(toJson(searchResponse));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print(toJson(SearchResponse.error("An error occurred while processing your search")));
        }
    }

    private SearchResponse performSearch(String query, String category, String author, 
            String type, String status, long startTime) {
        
        List<SearchResult> results = new ArrayList<>();
        Set<String> suggestionSet = new HashSet<>();
        String searchPattern = "%" + query.toLowerCase() + "%";

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT book_id, title, author, category, status, 'book' as type ");
        sql.append("FROM books WHERE 1=1 ");

        List<Object> params = new ArrayList<>();

        sql.append("AND (LOWER(title) LIKE ? OR LOWER(author) LIKE ? OR LOWER(category) LIKE ?) ");
        params.add(searchPattern);
        params.add(searchPattern);
        params.add(searchPattern);

        if (category != null && !category.isEmpty()) {
            sql.append("AND LOWER(category) = LOWER(?) ");
            params.add(category);
        }

        if (author != null && !author.isEmpty()) {
            sql.append("AND LOWER(author) LIKE LOWER(?) ");
            params.add("%" + author + "%");
        }

        if (status != null && !status.isEmpty()) {
            sql.append("AND LOWER(status) = LOWER(?) ");
            params.add(status);
        }

        sql.append("ORDER BY ");
        sql.append("CASE WHEN LOWER(title) LIKE LOWER(?) THEN 1 ");
        sql.append("WHEN LOWER(title) LIKE ? THEN 2 ");
        sql.append("WHEN LOWER(author) LIKE LOWER(?) THEN 3 ");
        sql.append("ELSE 4 END, ");
        sql.append("title ASC ");
        sql.append("LIMIT ?");

        params.add(query);
        params.add(searchPattern);
        params.add(query);
        params.add(MAX_RESULTS);

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SearchResult result = new SearchResult();
                    result.setId(rs.getInt("book_id"));
                    result.setTitle(rs.getString("title"));
                    result.setAuthor(rs.getString("author"));
                    result.setCategory(rs.getString("category"));
                    result.setStatus(rs.getString("status"));
                    result.setType(rs.getString("type"));

                    String titleLower = result.getTitle().toLowerCase();
                    String authorLower = result.getAuthor().toLowerCase();
                    String queryLower = query.toLowerCase();

                    double score = 0.0;
                    if (titleLower.equals(queryLower)) {
                        score = 100.0;
                    } else if (titleLower.startsWith(queryLower)) {
                        score = 80.0;
                    } else if (titleLower.contains(queryLower)) {
                        score = 60.0;
                    } else if (authorLower.contains(queryLower)) {
                        score = 40.0;
                    } else {
                        score = 20.0;
                    }
                    result.setRelevanceScore(score);

                    result.setHighlightedTitle(highlightMatch(result.getTitle(), query));
                    result.setHighlightedAuthor(highlightMatch(result.getAuthor(), query));

                    results.add(result);

                    if (suggestionSet.size() < MAX_SUGGESTIONS) {
                        if (titleLower.contains(queryLower)) {
                            suggestionSet.add(result.getTitle());
                        }
                        if (authorLower.contains(queryLower) && suggestionSet.size() < MAX_SUGGESTIONS) {
                            suggestionSet.add(result.getAuthor());
                        }
                    }
                }
            }

            results.sort(Comparator.comparingDouble(SearchResult::getRelevanceScore).reversed());

        } catch (SQLException e) {
            return SearchResponse.error("Database error occurred");
        }

        long queryTime = System.currentTimeMillis() - startTime;
        List<String> suggestions = new ArrayList<>(suggestionSet);

        return SearchResponse.success(results, suggestions, results.size(), queryTime);
    }

    private String highlightMatch(String text, String query) {
        if (text == null || query == null || query.isEmpty()) {
            return text;
        }
        
        String escapedQuery = Pattern.quote(query);
        return text.replaceAll("(?i)(" + escapedQuery + ")", "<mark>$1</mark>");
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;");
    }

    private String toJson(SearchResponse response) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"success\":").append(response.isSuccess()).append(",");
        
        if (response.isSuccess()) {
            json.append("\"totalCount\":").append(response.getTotalCount()).append(",");
            json.append("\"queryTime\":").append(response.getQueryTime()).append(",");
            
            json.append("\"suggestions\":[");
            List<String> suggestions = response.getSuggestions();
            if (suggestions != null) {
                for (int i = 0; i < suggestions.size(); i++) {
                    json.append("\"").append(escapeJson(suggestions.get(i))).append("\"");
                    if (i < suggestions.size() - 1) json.append(",");
                }
            }
            json.append("],");
            
            json.append("\"results\":[");
            List<SearchResult> results = response.getResults();
            if (results != null) {
                for (int i = 0; i < results.size(); i++) {
                    json.append(resultToJson(results.get(i)));
                    if (i < results.size() - 1) json.append(",");
                }
            }
            json.append("]");
        } else {
            json.append("\"error\":\"").append(escapeJson(response.getError())).append("\"");
        }
        
        json.append("}");
        return json.toString();
    }

    private String resultToJson(SearchResult result) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(result.getId()).append(",");
        json.append("\"title\":\"").append(escapeJson(result.getTitle())).append("\",");
        json.append("\"author\":\"").append(escapeJson(result.getAuthor())).append("\",");
        json.append("\"category\":\"").append(escapeJson(result.getCategory())).append("\",");
        json.append("\"status\":\"").append(escapeJson(result.getStatus())).append("\",");
        json.append("\"type\":\"").append(escapeJson(result.getType())).append("\",");
        json.append("\"highlightedTitle\":\"").append(escapeJson(result.getHighlightedTitle())).append("\",");
        json.append("\"highlightedAuthor\":\"").append(escapeJson(result.getHighlightedAuthor())).append("\",");
        json.append("\"relevanceScore\":").append(result.getRelevanceScore());
        json.append("}");
        return json.toString();
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
