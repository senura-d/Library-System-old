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

@WebServlet("/manage-books")
public class BookListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> bookList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM books";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Using PhysicalBook because Book is abstract
                bookList.add(new PhysicalBook(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        5, 0 // Default values for copies
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookList", bookList);
        // Ensure this points to your actual admin page
        request.getRequestDispatcher("/admin/admin.jsp").forward(request, response);
    }
}