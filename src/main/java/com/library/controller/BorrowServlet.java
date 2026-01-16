package com.library.controller;

import com.library.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BorrowServlet")
public class BorrowServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String memberId = request.getParameter("memberId");

        LocalDate borrowDate = LocalDate.now();
        LocalDate dueDate = borrowDate.plusDays(14);

        try (Connection conn = DBConnection.getConnection()) {
            // 1. Insert Borrow Record
            String sql = "INSERT INTO borrow_records (book_id, member_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, 'Borrowed')";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, bookId);
                pstmt.setString(2, memberId);
                pstmt.setDate(3, Date.valueOf(borrowDate));
                pstmt.setDate(4, Date.valueOf(dueDate));
                pstmt.executeUpdate();
            }

            // 2. Update Book Status to 'Issued'
            String updateBook = "UPDATE books SET status = 'Issued' WHERE book_id = ?";
            try (PreparedStatement updatePstmt = conn.prepareStatement(updateBook)) {
                updatePstmt.setString(1, bookId);
                updatePstmt.executeUpdate();
            }

            response.sendRedirect("member-dashboard?msg=BorrowSuccess");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("borrowBook.jsp?error=BorrowFailed");
        }
    }
}