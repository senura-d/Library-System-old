package com.library.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-auth")
public class AdminAuthServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        String hashedPassword = hashPassword(pass);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            String sql = "SELECT * FROM admins WHERE username = ? AND password_hash = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                // HERE IS THE LOGIC YOU WERE LOOKING FOR:
                if ("APPROVED".equals(status)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("adminUser", username);

                    // SAVE THE ROLE (Super Admin vs Admin)
                    String role = rs.getString("role");
                    session.setAttribute("adminRole", role);

                    response.sendRedirect("dashboard");
                } else {
                    response.sendRedirect("admin/index.jsp?error=Pending Approval");
                }
            } else {
                response.sendRedirect("admin/index.jsp?error=Invalid Credentials");
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}