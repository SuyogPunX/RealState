package com.web.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.database.DatabaseConnection;
import com.web.model.Property;
import com.web.model.Statistics;
import com.web.model.User;
import com.web.model.UserRole;


public class AdminDAO {

private Connection conn;
	
	public AdminDAO() throws ClassFormatException, SQLException, ClassNotFoundException{
		this.conn = DatabaseConnection.getConnection();
		
	}

	public Statistics getDashboardStatistics() {
	    Statistics stats = new Statistics();

	    // Queries for total properties, users, sales revenue, and bookings
	    String propertiesQuery = "SELECT COUNT(*) FROM properties";
	    String usersQuery = "SELECT COUNT(*) FROM user";
	    
	    // Sales revenue: sum of available properties (if available means 'For Sale')
	    String salesRevenueQuery = "SELECT SUM(price) FROM properties WHERE available = TRUE";
	    
	    // New bookings with status 'PENDING'
	    String pendingBookingsQuery = "SELECT COUNT(*) FROM booking WHERE status = 'PENDING'";

	    try (Statement stmt = conn.createStatement()) {

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

	        // Pending Bookings (was: inquiries)
	        rs = stmt.executeQuery(pendingBookingsQuery);
	        if (rs.next()) {
	            stats.setNewInquiries(rs.getInt(1));  // Reusing this field for pending bookings
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return stats;
	}
	
	public List<Property> getRecentProperties() {
	    List<Property> properties = new ArrayList<>();
	    String query = "SELECT * FROM properties ORDER BY createdAt DESC LIMIT 5";

	    try (Statement stmt = conn.createStatement()) {
	        ResultSet rs = stmt.executeQuery(query);

	        while (rs.next()) {
	            Property property = new Property();
	            property.setPropertyId(rs.getInt("propertyId"));
	            property.setTitle(rs.getString("title"));
	            property.setDescription(rs.getString("description"));
	            property.setLocation(rs.getString("location"));
	            property.setPrice(rs.getDouble("price"));
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

    
	
}

