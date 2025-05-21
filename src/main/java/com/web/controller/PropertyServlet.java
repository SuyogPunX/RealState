package com.web.controller;

import com.web.DAO.PropertyDAO;
import com.web.model.Property;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/propertyServlet")
public class PropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyDAO propertyDAO;

    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception  e) {
            throw new ServletException("Error initializing PropertyDAO", (Throwable) e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    	
        String location = request.getParameter("location");
        String propertyType = request.getParameter("propertyType");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String bedroomsStr = request.getParameter("bedrooms");
        String bathroomsStr = request.getParameter("bathrooms");
        String minAreaStr = request.getParameter("minArea");
        String maxAreaStr = request.getParameter("maxArea");
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");

        // Apply defaults
        if (location == null || location.isEmpty()) {
                location = "All of Nepal";
           }
          if (propertyType == null || propertyType.isEmpty()) {
                propertyType = "All Types";
           }

        int currentPage = 1;
        try {
            if (pageStr != null && !pageStr.isEmpty()) currentPage = Integer.parseInt(pageStr);
        } catch (NumberFormatException ignored) {}

        // Parse filter values
        Double minPrice = parseDouble(minPriceStr);
        Double maxPrice = parseDouble(maxPriceStr);
        Double minArea = parseDouble(minAreaStr);
        Double maxArea = parseDouble(maxAreaStr);

        Integer bedrooms = null;
        if ("bed1".equals(bedroomsStr)) bedrooms = 1;
        else if ("bed2".equals(bedroomsStr)) bedrooms = 2;
        else if ("bed3".equals(bedroomsStr)) bedrooms = 3;
        else if ("bed4".equals(bedroomsStr)) bedrooms = 4;

        Integer bathrooms = null;
        if ("bath1".equals(bathroomsStr)) bathrooms = 1;
        else if ("bath2".equals(bathroomsStr)) bathrooms = 2;
        else if ("bath3".equals(bathroomsStr)) bathrooms = 3;

        int pageSize = 6;

        try {
            List<Property> properties = propertyDAO.getFilteredProperties(
                    location, propertyType, minPrice, maxPrice,
                    bedrooms, bathrooms, minArea, maxArea, sort, currentPage, pageSize);

            int totalProperties = propertyDAO.getTotalFilteredCount(
                    location, propertyType, minPrice, maxPrice,
                    bedrooms, bathrooms, minArea, maxArea);

            int totalPages = (int) Math.ceil((double) totalProperties / pageSize);

            // Set attributes
            request.setAttribute("properties", properties);
            request.setAttribute("totalProperties", totalProperties);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("paramLocation", location);
            request.setAttribute("paramPropertyType", propertyType);
            request.setAttribute("paramMinPrice", minPriceStr);
            request.setAttribute("paramMaxPrice", maxPriceStr);
            request.setAttribute("paramMinArea", minAreaStr);
            request.setAttribute("paramMaxArea", maxAreaStr);
            request.setAttribute("paramSort", sort);
            request.setAttribute("paramBedrooms", bedroomsStr);
            request.setAttribute("paramBathrooms", bathroomsStr);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("properties", Collections.emptyList());
            request.setAttribute("totalProperties", 0);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/buy.jsp");
        dispatcher.forward(request, response);
    }

    private Double parseDouble(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}