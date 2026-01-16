package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RoomBookingServlet")
public class RoomBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomName = request.getParameter("roomName");
        String date = request.getParameter("date");

        // In a real app, you would save this to the database here.
        // For now, we simulate a successful booking.
        System.out.println("Booking Confirmed: " + roomName + " for " + date);

        response.sendRedirect("member-dashboard?msg=RoomBooked");
    }
}