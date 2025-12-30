package com.library;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/QRServlet")
public class QRServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if(id == null) id = "No ID";

        byte[] qrCode = QRCodeGenerator.getQRCodeImage(id, 200, 200);

        if (qrCode != null) {
            response.setContentType("image/png");
            try (OutputStream os = response.getOutputStream()) {
                os.write(qrCode);
                os.flush();
            }
        }
    }
}