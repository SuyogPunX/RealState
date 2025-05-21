package com.web.controller;

import com.web.DAO.UserDAO;
import com.web.model.Booking;
import com.web.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO(); // Make sure this is initialized properly
        } catch (Exception e) {
            throw new ServletException("Error initializing UserDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("cart".equalsIgnoreCase(action)) {
            try {
                int userId = ((User) session.getAttribute("user")).getId();
                List<Booking> cartItems = userDAO.getBookingsByUserId(userId);
                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("/pages/my-cart.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}