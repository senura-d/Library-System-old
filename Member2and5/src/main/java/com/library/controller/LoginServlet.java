package com.library.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        String hashedPassword = hashPassword(pass);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // UPDATED PASSWORD: using "Askme458"
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            String sql = "SELECT * FROM members WHERE email = ? AND password_hash = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Success: Save user info to session
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);
                session.setAttribute("userName", rs.getString("full_name"));

                // Go to Admin page
                response.sendRedirect("member_home.jsp");
            } else {
                // Failure: Go back to login with error
                request.setAttribute("errorMessage", "Invalid Email or Password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
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