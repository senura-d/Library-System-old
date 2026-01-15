package com.library.controller;

import com.library.model.Member;
import com.library.model.Book;
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
        List<Book> bookList = new ArrayList<>(); // List to hold books

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

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
            ResultSet rs2 = stmt2.executeQuery("SELECT * FROM books");

            while (rs2.next()) {
                int total = rs2.getInt("total_copies");
                int borrowed = rs2.getInt("borrowed_copies");

                Book book = new PhysicalBook(
                        rs2.getInt("book_id"),
                        rs2.getString("title"),
                        rs2.getString("author"),
                        rs2.getString("category"),
                        total,
                        borrowed
                );

            bookList.add(book);
        }


        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send BOTH lists to the JSP page
        request.setAttribute("membersList", memberList);
        request.setAttribute("booksList", bookList);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}