package com.web.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.web.database.DatabaseConnection;
import com.webmodel.Property;

public class PropertyDAO {
    
    // Get all properties with filtering options
    public List<Property> getFilteredProperties(String location, String propertyType, 
                                               Double minPrice, Double maxPrice,
                                               Integer minBedrooms, Integer maxBedrooms,
                                               Integer minBathrooms, Integer maxBathrooms,
                                               Double minArea, Double maxArea,
                                               String sortBy, int page, int pageSize) {
        
        List<Property> properties = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT * FROM properties WHERE 1=1");
            
            List<Object> params = new ArrayList<>();
            
            // Add filters
            if (location != null && !location.equals("All of Nepal")) {
                sqlBuilder.append(" AND location LIKE ?");
                params.add("%" + location + "%");
            }
            
            if (propertyType != null && !propertyType.equals("All Types")) {
                sqlBuilder.append(" AND title LIKE ?");
                params.add("%" + propertyType + "%");
            }
            
            if (minPrice != null) {
                sqlBuilder.append(" AND price >= ?");
                params.add(minPrice);
            }
            
            if (maxPrice != null) {
                sqlBuilder.append(" AND price <= ?");
                params.add(maxPrice);
            }
            
            if (minBedrooms != null) {
                sqlBuilder.append(" AND bedrooms >= ?");
                params.add(minBedrooms);
            }
            
            if (maxBedrooms != null) {
                sqlBuilder.append(" AND bedrooms <= ?");
                params.add(maxBedrooms);
            }
            
            if (minBathrooms != null) {
                sqlBuilder.append(" AND bathrooms >= ?");
                params.add(minBathrooms);
            }
            
            if (maxBathrooms != null) {
                sqlBuilder.append(" AND bathrooms <= ?");
                params.add(maxBathrooms);
            }
            
            if (minArea != null) {
                sqlBuilder.append(" AND areaSqft >= ?");
                params.add(minArea);
            }
            
            if (maxArea != null) {
                sqlBuilder.append(" AND areaSqft <= ?");
                params.add(maxArea);
            }
            
            // Add sorting
            if (sortBy != null) {
                switch (sortBy) {
                    case "newest":
                        sqlBuilder.append(" ORDER BY createdAt DESC");
                        break;
                    case "priceAsc":
                        sqlBuilder.append(" ORDER BY price ASC");
                        break;
                    case "priceDesc":
                        sqlBuilder.append(" ORDER BY price DESC");
                        break;
                    case "areaAsc":
                        sqlBuilder.append(" ORDER BY areaSqft ASC");
                        break;
                    case "areaDesc":
                        sqlBuilder.append(" ORDER BY areaSqft DESC");
                        break;
                    default:
                        sqlBuilder.append(" ORDER BY createdAt DESC");
                }
            } else {
                sqlBuilder.append(" ORDER BY createdAt DESC");
            }
            
            // Add pagination
            int offset = (page - 1) * pageSize;
            sqlBuilder.append(" LIMIT ? OFFSET ?");
            params.add(pageSize);
            params.add(offset);
            
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            rs = pstmt.executeQuery();
            
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
                property.setCreatedAt(rs.getString("createdAt"));
                property.setYearBuilt(rs.getInt("yearBuilt"));
                property.setFurnishing(rs.getString("furnishing"));
                property.setOwnerName(rs.getString("ownerName"));
                property.setOwnerContact(rs.getString("ownerContact"));
                property.setLongitude(rs.getDouble("longitude"));
                property.setLatitude(rs.getDouble("latitude"));
                property.setPrimaryImagePath(rs.getString("primaryImagePath"));
                
                // Get images for this property
                property.setImagePaths(getPropertyImages(property.getPropertyId()));
                
                properties.add(property);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return properties;
    }
    
    // Get total count of properties with filters
    public int getTotalFilteredPropertiesCount(String location, String propertyType, 
                                              Double minPrice, Double maxPrice,
                                              Integer minBedrooms, Integer maxBedrooms,
                                              Integer minBathrooms, Integer maxBathrooms,
                                              Double minArea, Double maxArea) {
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            StringBuilder sqlBuilder = new StringBuilder();
            sqlBuilder.append("SELECT COUNT(*) FROM properties WHERE 1=1");
            
            List<Object> params = new ArrayList<>();
            
            // Add filters
            if (location != null && !location.equals("All of Nepal")) {
                sqlBuilder.append(" AND location LIKE ?");
                params.add("%" + location + "%");
            }
            
            if (propertyType != null && !propertyType.equals("All Types")) {
                sqlBuilder.append(" AND title LIKE ?");
                params.add("%" + propertyType + "%");
            }
            
            if (minPrice != null) {
                sqlBuilder.append(" AND price >= ?");
                params.add(minPrice);
            }
            
            if (maxPrice != null) {
                sqlBuilder.append(" AND price <= ?");
                params.add(maxPrice);
            }
            
            if (minBedrooms != null) {
                sqlBuilder.append(" AND bedrooms >= ?");
                params.add(minBedrooms);
            }
            
            if (maxBedrooms != null) {
                sqlBuilder.append(" AND bedrooms <= ?");
                params.add(maxBedrooms);
            }
            
            if (minBathrooms != null) {
                sqlBuilder.append(" AND bathrooms >= ?");
                params.add(minBathrooms);
            }
            
            if (maxBathrooms != null) {
                sqlBuilder.append(" AND bathrooms <= ?");
                params.add(maxBathrooms);
            }
            
            if (minArea != null) {
                sqlBuilder.append(" AND areaSqft >= ?");
                params.add(minArea);
            }
            
            if (maxArea != null) {
                sqlBuilder.append(" AND areaSqft <= ?");
                params.add(maxArea);
            }
            
            pstmt = conn.prepareStatement(sqlBuilder.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return count;
    }
    
    // Helper method to get all images for a property
    private List<String> getPropertyImages(int propertyId) {
        List<String> images = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT image_path FROM property_images WHERE property_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, propertyId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                images.add(rs.getString("image_path"));
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return images;
    }
}