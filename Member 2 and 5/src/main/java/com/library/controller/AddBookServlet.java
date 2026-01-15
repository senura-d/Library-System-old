package com.library.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add-book")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get data from the form
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");

        try {
            // 2. Connect to Database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            // 3. Insert the Book
            String sql = "INSERT INTO books (title, author, category, status) VALUES (?, ?, ?, 'AVAILABLE')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, category);

            ps.executeUpdate();
            con.close();

            // 4.Go back to the add page with a message
            response.sendRedirect("admin/add_book.jsp?msg=Book Added Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            // If error, go back to dashboard
            response.sendRedirect("dashboard");
        }
    }
}