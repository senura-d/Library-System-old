package com.library.controller;

import com.library.dao.DBConnection; // Ensure this matches your DBConnection package
import com.library.model.Member;
import com.library.model.Book;
import com.library.model.PhysicalBook; // 🟢 IMPORT ADDED
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Member> memberList = new ArrayList<>();
        List<Book> bookList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            // 1. GET MEMBERS
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM members");
            while (rs.next()) {
                memberList.add(new Member(
                        rs.getString("member_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("password_hash")
                ));
            }

            // 2. GET BOOKS
            Statement stmt2 = con.createStatement();
            ResultSet rs2 = stmt2.executeQuery("SELECT * FROM books");
            while (rs2.next()) {
                // 🟢 FIXED: Using PhysicalBook
                bookList.add(new PhysicalBook(
                        rs2.getInt("book_id"),
                        rs2.getString("title"),
                        rs2.getString("author"),
                        rs2.getString("category"),
                        5, 0
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("membersList", memberList);
        request.setAttribute("booksList", bookList);
        // Ensure this path matches your folder structure
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }
}