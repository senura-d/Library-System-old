package com.library.controller;

import com.library.dao.DBConnection;
import com.library.model.Book;
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
                // 🔴 THE FIX: We are now sending EXACTLY 5 arguments to match your Book.java
                bookList.add(new Book(
                        rs.getInt("book_id"),       // 1. ID
                        rs.getString("title"),      // 2. Title
                        rs.getString("author"),     // 3. Author
                        rs.getString("category"),   // 4. Category
                        rs.getString("status")      // 5. Status
                        // ❌ REMOVED: rs.getInt("quantity") <- This was the 6th item causing the error!
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("/admin/admin.jsp").forward(request, response);
    }
}