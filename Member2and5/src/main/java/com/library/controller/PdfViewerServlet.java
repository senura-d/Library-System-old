package com.library.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/pdf-viewer")
public class PdfViewerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            return;
        }

        String file = request.getParameter("file");

        File pdf = new File("C:/library_pdfs/" + file);
        response.setContentType("application/pdf");

        try (FileInputStream fis = new FileInputStream(pdf);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytes;
            while ((bytes = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytes);
            }
        }
    }
}

/* 
Store PDFs Here
C:/library_pdfs/
 */