package com.library.controller;

import com.library.model.StudentMember;
import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// This line connects the HTML form (action="register") to this Java code
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the data from the JSP form
        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String sid = request.getParameter("sid");

        try {
            // 2. Load the MySQL Driver (The Bridge)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 3. Connect to the Database
            // CHANGE "YOUR_MYSQL_PASSWORD" BELOW TO YOUR REAL PASSWORD!
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/library_db", "root", "Askme458");

            // 4. Generate a unique Member ID and Hash the Password
            String memberId = "MEM-" + UUID.randomUUID().toString().substring(0, 8);
            String passwordHash = hashPassword(pass);

            // 5. Create the OOP Object (Meeting your requirement)
            StudentMember newStudent = new StudentMember(memberId, name, email, passwordHash, sid);

            // 6. Save to Database (SQL)
            String sql = "INSERT INTO members (member_id, full_name, email, password_hash, student_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newStudent.getMemberId());
            ps.setString(2, newStudent.getFullName());
            ps.setString(3, newStudent.getEmail());
            ps.setString(4, newStudent.getPasswordHash());
            ps.setString(5, newStudent.getStudentId());

            ps.executeUpdate(); // Run the SQL
            con.close(); // Close the connection

            // 7. Success! Show a simple success message
            response.getWriter().println("<h1>Registration Successful!</h1>");
            response.getWriter().println("<p>Member ID: " + memberId + "</p>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Error: " + e.getMessage() + "</h1>");
        }
    }

    // Helper method to scramble the password (Security Requirement)
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