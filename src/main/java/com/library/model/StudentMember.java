package com.library.model;

// "extends Member" means this class gets everything from the Member class above
public class StudentMember extends Member {
    private String studentId;

    public StudentMember(String memberId, String fullName, String email, String passwordHash, String studentId) {
        // "super" passes the basic info up to the parent Member class
        super(memberId, fullName, email, passwordHash);
        this.studentId = studentId;
    }

    public String getStudentId() { return studentId; }
}