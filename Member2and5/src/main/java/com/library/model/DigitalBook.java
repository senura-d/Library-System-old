package com.library.model;

public class DigitalBook extends Book {
    private String filePath;

    public DigitalBook(int id, String title, String author,
                       String category, String filePath) {
        super(id, title, author, category, "DIGITAL");
        this.filePath = filePath;
    }

    @Override
    public boolean isAvailable() {
        return true; // Digital books are always available
    }

    public String getFilePath() {
        return filePath;
    }
}
