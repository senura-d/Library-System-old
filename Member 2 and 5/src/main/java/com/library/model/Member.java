package com.library.model;

public class Member {
    
    protected String memberId;
    protected String fullName;
    protected String email;
    protected String passwordHash;

    // Constructor: Helps create a new Member object easily
    public Member(String memberId, String fullName, String email, String passwordHash) {
        this.memberId = memberId;
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
    }

    // Getters: Allow other parts of the code to read these values
    public String getMemberId() { return memberId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPasswordHash() { return passwordHash; }
}

