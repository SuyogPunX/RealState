package com.web.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.web.DAO.PropertyDAO;
import com.webmodel.Property;

@WebServlet("/property")
public class PropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyDAO propertyDAO;
    
    public PropertyServlet() {
        propertyDAO = new PropertyDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get filter parameters
        String location = request.getParameter("location");
        String propertyType = request.getParameter("propertyType");
        
        Double minPrice = null;
        Double maxPrice = null;
        Integer minBedrooms = null;
        Integer maxBedrooms = null;
        Integer minBathrooms = null;
        Integer maxBathrooms = null;
        Double minArea = null;
        Double maxArea = null;
        
        try {
            if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty()) {
                minPrice = Double.parseDouble(request.getParameter("minPrice"));
            }
            
            if (request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty()) {
                maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
            }
            
            // Parse bedroom filters
            if (request.getParameterValues("bedrooms") != null) {
                String[] bedroomFilters = request.getParameterValues("bedrooms");
                for (String filter : bedroomFilters) {
                    if (filter.equals("bed1")) minBedrooms = 1;
                    if (filter.equals("bed2")) minBedrooms = 2;
                    if (filter.equals("bed3")) minBedrooms = 3;
                    if (filter.equals("bed4")) minBedrooms = 4;
                }
            }
            
            // Parse bathroom filters
            if (request.getParameterValues("bathrooms") != null) {
                String[] bathroomFilters = request.getParameterValues("bathrooms");
                for (String filter : bathroomFilters) {
                    if (filter.equals("bath1")) minBathrooms = 1;
                    if (filter.equals("bath2")) minBathrooms = 2;
                    if (filter.equals("bath3")) minBathrooms = 3;
                }
            }
            
            if (request.getParameter("minArea") != null && !request.getParameter("minArea").isEmpty()) {
                minArea = Double.parseDouble(request.getParameter("minArea"));
            }
            
            if (request.getParameter("maxArea") != null && !request.getParameter("maxArea").isEmpty()) {
                maxArea = Double.parseDouble(request.getParameter("maxArea"));
            }
        } catch (NumberFormatException e) {
            // Handle parsing errors
            e.printStackTrace();
        }
        
        // Get sort parameter
        String sortBy = request.getParameter("sort");
        
        // Get pagination parameters
        int page = 1;
        int pageSize = 6; // Show 6 properties per page
        
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        // Get properties
        List<Property> properties = propertyDAO.getFilteredProperties(
                location, propertyType, minPrice, maxPrice, 
                minBedrooms, maxBedrooms, minBathrooms, maxBathrooms,
                minArea, maxArea, sortBy, page, pageSize);
        
        // Get total count for pagination
        int totalProperties = propertyDAO.getTotalFilteredPropertiesCount(
                location, propertyType, minPrice, maxPrice,
                minBedrooms, maxBedrooms, minBathrooms, maxBathrooms,
                minArea, maxArea);
        
        int totalPages = (int) Math.ceil((double) totalProperties / pageSize);
        
        // Set attributes for JSP
        request.setAttribute("properties", properties);
        request.setAttribute("totalProperties", totalProperties);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
        // Set filter attributes for preserving state
        request.setAttribute("location", location);
        request.setAttribute("propertyType", propertyType);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("minBedrooms", minBedrooms);
        request.setAttribute("maxBedrooms", maxBedrooms);
        request.setAttribute("minBathrooms", minBathrooms);
        request.setAttribute("maxBathrooms", maxBathrooms);
        request.setAttribute("minArea", minArea);
        request.setAttribute("maxArea", maxArea);
        request.setAttribute("sortBy", sortBy);
        
        request.getRequestDispatcher("/pages/buyProperties.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}