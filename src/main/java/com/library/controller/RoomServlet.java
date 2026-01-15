package com.library.controller;

import com.library.model.Room;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/manage-rooms")
public class RoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Room> rooms = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // CHANGE PASSWORD HERE
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM room");
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                rooms.add(new Room(
                        rs.getInt("room_id"),
                        rs.getString("room_name"),
                        rs.getInt("capacity"),
                        rs.getString("status")
                ));
            }
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("roomList", rooms);
        request.getRequestDispatcher("admin/rooms.jsp").forward(request, response);
    }
}