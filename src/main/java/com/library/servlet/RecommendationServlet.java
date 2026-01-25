package com.library.servlet;

import com.library.model.Book;
import com.library.recommendation.RecommendationEngine;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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


        List<Book> recommendedBooks = engine.getRecommendationsByCategory(category);


        request.setAttribute("recommendedBooks", recommendedBooks);


        request.getRequestDispatcher("/WEB-INF/recommendBooks.jsp").forward(request, response);
    }
}