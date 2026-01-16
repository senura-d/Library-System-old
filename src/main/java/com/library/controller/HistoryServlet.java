package com.library.controller;

import com.library.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String memberId = (String) session.getAttribute("memberId");

        if (memberId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, String>> historyList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            // Fetch Borrow History
            String sql = "SELECT b.title, br.borrow_date, br.status FROM borrow_records br " +
                    "JOIN books b ON br.book_id = b.book_id " +
                    "WHERE br.member_id = ? ORDER BY br.borrow_date DESC";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, memberId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, String> record = new HashMap<>();
                    record.put("item", rs.getString("title"));
                    record.put("date", rs.getString("borrow_date"));
                    record.put("type", "BOOK");
                    record.put("status", rs.getString("status"));
                    historyList.add(record);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}