package com.web.DAO;

import com.web.database.DatabaseConnection;
import com.webmodel.Property;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

public class PropertyDAO {
    
    private Connection conn;
    
    public PropertyDAO() throws ClassFormatException, SQLException, ClassNotFoundException {
        this.conn = DatabaseConnection.getConnection();
    }
    
    /**
     * Get properties with filtering options and pagination
     */
    public List<Property> getFilteredProperties(
            String location, String propertyType, String budget, Double minPrice, Double maxPrice,
            Double minArea, Double maxArea, String[] bedrooms, String[] bathrooms,
            String sortBy, int page, int pageSize) {
        
        List<Property> properties = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM property WHERE available = true");
        
        List<Object> params = new ArrayList<>();
        
        // Add location filter
        if (location != null && !location.equals("All of Nepal")) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location + "%");
        }
        
        // Add property type filter
        if (propertyType != null && !propertyType.equals("All Types")) {
            sql.append(" AND title LIKE ?"); // Assuming title contains property type info
            params.add("%" + propertyType + "%");
        }
        
        // Price range
        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }
        
        // Handle budget dropdown selection
        if (minPrice == null && maxPrice == null && budget != null) {
            if (!budget.equals("Any Budget")) {
                if (budget.equals("Below 5,000,000")) {
                    sql.append(" AND price < 5000000");
                } else if (budget.equals("5,000,000 - 10,000,000")) {
                    sql.append(" AND price >= 5000000 AND price <= 10000000");
                } else if (budget.equals("10,000,000 - 20,000,000")) {
                    sql.append(" AND price >= 10000000 AND price <= 20000000");
                } else if (budget.equals("20,000,000 - 50,000,000")) {
                    sql.append(" AND price >= 20000000 AND price <= 50000000");
                } else if (budget.equals("Above 50,000,000")) {
                    sql.append(" AND price > 50000000");
                }
            }
        }
        
        // Area range
        if (minArea != null) {
            sql.append(" AND area_sqft >= ?");
            params.add(minArea);
        }
        
        if (maxArea != null) {
            sql.append(" AND area_sqft <= ?");
            params.add(maxArea);
        }
        
        // Bedrooms
        if (bedrooms != null && bedrooms.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < bedrooms.length; i++) {
                if (i > 0) sql.append(" OR ");
                
                if (bedrooms[i].equals("4")) {
                    // 4+ bedrooms
                    sql.append("bedrooms >= ?");
                    params.add(4);
                } else {
                    sql.append("bedrooms = ?");
                    params.add(Integer.parseInt(bedrooms[i]));
                }
            }
            sql.append(")");
        }
        
        // Bathrooms
        if (bathrooms != null && bathrooms.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < bathrooms.length; i++) {
                if (i > 0) sql.append(" OR ");
                
                if (bathrooms[i].equals("3")) {
                    // 3+ bathrooms
                    sql.append("bathrooms >= ?");
                    params.add(3);
                } else {
                    sql.append("bathrooms = ?");
                    params.add(Integer.parseInt(bathrooms[i]));
                }
            }
            sql.append(")");
        }
        
        // Sorting
        if (sortBy != null) {
            switch (sortBy) {
                case "price_asc":
                    sql.append(" ORDER BY price ASC");
                    break;
                case "price_desc":
                    sql.append(" ORDER BY price DESC");
                    break;
                case "area_asc":
                    sql.append(" ORDER BY area_sqft ASC");
                    break;
                case "area_desc":
                    sql.append(" ORDER BY area_sqft DESC");
                    break;
                default:
                    sql.append(" ORDER BY created_at DESC"); // Default (newest)
                    break;
            }
        } else {
            sql.append(" ORDER BY created_at DESC"); // Default ordering
        }
        
        // Add pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);
        
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                properties.add(mapResultSetToProperty(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
    
    /**
     * Count total properties matching the filter criteria
     */
    public int countFilteredProperties(
            String location, String propertyType, String budget, Double minPrice, Double maxPrice,
            Double minArea, Double maxArea, String[] bedrooms, String[] bathrooms) {
        
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM property WHERE available = true");
        
        List<Object> params = new ArrayList<>();
        
        // Add location filter
        if (location != null && !location.equals("All of Nepal")) {
            sql.append(" AND location LIKE ?");
            params.add("%" + location + "%");
        }
        
        // Add property type filter
        if (propertyType != null && !propertyType.equals("All Types")) {
            sql.append(" AND title LIKE ?");
            params.add("%" + propertyType + "%");
        }
        
        // Price range
        if (minPrice != null) {
            sql.append(" AND price >= ?");
            params.add(minPrice);
        }
        
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
            params.add(maxPrice);
        }
        
        // Handle budget dropdown selection
        if (minPrice == null && maxPrice == null && budget != null) {
            if (!budget.equals("Any Budget")) {
                if (budget.equals("Below 5,000,000")) {
                    sql.append(" AND price < 5000000");
                } else if (budget.equals("5,000,000 - 10,000,000")) {
                    sql.append(" AND price >= 5000000 AND price <= 10000000");
                } else if (budget.equals("10,000,000 - 20,000,000")) {
                    sql.append(" AND price >= 10000000 AND price <= 20000000");
                } else if (budget.equals("20,000,000 - 50,000,000")) {
                    sql.append(" AND price >= 20000000 AND price <= 50000000");
                } else if (budget.equals("Above 50,000,000")) {
                    sql.append(" AND price > 50000000");
                }
            }
        }
        
        // Area range
        if (minArea != null) {
            sql.append(" AND area_sqft >= ?");
            params.add(minArea);
        }
        
        if (maxArea != null) {
            sql.append(" AND area_sqft <= ?");
            params.add(maxArea);
        }
        
        // Bedrooms
        if (bedrooms != null && bedrooms.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < bedrooms.length; i++) {
                if (i > 0) sql.append(" OR ");
                
                if (bedrooms[i].equals("4")) {
                    // 4+ bedrooms
                    sql.append("bedrooms >= ?");
                    params.add(4);
                } else {
                    sql.append("bedrooms = ?");
                    params.add(Integer.parseInt(bedrooms[i]));
                }
            }
            sql.append(")");
        }
        
        // Bathrooms
        if (bathrooms != null && bathrooms.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < bathrooms.length; i++) {
                if (i > 0) sql.append(" OR ");
                
                if (bathrooms[i].equals("3")) {
                    // 3+ bathrooms
                    sql.append("bathrooms >= ?");
                    params.add(3);
                } else {
                    sql.append("bathrooms = ?");
                    params.add(Integer.parseInt(bathrooms[i]));
                }
            }
            sql.append(")");
        }
        
        int count = 0;
        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }

    /**
     * Get a property by ID
     */
    public Property getPropertyById(int propertyId) {
        String sql = "SELECT * FROM property WHERE property_id = ?";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, propertyId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToProperty(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Map ResultSet to Property object based on the actual database schema
     */
    private Property mapResultSetToProperty(ResultSet rs) throws SQLException {
        Property property = new Property();
        
        property.setPropertyId(rs.getInt("property_id"));
        property.setTitle(rs.getString("title"));
        property.setDescription(rs.getString("description"));
        property.setLocation(rs.getString("location"));
        property.setPrice(rs.getDouble("price"));
        property.setAreaSqft(rs.getDouble("area_sqft"));
        property.setStorey(rs.getInt("storey"));
        property.setBedrooms(rs.getInt("bedrooms"));
        property.setBathrooms(rs.getInt("bathrooms"));
        property.setKitchen(rs.getBoolean("kitchen"));
        property.setAvailable(rs.getBoolean("available"));
        property.setCreatedAt(rs.getString("created_at"));
        property.setYearBuilt(rs.getInt("year_built"));
        property.setFurnishing(rs.getString("furnishing"));
        property.setOwnerName(rs.getString("owner_name"));
        property.setOwnerContact(rs.getString("owner_contact"));
        property.setLongitude(rs.getDouble("longitude"));
        property.setLatitude(rs.getDouble("latitude"));
        
        return property;
    }
}