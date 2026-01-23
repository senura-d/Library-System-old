package com.library.util;

import com.library.dao.DBConnection;
import java.sql.*;

public class ReminderScheduler {

    public void checkOverdueBooks() {
        // Find books where today is AFTER the due_date
        String sql = "SELECT member_id, book_id, due_date FROM borrow_records WHERE status = 'Borrowed' AND due_date < CURRENT_DATE";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n[SYSTEM ALERT] --------------------------------------");
            System.out.println("[SYSTEM ALERT] Scanning for overdue books...");
            boolean found = false;

            while (rs.next()) {
                found = true;
                String memberId = rs.getString("member_id");
                int bookId = rs.getInt("book_id");
                Date dueDate = rs.getDate("due_date");

                // In a real app, this would send an Email.
                // For your project, printing to the Console is perfect evidence.
                System.out.println(">>> 📧 SENDING EMAIL to Member: " + memberId +
                        " | Book ID: " + bookId +
                        " | Overdue since: " + dueDate);
            }

            if (!found) {
                System.out.println("[SYSTEM ALERT] ✅ No overdue books found today.");
            }
            System.out.println("[SYSTEM ALERT] --------------------------------------\n");

        } catch (SQLException | ClassNotFoundException e) { // 🟢 FIXED: Catches both errors now
            System.err.println("Error running scheduler: " + e.getMessage());
            e.printStackTrace();
        }
    }
}