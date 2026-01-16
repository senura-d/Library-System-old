package com.library.model;

public class PhysicalBook extends Book {
    private int totalCopies;
    private int borrowedCopies;

    public PhysicalBook(int id, String title, String author, String category,
                        int totalCopies, int borrowedCopies) {
        super(id, title, author, category, "PHYSICAL");
        this.totalCopies = totalCopies;
        this.borrowedCopies = borrowedCopies;
    }

    @Override
    public boolean isAvailable() {
        return borrowedCopies < totalCopies;
    }
}