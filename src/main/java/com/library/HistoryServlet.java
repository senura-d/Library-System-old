package com.library;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/HistoryServlet")
public class HistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db", "root", "");

            PreparedStatement pst = con.prepareStatement("SELECT * FROM borrow_records WHERE member_id = ?");
            pst.setString(1, "M123");
            ResultSet rs = pst.executeQuery();

            while(rs.next()) {
                list.add(new String[]{ rs.getString("book_title"), rs.getString("borrow_date"), rs.getString("status") });
            }
        } catch (Exception e) { e.printStackTrace(); }

        request.setAttribute("historyList", list);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}