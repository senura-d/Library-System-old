package com.library.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin-register")
public class AdminRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        // Hash password
        String hashedPassword = hashPassword(pass);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // PASSWORD: Askme458
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            // Insert new Admin as 'PENDING'
            String sql = "INSERT INTO admins (username, password_hash, status, role) VALUES (?, ?, 'PENDING', 'ADMIN')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashedPassword);

            ps.executeUpdate();
            con.close();

            // Redirect back to login with a success message
            response.sendRedirect("admin/index.jsp?error=Request Sent! Wait for Approval.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/register.jsp?error=Username already taken");
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