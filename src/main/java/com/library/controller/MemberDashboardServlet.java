package com.library.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/member-dashboard")
public class MemberDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. In a real app, you would fetch books from the Database here.
        //    For now, we will just forward to the design page.

        // 2. Send the user to the JSP view
        request.getRequestDispatcher("member_dashboard.jsp").forward(request, response);
    }
}