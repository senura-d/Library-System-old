package com.library.controller;

import com.library.dao.DBConnection;
import com.library.model.Book;
import com.library.model.PhysicalBook;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("q");
        List<Book> books = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR category LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            String searchPattern = "%" + (query != null ? query : "") + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new PhysicalBook(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        5, 0
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Manual JSON construction to avoid Gson library errors
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < books.size(); i++) {
            Book b = books.get(i);
            json.append("{");
            json.append("\"id\":").append(b.getId()).append(",");
            json.append("\"title\":\"").append(b.getTitle().replace("\"", "\\\"")).append("\",");
            json.append("\"author\":\"").append(b.getAuthor().replace("\"", "\\\"")).append("\",");
            json.append("\"category\":\"").append(b.getCategory().replace("\"", "\\\"")).append("\",");
            json.append("\"status\":\"").append(b.isAvailable() ? "Available" : "Unavailable").append("\"");
            json.append("}");
            if (i < books.size() - 1) json.append(",");
        }
        json.append("]");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }
}