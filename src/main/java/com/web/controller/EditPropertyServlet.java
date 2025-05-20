package com.web.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.web.DAO.PropertyDAO;
import com.web.model.Property;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/editProperty")
public class EditPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing DAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id;

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
            return;
        }

        try {
            Property property = propertyDAO.getPropertyById(id);
            request.setAttribute("property", property);
            request.getRequestDispatcher("/pages/editProperty.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Property not found in database");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));

        try {
            // Get current property from DB
            Property property = propertyDAO.getPropertyById(propertyId);

            // Update only the 'available' field
            boolean available = "true".equals(request.getParameter("available"));
            property.setAvailable(available);

            // Save back to DB
            propertyDAO.updateProperty(property);

            // Redirect back to properties list
            response.sendRedirect(request.getContextPath() + "/adminproperties");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update property status: " + e.getMessage());
        }
    }
}