package com.library.controller;

import com.library.util.ReminderScheduler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/send-reminders")
public class ReminderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. Run the Scheduler Logic
        ReminderScheduler scheduler = new ReminderScheduler();
        scheduler.checkOverdueBooks();

        // 2. Go back to Dashboard with a success message
        response.sendRedirect(request.getContextPath() + "/admin/dashboard?msg=RemindersSent");
    }
}