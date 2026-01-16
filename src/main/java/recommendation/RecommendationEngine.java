package com.library.recommendation;

import com.library.model.Book;
import com.library.model.DigitalBook;
import com.library.model.PhysicalBook;
import java.util.ArrayList;
import java.util.List;

public class RecommendationEngine {

    private List<Book> allBooks;

    public RecommendationEngine() {
        allBooks = new ArrayList<>();

        // Physical books
        allBooks.add(new PhysicalBook(1, "Clean Code", "Robert Martin", "Programming", 5, 2));
        allBooks.add(new PhysicalBook(2, "Effective Java", "Joshua Bloch", "Programming", 3, 3));
        allBooks.add(new PhysicalBook(3, "Refactoring", "Martin Fowler", "Programming", 4, 1));

        // Digital books
        allBooks.add(new DigitalBook(4, "HTML & CSS", "Jon Duckett", "Web", "/books/html_css.pdf"));
        allBooks.add(new DigitalBook(5, "JavaScript: The Good Parts", "Douglas Crockford", "Web", "/books/js_good_parts.pdf"));
        allBooks.add(new DigitalBook(6, "Learning React", "Alex Banks", "Web", "/books/learning_react.pdf"));

        // More categories
        allBooks.add(new PhysicalBook(7, "Operating System Concepts", "Silberschatz", "Operating Systems", 5, 0));
        allBooks.add(new DigitalBook(8, "Python for Data Analysis", "Wes McKinney", "Data Science", "/books/python_data_analysis.pdf"));
    }

    public List<Book> getRecommendationsByCategory(String category) {
        List<Book> recommended = new ArrayList<>();

        if (category == null || category.isEmpty()) {
            // If no category selected, return everything or popular ones
            return allBooks;
        }

        for (Book book : allBooks) {
            if (book.getCategory().equalsIgnoreCase(category) && book.isAvailable()) {
                recommended.add(book);
            }
        }
        return recommended;
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        for (Book book : allBooks) {
            if (!categories.contains(book.getCategory())) {
                categories.add(book.getCategory());
            }
        }
        return categories;
    }
}