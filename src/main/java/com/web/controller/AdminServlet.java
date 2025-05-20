package com.web.controller;

import com.web.DAO.AdminDAO;
import com.web.DAO.PropertyDAO;
import com.web.DAO.UserDAO;
import com.web.model.Booking;
import com.web.model.Inquiries;
import com.web.model.Property;
import com.web.model.Statistics;
import com.web.model.User;
import com.web.model.UserRole;

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
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            adminDAO = new AdminDAO();
            propertyDAO = new PropertyDAO();
            userDAO = new UserDAO();
        } catch (ClassNotFoundException | SQLException e) {	
            throw new ServletException("Error initializing DAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "dashboard":
                case null:
                    showDashboard(request, response);
                    break;
                case "properties":
                    showProperties(request, response);
                    break;
                case "users":
                    showUsers(request, response);
                    break;
                case "inquiries":
                    showInquiries(request, response);
                    break;
                case "signout":
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not supported.");
            }
        } catch (SQLException ex) {
            throw new ServletException("Database error occurred", ex);
        }
    }

    private void showInquiries(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	List<Booking> inquiries = null;
		try {
			inquiries = userDAO.getAllBookings();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("inquiries", inquiries);
		request.getRequestDispatcher("/pages/inquiries.jsp").forward(request, response);
		
	}

	private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Statistics stats = adminDAO.getDashboardStatistics();
        List<Property> recentProperties = adminDAO.getRecentProperties();

        request.setAttribute("stats", stats);
        request.setAttribute("recentProperties", recentProperties);
        request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
    }

    private void showProperties(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Property> properties = propertyDAO.getAllProperties(); // Implement this method
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("/pages/properties.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<User> users = userDAO.getAllUsers();
        int totalUsers = users.size();

        // Count new users from last 30 days
        long thirtyDaysAgo = System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000);
        int newUsers = (int) users.stream()
                .filter(u -> u.getCreatedAt().getTime() > thirtyDaysAgo)
                .count();

        // Active vs Inactive
        int activeUsers = (int) users.stream()
                .filter(User::isActive)
                .count();
        int inactiveUsers = totalUsers - activeUsers;

        // Growth percentage
        int previousUsers = Math.max(totalUsers - newUsers, 1);
        double newUserGrowthPercentage = ((double) newUsers / previousUsers) * 100;

        // Distribution percentage
        double activeUserPercentage = 0.0;
        double inactiveUserPercentage = 0.0;

        if (totalUsers > 0) {
            activeUserPercentage = ((double) activeUsers / totalUsers) * 100;
            inactiveUserPercentage = ((double) inactiveUsers / totalUsers) * 100;
        }

        // Set request attributes
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("newUsers", newUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("inactiveUsers", inactiveUsers);
        request.setAttribute("newUserGrowthPercentage", newUserGrowthPercentage);
        request.setAttribute("activeUserPercentage", activeUserPercentage);
        request.setAttribute("inactiveUserPercentage", inactiveUserPercentage);

        // Forward to JSP
        request.getRequestDispatcher("/pages/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}