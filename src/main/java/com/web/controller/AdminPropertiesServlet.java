package com.web.controller;

import com.web.DAO.PropertyDAO;
import com.web.model.Property;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/adminproperties")
public class AdminPropertiesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyDAO propertyDAO;

    public void init() throws ServletException {
        try {
            propertyDAO = new PropertyDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing DAO", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            // Default behavior: show all properties
            showAllProperties(request, response);
        } else {
            switch (action) {
                case "view":
                    viewProperty(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                default:
                    showAllProperties(request, response);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            updateProperty(request, response);
        } else {
            try {
				addProperty(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
    }

    // === ACTIONS ===

    private void showAllProperties(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Property> allProperties = Collections.emptyList();

        try {
            allProperties = propertyDAO.getAllProperties();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error while fetching properties.");
        }

        // Apply filters and sorting logic here
        List<Property> filtered = allProperties.stream()
                .filter(p -> {
                    String location = request.getParameter("location");
                    return location == null || location.equals("All of Nepal") || p.getLocation().equalsIgnoreCase(location);
                })
                .filter(p -> {
                    String propertyType = request.getParameter("propertyType");
                    return propertyType == null || propertyType.equals("All Types") || getPropertyType(p).equals(propertyType);
                })
                .collect(Collectors.toList());

        // Sorting
        String sort = request.getParameter("sort");
        if ("priceAsc".equals(sort)) {
            filtered.sort(Comparator.comparingDouble(Property::getPrice));
        } else if ("priceDesc".equals(sort)) {
            filtered.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
        } else if ("areaAsc".equals(sort)) {
            filtered.sort(Comparator.comparingDouble(Property::getAreaSqft));
        } else if ("areaDesc".equals(sort)) {
            filtered.sort((a, b) -> Double.compare(b.getAreaSqft(), a.getAreaSqft()));
        } else {
            // Default: newest first
            filtered.sort((a, b) -> Integer.compare(b.getPropertyId(), a.getPropertyId()));
        }

//        // Pagination setup
//        int currentPage = 1;
//        String pageStr = request.getParameter("page");
//        try {
//            currentPage = Integer.parseInt(pageStr);
//        } catch (NumberFormatException ignored) {}
//
//        int pageSize = 6;
//        int totalItems = filtered.size();
//        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
//
//        int start = (currentPage - 1) * pageSize;
//        int end = Math.min(start + pageSize, totalItems);
//
//        List<Property> paginatedList = Collections.emptyList();
//        if (start < end && !filtered.isEmpty()) {
//            paginatedList = filtered.subList(start, end);
//        }

        // Set attributes for JSP
//        request.setAttribute("properties", paginatedList);
//        request.setAttribute("totalProperties", totalItems);
//        request.setAttribute("currentPage", currentPage);
//        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paramLocation", request.getParameter("location"));
        request.setAttribute("paramPropertyType", request.getParameter("propertyType"));
        request.setAttribute("paramMinPrice", request.getParameter("minPrice"));
        request.setAttribute("paramMaxPrice", request.getParameter("maxPrice"));
        request.setAttribute("paramMinArea", request.getParameter("minArea"));
        request.setAttribute("paramMaxArea", request.getParameter("maxArea"));
        request.setAttribute("paramSort", sort);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/properties.jsp");
        dispatcher.forward(request, response);
    }

    private void viewProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Property property = propertyDAO.getPropertyById(id);
            request.setAttribute("property", property);
            request.getRequestDispatcher("/pages/editProperty.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Property not found.");
        }
    }

    private void updateProperty(HttpServletRequest request, HttpServletResponse response)
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
//            response.sendRedirect(request.getContextPath() + "/adminproperties");
            
           
            response.sendRedirect("adminproperties");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update property: " + e.getMessage());
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }

    protected void addProperty(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        Property property = new Property();

        // String fields
        property.setTitle(request.getParameter("title"));
        property.setDescription(request.getParameter("description"));
        property.setLocation(request.getParameter("location"));
        property.setFurnishing(request.getParameter("furnishing"));
        property.setOwnerName(request.getParameter("ownerName"));
        property.setOwnerContact(request.getParameter("ownerContact"));
        property.setPrimaryImagePath(request.getParameter("primaryImagePath"));
        property.setPropertyType(request.getParameter("propertyType"));

        // Double fields
        property.setPrice(Double.parseDouble(request.getParameter("price")));
        property.setAreaSqft(Integer.parseInt(request.getParameter("areaSqft")));
        property.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        property.setLatitude(Double.parseDouble(request.getParameter("latitude")));

        // Integer fields
        property.setStorey(Integer.parseInt(request.getParameter("storey")));
        property.setBedrooms(Integer.parseInt(request.getParameter("bedrooms")));
        property.setBathrooms(Integer.parseInt(request.getParameter("bathrooms")));
        property.setYearBuilt(Integer.parseInt(request.getParameter("yearBuilt")));

        // Boolean fields
        property.setKitchen("true".equals(request.getParameter("kitchen")));
        property.setAvailable("true".equals(request.getParameter("available")));

        property.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

        propertyDAO.addProperty(property);
        response.sendRedirect("adminproperties");
    }

    // Helper method
    private String getPropertyType(Property p) {
        return p.getPropertyType(); 
    }
}