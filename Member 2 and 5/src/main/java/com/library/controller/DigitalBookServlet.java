package com.library.controller;

import com.library.model.DigitalBook;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/read-book")
public class DigitalBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM books WHERE book_id=? AND is_digital=TRUE");
            ps.setInt(1, bookId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                DigitalBook book = new DigitalBook(
                        rs.getInt("book_id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("category"),
                        rs.getString("file_path")
                );

                request.setAttribute("book", book);
                request.getRequestDispatcher("read_book.jsp").forward(request, response);
            } else {
                response.sendRedirect("member_home.jsp");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
