package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String room = request.getParameter("roomName");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        // In a real app, save to DB here: INSERT INTO bookings...
        System.out.println("Booking: " + room + " on " + date + " at " + time);

        response.sendRedirect("member-dashboard?msg=RoomBooked");
    }
}