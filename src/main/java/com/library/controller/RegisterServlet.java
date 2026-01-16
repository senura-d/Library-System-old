package com.library.controller;

import com.library.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("fullname");
        String id = request.getParameter("username"); // Using Student ID as username
        String pass = request.getParameter("password");
        String email = id + "@university.com"; // Auto-generate dummy email

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO members (member_id, full_name, email, password_hash, status) VALUES (?, ?, ?, ?, 'Active')";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, pass);
            ps.executeUpdate();

            response.sendRedirect("login.jsp?msg=Registered");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Failed");
        }
    }
}