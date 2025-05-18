package com.web.controller;

import com.web.DAO.AdminDAO;
import com.web.DAO.PropertyDAO;
import com.web.model.Property;
import com.web.model.Statistics;
import com.web.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        try {
            adminDAO = new AdminDAO();
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Error initializing AdminDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("yugui");

        HttpSession session = request.getSession(false);

        // Handle signout
        if ("signout".equals(action)) {
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            return;
        }

        // Route based on action
        switch (action == null ? "dashboard" : action) {
            case "dashboard":
                handleDashboard(request, response);
                break;
            case "properties":
			try {
				handleProperties(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            case "users":
                handleUsers(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    private void handleDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Statistics stats = adminDAO.getDashboardStatistics();
        List<Property> recentProperties = adminDAO.getRecentProperties();

        request.setAttribute("stats", stats);
        request.setAttribute("recentProperties", recentProperties);

        request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
    }

    private void handleProperties(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Property> allProperties = propertyDAO.getAllProperties(); // Make sure this exists in AdminDAO

        request.setAttribute("properties", allProperties);
        request.getRequestDispatcher("/pages/properties.jsp").forward(request, response);
    }

    private void handleUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> userList = adminDAO.getAllUsers(); // Make sure this exists in AdminDAO

        request.setAttribute("users", userList);
        request.getRequestDispatcher("/pages/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}