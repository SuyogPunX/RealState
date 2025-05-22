package com.web.DAO;

import com.web.database.DatabaseConnection;
import com.web.model.Property;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
public class PropertyDAO {
	
	private Connection conn= null;
    public PropertyDAO() throws ClassNotFoundException, SQLException {
		conn = DatabaseConnection.getConnection();
	}

	/**
     * Fetches filtered list of properties with pagination.
     * @throws ClassNotFoundException 
     */
    public List<Property> getFilteredProperties(
            String location, String propertyType,
            Double minPrice, Double maxPrice,
            Integer bedrooms, Integer bathrooms,
            Double minArea, Double maxArea,
            String sort, int page, int pageSize) throws SQLException, ClassNotFoundException {

        List<Property> properties = new ArrayList<>();

        StringBuilder query = new StringBuilder("""
             SELECT 
        p.propertyId, p.title, p.description, p.location, p.price, p.areaSqft,
        p.storey, p.bedrooms, p.bathrooms, p.kitchen, p.available, p.createdAt,
        p.yearBuilt, p.furnishing, p.ownerName, p.ownerContact, p.longitude, p.latitude,
        p.primaryImagePath
    FROM properties p
    WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        // Apply location filter
        if (location != null && !location.equals("All of Nepal")) {
            query.append(" AND p.location = ?");
            params.add(location);
        }

    
        // Apply property type filter
        if (propertyType != null && !propertyType.equals("All Types")) {
            query.append(" AND p.propertyType = ?");
            params.add(propertyType);
        }

        // Price Range Filters
        if (minPrice != null) {
            query.append(" AND p.price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            query.append(" AND p.price <= ?");
            params.add(maxPrice);
        }

        // Bedroom Filters
        if (bedrooms != null) {
            switch (bedrooms) {
                case 1 -> query.append(" AND p.bedrooms = 1");
                case 2 -> query.append(" AND p.bedrooms = 2");
                case 3 -> query.append(" AND p.bedrooms = 3");
                case 4 -> query.append(" AND p.bedrooms >= 4");
            }
        }

        // Bathroom Filters
        if (bathrooms != null) {
            switch (bathrooms) {
                case 1 -> query.append(" AND p.bathrooms = 1");
                case 2 -> query.append(" AND p.bathrooms = 2");
                case 3 -> query.append(" AND p.bathrooms >= 3");
            }
        }

        // Area Filters
        if (minArea != null) {
            query.append(" AND p.areaSqft >= ?");
            params.add(minArea);
        }
        if (maxArea != null) {
            query.append(" AND p.areaSqft <= ?");
            params.add(maxArea);
        }

        // Sorting
        if ("priceAsc".equals(sort)) {
            query.append(" ORDER BY p.price ASC");
        } else if ("priceDesc".equals(sort)) {
            query.append(" ORDER BY p.price DESC");
        } else if ("areaAsc".equals(sort)) {
            query.append(" ORDER BY p.areaSqft ASC");
        } else if ("areaDesc".equals(sort)) {
            query.append(" ORDER BY p.areaSqft DESC");
        } else {
            query.append(" ORDER BY p.createdAt DESC");
        }

        // Pagination
        int offset = (page - 1) * pageSize;
        query.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(offset);

        try (
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("propertyId"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setLocation(rs.getString("location"));
                property.setPrice(rs.getDouble("price"));
                property.setAreaSqft(rs.getDouble("areaSqft"));
                property.setStorey(rs.getInt("storey"));
                property.setBedrooms(rs.getInt("bedrooms"));
                property.setBathrooms(rs.getInt("bathrooms"));
                property.setKitchen(rs.getBoolean("kitchen"));
                property.setAvailable(rs.getBoolean("available"));
                property.setCreatedAt(rs.getTimestamp("createdAt"));
                property.setYearBuilt(rs.getInt("yearBuilt"));
                property.setFurnishing(rs.getString("furnishing"));
                property.setOwnerName(rs.getString("ownerName"));
                property.setOwnerContact(rs.getString("ownerContact"));
                property.setLongitude(rs.getDouble("longitude"));
                property.setLatitude(rs.getDouble("latitude"));
                property.setPrimaryImagePath(rs.getString("primaryImagePath"));

                properties.add(property);
            }
        }

        return properties;
    }

    /**
     * Gets total count of properties matching the filters.
     * @throws ClassNotFoundException 
     */
    public int getTotalFilteredCount(
            String location, String propertyType,
            Double minPrice, Double maxPrice,
            Integer minBedrooms, Integer minBathrooms,
            Double minArea, Double maxArea) throws SQLException, ClassNotFoundException {

        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM properties WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Location filter
        if (location != null && !location.equals("All of Nepal")) {
            query.append(" AND location = ?");
            params.add(location);
        }

        // Property type filter
        if (propertyType != null && !propertyType.equals("All Types")) {
            query.append(" AND propertyType = ?");
            params.add(propertyType);
        }

        // Price range filters
        if (minPrice != null) {
            query.append(" AND price >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            query.append(" AND price <= ?");
            params.add(maxPrice);
        }

        // Bedroom filter (at least X bedrooms)
        if (minBedrooms != null) {
            query.append(" AND bedrooms >= ?");
            params.add(minBedrooms);
        }

        // Bathroom filter (at least X bathrooms)
        if (minBathrooms != null) {
            query.append(" AND bathrooms >= ?");
            params.add(minBathrooms);
        }

        // Area (sqft) filters
        if (minArea != null) {
            query.append(" AND areaSqft >= ?");
            params.add(minArea);
        }
        if (maxArea != null) {
            query.append(" AND areaSqft <= ?");
            params.add(maxArea);
        }

        // Execute query
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }

        return 0;
    }

    /**
     * Fetch top 3 most recently added properties
     */
    public List<Property> getRecentProperties() {
        List<Property> properties = new ArrayList<>();
        String query = "SELECT * FROM properties ORDER BY propertyId DESC LIMIT 3";

        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Property p = new Property();
                p.setPropertyId(rs.getInt("propertyId"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPropertyType(rs.getString("propertyType"));
                p.setLocation(rs.getString("location"));
                p.setPrice(rs.getDouble("price"));
                p.setAreaSqft(rs.getDouble("areaSqft"));
                p.setBedrooms(rs.getInt("bedrooms"));
                p.setBathrooms(rs.getInt("bathrooms"));
                p.setStorey(rs.getInt("storey"));
                p.setKitchen(rs.getBoolean("kitchen"));
                p.setAvailable(rs.getBoolean("available"));
                p.setCreatedAt(rs.getTimestamp("createdAt"));
                p.setYearBuilt(rs.getInt("yearBuilt"));
                p.setFurnishing(rs.getString("furnishing"));
                p.setOwnerName(rs.getString("ownerName"));
                p.setOwnerContact(rs.getString("ownerContact"));
                p.setLongitude(rs.getDouble("longitude"));
                p.setLatitude(rs.getDouble("latitude"));

                // Image handling
                p.setPrimaryImagePath(rs.getString("primaryImagePath"));
                

                properties.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }
    public List<Property> getAllProperties() throws SQLException {
        List<Property> properties = new ArrayList<>();

             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM properties"); 

            while (rs.next()) {
                Property p = new Property();
                p.setPropertyId(rs.getInt("propertyId"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPropertyType(rs.getString("propertyType"));
                p.setLocation(rs.getString("location"));
                p.setPrice(rs.getDouble("price"));
                p.setAreaSqft(rs.getDouble("areaSqft"));
                p.setStorey(rs.getInt("storey"));
                p.setBedrooms(rs.getInt("bedrooms"));
                p.setBathrooms(rs.getInt("bathrooms"));
                p.setKitchen(rs.getBoolean("kitchen"));
                p.setAvailable(rs.getBoolean("available"));
                p.setCreatedAt(rs.getTimestamp("createdAt"));
                p.setYearBuilt(rs.getInt("yearBuilt"));
                p.setFurnishing(rs.getString("furnishing"));
                p.setOwnerName(rs.getString("ownerName"));
                p.setOwnerContact(rs.getString("ownerContact"));
                p.setLongitude(rs.getDouble("longitude"));
                p.setLatitude(rs.getDouble("latitude"));

                // Assuming one primary image path stored as string
                p.setPrimaryImagePath(rs.getString("primaryImagePath"));
                properties.add(p);
            }

        return properties;
    }
    

    public boolean addProperty(Property property) throws SQLException {
        String sql = "INSERT INTO properties (title, description,  location, price, areaSqft, storey, bedrooms, bathrooms, kitchen, available, createdAt, yearBuilt, furnishing, ownerName, ownerContact, longitude, latitude, primaryImagePath,propertyType) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        try {
				stmt.setString(1, property.getTitle());
				stmt.setString(2, property.getDescription());
	            stmt.setString(3, property.getLocation());
	            stmt.setDouble(4, property.getPrice());
	            stmt.setDouble(5, property.getAreaSqft());
	            stmt.setInt(6, property.getStorey());
	            stmt.setInt(7, property.getBedrooms());
	            stmt.setInt(8, property.getBathrooms());
	            stmt.setBoolean(9, property.isKitchen());
	            stmt.setBoolean(10, property.isAvailable());
	            stmt.setTimestamp(11, property.getCreatedAt());
	            stmt.setInt(12, property.getYearBuilt());
	            stmt.setString(13, property.getFurnishing());
	            stmt.setString(14, property.getOwnerName());
	            stmt.setString(15, property.getOwnerContact());
	            stmt.setDouble(16, property.getLongitude());
	            stmt.setDouble(17, property.getLatitude());
	            stmt.setString(18, property.getPrimaryImagePath());
	            stmt.setString(19, property.getPropertyType());
	            

	            int rowsAffected=stmt.executeUpdate();
			    return rowsAffected>0;

			}catch(SQLException e){
				e.printStackTrace();
			}
			return false;

    }

    public List<Property> getPropertiesByIds(List<Integer> cart) throws SQLException {
        List<Property> properties = new ArrayList<>();

        if (cart == null || cart.isEmpty()) {
            return properties; // return empty list if no IDs
        }

        // Build IN clause with placeholders: (?, ?, ?)
        String inPlaceholders = String.join(",", Collections.nCopies(cart.size(), "?"));

        String sql = "SELECT propertyId, title,propertyType, location, price, areaSqft, bedrooms, bathrooms, available, primaryImagePath " +
                     "FROM properties " +
                     "WHERE propertyId IN (" + inPlaceholders + ")";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            // Set each property ID into the placeholders
            for (int i = 0; i < cart.size(); i++) {
                pstmt.setInt(i + 1, cart.get(i));
            }

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Property p = new Property();
                p.setPropertyId(rs.getInt("propertyId"));
                p.setTitle(rs.getString("title"));
                p.setLocation(rs.getString("location"));
                p.setPrice(rs.getDouble("price"));
                p.setAreaSqft(rs.getDouble("areaSqft"));
                p.setBedrooms(rs.getInt("bedrooms"));
                p.setBathrooms(rs.getInt("bathrooms"));
                p.setAvailable(rs.getBoolean("available"));
                p.setPrimaryImagePath(rs.getString("primaryImagePath"));

                // Skip unnecessary fields like description, owner info, etc.
                properties.add(p);
            }
        }

        return properties;
    }

    public List<Property> getPropertiesByType(String propertyType, int limit) throws ClassNotFoundException {
        List<Property> properties = new ArrayList<>();

        String query = "SELECT * FROM properties WHERE propertyType = ? LIMIT ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, propertyType);
            stmt.setInt(2, limit);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Property property = new Property();
                property.setPropertyId(rs.getInt("propertyId"));
                property.setTitle(rs.getString("title"));
                property.setDescription(rs.getString("description"));
                property.setLocation(rs.getString("location"));
                property.setPrice(rs.getDouble("price"));
                property.setAreaSqft(rs.getInt("areaSqft"));
                property.setStorey(rs.getInt("storey"));
                property.setBedrooms(rs.getInt("bedrooms"));
                property.setBathrooms(rs.getInt("bathrooms"));
                property.setKitchen(rs.getBoolean("kitchen"));
                property.setAvailable(rs.getBoolean("available"));
                property.setCreatedAt(rs.getTimestamp("createdAt"));
                property.setYearBuilt(rs.getInt("yearBuilt"));
                property.setFurnishing(rs.getString("furnishing"));
                property.setOwnerName(rs.getString("ownerName"));
                property.setOwnerContact(rs.getString("ownerContact"));
                property.setLongitude(rs.getDouble("longitude"));
                property.setLatitude(rs.getDouble("latitude"));
                property.setPrimaryImagePath(rs.getString("primaryImagePath"));
                property.setPropertyType(rs.getString("propertyType"));

                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return properties;
    }

    public Property getPropertyById(int id) throws SQLException {
        String sql = "SELECT * FROM properties WHERE propertyId = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Property p = new Property();
                p.setPropertyId(rs.getInt("propertyId"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setLocation(rs.getString("location"));
                p.setPrice(rs.getDouble("price"));
                p.setAreaSqft(rs.getDouble("areaSqft"));
                p.setStorey(rs.getInt("storey"));
                p.setBedrooms(rs.getInt("bedrooms"));
                p.setBathrooms(rs.getInt("bathrooms"));
                p.setKitchen(rs.getBoolean("kitchen"));
                p.setAvailable(rs.getBoolean("available"));
                p.setCreatedAt(rs.getTimestamp("createdAt"));
                p.setYearBuilt(rs.getInt("yearBuilt"));
                p.setFurnishing(rs.getString("furnishing"));
                p.setOwnerName(rs.getString("ownerName"));
                p.setOwnerContact(rs.getString("ownerContact"));
                p.setLongitude(rs.getDouble("longitude"));
                p.setLatitude(rs.getDouble("latitude"));
                p.setPrimaryImagePath(rs.getString("primaryImagePath"));
                p.setPropertyType(rs.getString("propertyType"));

                return p;
            } else {
                return null; // No property found
            }
        }
    }

	public void updateProperty(Property property) throws SQLException {
		String sql = "UPDATE properties SET available = ? WHERE propertyId = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setBoolean(1, property.isAvailable());
	        stmt.setInt(2, property.getPropertyId());

	        int rowsAffected = stmt.executeUpdate();
	        if (rowsAffected == 0) {
	            throw new SQLException("Property not found for update.");
	        }
	    }
	}
}
    
    
    
    

	


