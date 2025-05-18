package com.web.controller;

import com.web.DAO.PropertyDAO;
import com.web.model.Property;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;


@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing PropertyDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("HomeServlet.doGet() called at lakkad ");

        // Load recent properties (e.g., latest 3)
        List<Property> recentProperties = Collections.emptyList();
        try {
            recentProperties = propertyDAO.getRecentProperties(); // Limit to 3
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("recentProperties", recentProperties);

        // Load top 3 apartments
        List<Property> apartments = Collections.emptyList();
        try {
            apartments = propertyDAO.getPropertiesByType("Apartment", 3);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("apartments", apartments);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/home.jsp");
        dispatcher.forward(request, response);
    }
}