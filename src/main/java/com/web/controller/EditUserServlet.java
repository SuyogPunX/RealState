package com.web.controller;


import com.web.DAO.UserDAO;
import com.web.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editUser")
public class EditUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            userDAO = new UserDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing DAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        User user = null;
		try {
			user = userDAO.getUserById(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("user", user);
		request.getRequestDispatcher("/pages/editUser.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String statusStr = request.getParameter("status");
        boolean status = Boolean.parseBoolean(statusStr); // Converts to boolean

        try {
            userDAO.updateUserStatus(userId, status);
            response.sendRedirect(request.getContextPath() + "/admin?action=users");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update user status.");
            request.getRequestDispatcher("/pages/editUser.jsp").forward(request, response);
        }
    }
}