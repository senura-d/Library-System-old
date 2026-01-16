package com.library.controller;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QRServlet")
public class QRServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String text = request.getParameter("text"); // The Member ID to encode
        if (text == null || text.trim().isEmpty()) text = "Unknown";

        int size = 150;
        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        // Draw a simple "Fake" QR code pattern (Since we can't import QR libraries easily)
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, size, size);
        g.setColor(Color.BLACK);

        // Draw 3 corner squares (Finder patterns)
        g.fillRect(10, 10, 40, 40);
        g.fillRect(size-50, 10, 40, 40);
        g.fillRect(10, size-50, 40, 40);

        // Draw random "data" dots based on the text hash
        int hash = text.hashCode();
        for(int i=20; i<size-20; i+=10) {
            for(int j=20; j<size-20; j+=10) {
                if ((hash * i * j) % 3 == 0) { // Simple randomness
                    g.fillRect(i, j, 8, 8);
                }
            }
        }

        g.dispose();
        response.setContentType("image/png");
        ImageIO.write(image, "png", response.getOutputStream());
    }
}