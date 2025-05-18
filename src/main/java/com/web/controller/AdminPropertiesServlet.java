package com.web.controller;

import com.web.DAO.*;
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

    public void init() {
        try {
			propertyDAO = new PropertyDAO();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // Initialize DAO
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get filter and sort parameters
        String location = request.getParameter("location");
        String propertyType = request.getParameter("propertyType");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String minAreaStr = request.getParameter("minArea");
        String maxAreaStr = request.getParameter("maxArea");
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");

        int currentPage = 1;
        try {
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException ignored) {}

        // Fetch all properties from DB
        List<Property> allProperties = null;;
		try {
			allProperties = propertyDAO.getAllProperties();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Apply Filters
        List<Property> filtered = allProperties.stream()
                .filter(p -> location == null || location.equals("All of Nepal") || p.getLocation().equalsIgnoreCase(location))
                .filter(p -> propertyType == null || propertyType.equals("All Types") || getPropertyType(p).equals(propertyType))
                .filter(p -> minPriceStr == null || minPriceStr.isEmpty() || p.getPrice() >= Double.parseDouble(minPriceStr))
                .filter(p -> maxPriceStr == null || maxPriceStr.isEmpty() || p.getPrice() <= Double.parseDouble(maxPriceStr))
                .filter(p -> minAreaStr == null || minAreaStr.isEmpty() || p.getAreaSqft() >= Double.parseDouble(minAreaStr))
                .filter(p -> maxAreaStr == null || maxAreaStr.isEmpty() || p.getAreaSqft() <= Double.parseDouble(maxAreaStr))
                .collect(Collectors.toList());

        // Sorting
        if ("priceAsc".equals(sort)) {
            filtered.sort(Comparator.comparingDouble(Property::getPrice));
        } else if ("priceDesc".equals(sort)) {
            filtered.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
        } else if ("areaAsc".equals(sort)) {
            filtered.sort(Comparator.comparingDouble(Property::getAreaSqft));
        } else if ("areaDesc".equals(sort)) {
            filtered.sort((a, b) -> Double.compare(b.getAreaSqft(), a.getAreaSqft()));
        } else {
            // Default: newest first (assuming higher ID is newer)
            filtered.sort((a, b) -> Integer.compare(b.getPropertyId(), a.getPropertyId()));
        }

        // Pagination setup
        int pageSize = 6;
        int totalItems = filtered.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);

        List<Property> paginatedList = filtered.subList(start, end);

        // Set attributes
        request.setAttribute("properties", paginatedList);
        request.setAttribute("totalProperties", totalItems);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paramLocation", location);
        request.setAttribute("paramPropertyType", propertyType);
        request.setAttribute("paramMinPrice", minPriceStr);
        request.setAttribute("paramMaxPrice", maxPriceStr);
        request.setAttribute("paramMinArea", minAreaStr);
        request.setAttribute("paramMaxArea", maxAreaStr);
        request.setAttribute("paramSort", sort);

        // Forward to admin properties JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/properties.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Property property = new Property();

        // String fields - safe to assign directly
        property.setTitle(request.getParameter("title"));
        property.setDescription(request.getParameter("description"));
        property.setLocation(request.getParameter("location"));
        property.setFurnishing(request.getParameter("furnishing"));
        property.setOwnerName(request.getParameter("ownerName"));
        property.setOwnerContact(request.getParameter("ownerContact"));
        property.setPrimaryImagePath(request.getParameter("primaryImagePath"));

        // Double fields with validation
        try {
            property.setPrice(Double.parseDouble(request.getParameter("price")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setPrice(0.0); // Default value
        }

        try {
            property.setAreaSqft(Double.parseDouble(request.getParameter("areaSqft")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setAreaSqft(0.0);
        }

        try {
            property.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setLongitude(0.0);
        }

        try {
            property.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setLatitude(0.0);
        }

        // Integer fields with validation
        try {
            property.setStorey(Integer.parseInt(request.getParameter("storey")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setStorey(0);
        }

        try {
            property.setBedrooms(Integer.parseInt(request.getParameter("bedrooms")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setBedrooms(0);
        }

        try {
            property.setBathrooms(Integer.parseInt(request.getParameter("bathrooms")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setBathrooms(0);
        }

        try {
            property.setYearBuilt(Integer.parseInt(request.getParameter("yearBuilt")));
        } catch (NumberFormatException | NullPointerException ignored) {
            property.setYearBuilt(0);
        }

        // Boolean fields
        property.setKitchen("on".equals(request.getParameter("kitchen")));
        property.setAvailable("on".equals(request.getParameter("available")));
        
        // Timestamp: set automatically if not provided by form
        property.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

        // Add property to DB
        try {
            new PropertyDAO().addProperty(property);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding property: " + e.getMessage());
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
            return;
        }

        // Redirect instead of forward to prevent re-submission on refresh
        response.sendRedirect("adminproperties");
    }
    private String getPropertyType(Property p) {
        if (p.getTitle().contains("Apartment")) return "Apartment";
        if (p.getTitle().contains("Land")) return "Land";
        if (p.getTitle().contains("Commercial")) return "Commercial";
        return "House";
    }
}