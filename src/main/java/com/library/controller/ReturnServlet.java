package com.library.controller;

import com.library.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReturnServlet")
public class ReturnServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        try (Connection conn = DBConnection.getConnection()) {
            // 1. Mark as Returned in records
            String updateRecord = "UPDATE borrow_records SET status = 'Returned' WHERE book_id = ? AND status = 'Borrowed'";
            try (PreparedStatement pstmt = conn.prepareStatement(updateRecord)) {
                pstmt.setString(1, bookId);
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
                    // 2. Make book available again
                    String updateBook = "UPDATE books SET status = 'Available' WHERE book_id = ?";
                    try (PreparedStatement bookStmt = conn.prepareStatement(updateBook)) {
                        bookStmt.setString(1, bookId);
                        bookStmt.executeUpdate();
                    }
                    response.sendRedirect("member-dashboard?msg=ReturnSuccess");
                } else {
                    response.sendRedirect("borrowBook.jsp?error=BookNotBorrowed");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("borrowBook.jsp?error=ReturnFailed");
        }
    }
}