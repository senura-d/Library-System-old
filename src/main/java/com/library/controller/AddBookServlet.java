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
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO books (title, author, isbn, category, quantity, available_quantity) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, isbn);
            ps.setString(4, category);
            ps.setInt(5, quantity);
            ps.setInt(6, quantity); // Initially, available = total

            ps.executeUpdate();
            response.sendRedirect("admin/dashboard.jsp?msg=BookAdded");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/add_book.jsp?error=Failed");
        }
    }
}