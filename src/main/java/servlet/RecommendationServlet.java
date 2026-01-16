package com.library.servlet;

import com.library.model.Book;
import com.library.recommendation.RecommendationEngine;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/recommendations")
public class RecommendationServlet extends HttpServlet {

    private RecommendationEngine engine;

    @Override
    public void init() throws ServletException {
        super.init();
        engine = new RecommendationEngine();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");

        // Get recommendations
        List<Book> recommendedBooks = engine.getRecommendationsByCategory(category);

        // Pass data to JSP
        request.setAttribute("recommendedBooks", recommendedBooks);

        // Forward to the View
        // IMPORTANT: Make sure this path exists!
        request.getRequestDispatcher("/WEB-INF/recommendBooks.jsp").forward(request, response);
    }
}