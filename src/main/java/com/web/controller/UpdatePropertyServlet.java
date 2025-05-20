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

@WebServlet("/updateProperty")
public class UpdatePropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing DAO", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));

        try {
            Property property = propertyDAO.getPropertyById(propertyId);
            property.setAvailable("on".equals(request.getParameter("available")));

            propertyDAO.updateProperty(property);

            response.sendRedirect(request.getContextPath() + "/admin?action=properties");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update property");
        }
    }
}