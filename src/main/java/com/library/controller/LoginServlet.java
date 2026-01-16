package com.library.controller;

import com.library.dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {

            // 1. CHECK MEMBERS TABLE (Student Login)
            PreparedStatement ps = con.prepareStatement("SELECT * FROM members WHERE member_id=? AND password_hash=?");
            ps.setString(1, u);
            ps.setString(2, p);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("memberId", rs.getString("member_id"));
                session.setAttribute("memberName", rs.getString("full_name"));
                session.setAttribute("memberEmail", rs.getString("email"));
                response.sendRedirect("member_dashboard.jsp");

            } else {
                // 2. CHECK ADMINS TABLE (Admin Login)
                PreparedStatement ps2 = con.prepareStatement("SELECT * FROM admins WHERE username=? AND password_hash=?");
                ps2.setString(1, u);
                ps2.setString(2, p);
                ResultSet rs2 = ps2.executeQuery();

                if (rs2.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("adminUser", u);

                    // Fetch real role (e.g., 'SUPER_ADMIN') and save as 'adminRole'
                    String dbRole = rs2.getString("role");
                    session.setAttribute("adminRole", dbRole);

                    response.sendRedirect("admin/dashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid Credentials");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=System Error");
        }
    }
}