package com.library.controller;

import com.library.dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalBooks = 0;
        int totalMembers = 0;
        int issuedBooks = 0;
        int overdueBooks = 0;

        try (Connection con = DBConnection.getConnection()) {

            // ... inside doGet ...
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM books");
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) totalBooks = rs1.getInt(1); // This line puts the number in!
// ...
            request.setAttribute("totalBooks", totalBooks);

            // 2. Count Members
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM members");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) totalMembers = rs2.getInt(1);

            // 3. Count Issued Books
            PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM transactions WHERE status='issued'");
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) issuedBooks = rs3.getInt(1);

            // 4. Count Overdue (Due date passed)
            PreparedStatement ps4 = con.prepareStatement("SELECT COUNT(*) FROM transactions WHERE due_date < CURDATE() AND status='issued'");
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) overdueBooks = rs4.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send data to JSP
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("totalMembers", totalMembers);
        request.setAttribute("issuedBooks", issuedBooks);
        request.setAttribute("overdueBooks", overdueBooks);

        // Forward to the dashboard view
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}