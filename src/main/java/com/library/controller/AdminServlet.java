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
        List<Book> bookList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Make sure this password matches your local MySQL password
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

            // 2. GET BOOKS (Updated to match your new Database & Book.java)
            Statement stmt2 = con.createStatement();
            ResultSet rs2 = stmt2.executeQuery("SELECT * FROM books");

            while (rs2.next()) {
                // 🟢 FIXED: Now sending exactly 5 arguments
                bookList.add(new Book(
                        rs2.getInt("book_id"),       // 1. Correct Column Name
                        rs2.getString("title"),      // 2. Title
                        rs2.getString("author"),     // 3. Author
                        rs2.getString("category"),   // 4. Category
                        rs2.getString("status")      // 5. Status
                ));
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send BOTH lists to the JSP page
        request.setAttribute("membersList", memberList);
        request.setAttribute("booksList", bookList);

        // Make sure this path is correct for your project structure
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }
}