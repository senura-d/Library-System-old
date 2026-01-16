package com.library.controller;

import com.library.dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/add-book")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Get data from form (Only what exists in your DB)
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");

        // Default status is 'Available'
        String status = "Available";

        try (Connection con = DBConnection.getConnection()) {
            // 2. Insert into database (Using your new columns)
            // Note: We do NOT insert 'quantity' or 'isbn' anymore
            String sql = "INSERT INTO books (title, author, category, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);
            ps.setString(4, status);

            ps.executeUpdate();

            // Success: Go back to dashboard with success message
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?msg=BookAdded");

        } catch (Exception e) {
            e.printStackTrace();
            // Failure: Stay on page with error
            response.sendRedirect(request.getContextPath() + "/admin/add_book.jsp?error=Failed");
        }
    }
}