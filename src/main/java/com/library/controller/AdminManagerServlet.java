package com.library.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/manage-admin")
public class AdminManagerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // SECURITY: Only allow SUPER_ADMIN
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("adminRole");
        if (role == null || !role.equals("SUPER_ADMIN")) {
            response.sendRedirect("dashboard");
            return;
        }

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Using password "Askme458"
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            if ("approve".equals(action)) {
                PreparedStatement ps = con.prepareStatement("UPDATE admins SET status='APPROVED' WHERE id=?");
                ps.setString(1, id);
                ps.executeUpdate();
            } else if ("delete".equals(action)) {
                PreparedStatement ps = con.prepareStatement("DELETE FROM admins WHERE id=?");
                ps.setString(1, id);
                ps.executeUpdate();
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Go back to the management page
        response.sendRedirect("admin/super_admin.jsp");
    }
}