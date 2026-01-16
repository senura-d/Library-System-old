package com.library.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// This maps the URL "/member-dashboard" (hyphen) to this Java class
@WebServlet("/member-dashboard")
public class MemberDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. In the future, you can fetch book data from the database here.

        // 2. Forward the user to the actual JSP file (MUST use underscore here to match filename)
        request.getRequestDispatcher("member_dashboard.jsp").forward(request, response);
    }
}