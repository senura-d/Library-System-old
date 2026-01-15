package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the current session
        HttpSession session = request.getSession(false); // false means "don't create a new one if it doesn't exist"

        if (session != null) {
            // 2. Kill the session (Delete all memory of who is logged in)
            session.invalidate();
        }

        // 3. Send them back to the Home Page
        response.sendRedirect("index.jsp");
    }
}