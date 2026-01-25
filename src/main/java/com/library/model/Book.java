package com.library.model;

public abstract class Book {
    protected int id;
    protected String title;
    protected String author;
    protected String category;
    protected String status;

    public Book(int id, String title, String author, String category, String status) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.category = category;
        this.status = status;
    }

    public abstract boolean isAvailable();

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getCategory() { return category; }
    public String getStatus() { return status; }
}
