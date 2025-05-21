package com.web.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.database.DatabaseConnection;
import com.web.model.Booking;

public class BookingDAO {
private Connection conn;
	
	public BookingDAO() throws ClassFormatException, SQLException, ClassNotFoundException{
		this.conn = DatabaseConnection.getConnection();
		
	}
	
    public  boolean saveBooking(Booking booking) {
        String sql = "INSERT INTO booking (property_id, user_id, booking_time, meeting_location, status) VALUES (?, ?, ?, ?, ?)";
        try (
        	
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, booking.getPropertyId());
            stmt.setInt(2, booking.getUserId());
            stmt.setTimestamp(3, booking.getBookingTime());
            stmt.setString(4, booking.getMeetingLocation());
            stmt.setString(5, booking.getStatus().name());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}