package com.web.controller;

import com.web.DAO.AdminDAO;
import com.webmodel.House;
import com.webmodel.Statistics;
import com.webmodel.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    public void init() {
        try {
            adminDAO = new AdminDAO();
        } catch (ClassFormatException | ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Handle signout
        if ("signout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return;
        }

        HttpSession session = request.getSession(false);

        // Check if session exists and user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return;
        }

        // Fetch dashboard statistics and recent properties
        Statistics stats = adminDAO.getDashboardStatistics();
        List<House> recentProperties = adminDAO.getRecentProperties();

        // Set attributes for use in JSP
        request.setAttribute("stats", stats);
        request.setAttribute("recentProperties", recentProperties);

        // Forward to the admin dashboard page
        request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
