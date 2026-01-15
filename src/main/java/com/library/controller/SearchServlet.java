package com.library.controller;

import com.library.model.SearchResult;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/library_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Askme458";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");

        String query = request.getParameter("q");
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        String type = request.getParameter("type");
        String limitParam = request.getParameter("limit");

        int limit = 10;
        if (limitParam != null && !limitParam.isEmpty()) {
            try {
                limit = Integer.parseInt(limitParam);
                if (limit > 50) limit = 50;
                if (limit < 1) limit = 10;
            } catch (NumberFormatException e) {
                limit = 10;
            }
        }

        PrintWriter out = response.getWriter();

        if (query == null || query.trim().isEmpty()) {
            out.print("{\"success\":false,\"error\":\"Search query is required\",\"results\":[]}");
            return;
        }

        query = query.trim().toLowerCase();

        List<SearchResult> results = performSearch(query, category, author, type, limit);

        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{");
        jsonResponse.append("\"success\":true,");
        jsonResponse.append("\"query\":\"").append(escapeJson(query)).append("\",");
        jsonResponse.append("\"totalResults\":").append(results.size()).append(",");
        jsonResponse.append("\"results\":[");

        for (int i = 0; i < results.size(); i++) {
            jsonResponse.append(results.get(i).toJson());
            if (i < results.size() - 1) {
                jsonResponse.append(",");
            }
        }

        jsonResponse.append("]");
        jsonResponse.append("}");

        out.print(jsonResponse.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private List<SearchResult> performSearch(String query, String category, String author, String type, int limit) {
        List<SearchResult> results = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            StringBuilder sql = new StringBuilder();
            sql.append("SELECT id, title, author, category, ");
            sql.append("COALESCE(type, 'Book') as type, status, ");
            sql.append("(CASE ");
            sql.append("WHEN LOWER(title) = ? THEN 100 ");
            sql.append("WHEN LOWER(title) LIKE ? THEN 80 ");
            sql.append("WHEN LOWER(title) LIKE ? THEN 60 ");
            sql.append("WHEN LOWER(author) = ? THEN 50 ");
            sql.append("WHEN LOWER(author) LIKE ? THEN 40 ");
            sql.append("WHEN LOWER(category) LIKE ? THEN 30 ");
            sql.append("ELSE 10 END) as relevance_score ");
            sql.append("FROM books WHERE ");
            sql.append("(LOWER(title) LIKE ? OR LOWER(author) LIKE ? OR LOWER(category) LIKE ?)");

            List<Object> params = new ArrayList<>();
            params.add(query);
            params.add(query + "%");
            params.add("%" + query + "%");
            params.add(query);
            params.add("%" + query + "%");
            params.add("%" + query + "%");
            params.add("%" + query + "%");
            params.add("%" + query + "%");
            params.add("%" + query + "%");

            if (category != null && !category.isEmpty() && !category.equals("all")) {
                sql.append(" AND LOWER(category) = ?");
                params.add(category.toLowerCase());
            }

            if (author != null && !author.isEmpty()) {
                sql.append(" AND LOWER(author) LIKE ?");
                params.add("%" + author.toLowerCase() + "%");
            }

            if (type != null && !type.isEmpty() && !type.equals("all")) {
                sql.append(" AND LOWER(COALESCE(type, 'book')) = ?");
                params.add(type.toLowerCase());
            }

            sql.append(" ORDER BY relevance_score DESC, title ASC");
            sql.append(" LIMIT ?");
            params.add(limit);

            PreparedStatement ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                }
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SearchResult result = new SearchResult();
                result.setId(rs.getInt("id"));
                result.setTitle(rs.getString("title"));
                result.setAuthor(rs.getString("author"));
                result.setCategory(rs.getString("category"));
                result.setType(rs.getString("type"));
                result.setStatus(rs.getString("status"));
                result.setRelevanceScore(rs.getDouble("relevance_score"));
                results.add(result);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
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
