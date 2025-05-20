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

@WebServlet("/viewProperty")
public class ViewPropertyServlet extends HttpServlet {
    private PropertyDAO propertyDAO;

    @Override
    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing DAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Property property = propertyDAO.getPropertyById(id);
            request.setAttribute("property", property);
            request.getRequestDispatcher("/pages/viewProperty.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Property not found.");
        }
    }
}
