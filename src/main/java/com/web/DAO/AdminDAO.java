package com.web.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.database.DatabaseConnection;
import com.webmodel.Property;
import com.webmodel.Statistics;

public class AdminDAO {

private Connection conn;
	
	public AdminDAO() throws ClassFormatException, SQLException, ClassNotFoundException{
		this.conn = DatabaseConnection.getConnection();
		
	}

    public Statistics getDashboardStatistics() {
        Statistics stats = new Statistics();
        
        // Queries for total properties, users, sales revenue, and inquiries
        String propertiesQuery = "SELECT COUNT(*) FROM properties";
        String usersQuery = "SELECT COUNT(*) FROM users";
        String salesRevenueQuery = "SELECT SUM(price) FROM properties WHERE status='For Sale'";
        String inquiriesQuery = "SELECT COUNT(*) FROM inquiries WHERE status='New'";
        
        try (Statement stmt=conn.createStatement()) {

            // Total Properties
            ResultSet rs = stmt.executeQuery(propertiesQuery);
            if (rs.next()) {
                stats.setTotalProperties(rs.getInt(1));
            }

            // Total Users
            rs = stmt.executeQuery(usersQuery);
            if (rs.next()) {
                stats.setTotalUsers(rs.getInt(1));
            }

            // Sales Revenue
            rs = stmt.executeQuery(salesRevenueQuery);
            if (rs.next()) {
                stats.setSalesRevenue(rs.getDouble(1));
            }

            // New Inquiries
            rs = stmt.executeQuery(inquiriesQuery);
            if (rs.next()) {
                stats.setNewInquiries(rs.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stats;
    }

    // Method to get recent properties
    public List<Property> getRecentProperties() {
        List<Property> properties = new ArrayList<>();
        
        String query = "SELECT * FROM properties ORDER BY created_at DESC LIMIT 5";
        
        try (Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
            	Property property = new Property();
            	property.setPropertyId(rs.getInt("property_id"));
                property.setDescription(rs.getString("description"));
                property.setAreaSqft(rs.getDouble("area_sqft"));
                property.setStorey(rs.getInt("storey"));
                property.setBedrooms(rs.getInt("bedrooms"));
                property.setBathrooms(rs.getInt("bathrooms"));
                property.setKitchen(rs.getBoolean("kitchen"));
                property.setAvailable(rs.getBoolean("available"));
                property.setCreatedAt(rs.getString("created_at"));
                property.setYearBuilt(rs.getInt("year_built"));
                property.setTitle(rs.getString("title"));
                property.setLocation(rs.getString("location"));
                property.setPrice(rs.getDouble("price"));
                property.setFurnishing(rs.getString("furnishing"));
                property.setOwnerName(rs.getString("owner_name"));
                property.setOwnerContact(rs.getString("owner_contact"));
                property.setLongitude(rs.getDouble("longitude"));
                property.setLatitude(rs.getDouble("latitude"));
                properties.add(property);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return properties;
    }
}

