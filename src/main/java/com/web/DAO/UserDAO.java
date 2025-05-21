package com.web.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.database.DatabaseConnection;
import com.web.model.Booking;
import com.web.model.Inquiries;
import com.web.model.User;
import com.web.model.UserRole;
import com.web.utility.EncryptDecrypt;

public class UserDAO {
	
	private Connection conn;
	
	public UserDAO() throws ClassFormatException, SQLException, ClassNotFoundException{
		this.conn = DatabaseConnection.getConnection();
		
	}

	//Login Method

	public User login(String email, String plainPassword) {
		User user=null;
		String query="SELECT * from user WHERE email=?";
		try { PreparedStatement ps=conn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()) {
				
				//get encrypt password form db
				String encryptPassword=rs.getString("password");
				
				//Decrypt the password from db
				String decryptedPasswordFromDB=EncryptDecrypt.decrypt(encryptPassword);
				
				//compare plain text password with decpryptpassword
				if(decryptedPasswordFromDB !=null && decryptedPasswordFromDB.equals(plainPassword)) {
					user=new User();
					user.setId(rs.getInt("user_id"));
					user.setFullName(rs.getString("name"));
					user.setDob(rs.getTimestamp("dob"));
					user.setAddress(rs.getString("address"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
		            user.setRole(UserRole.valueOf(rs.getString("role").toUpperCase())); // enum
		            user.setCreatedAt(rs.getTimestamp("created_at"));
		            user.setLastLogin(rs.getTimestamp("last_login"));
					
		            //update last login of user
		            PreparedStatement updatestm=conn.prepareStatement("UPDATE user SET last_login =CURRENT_TIMESTAMP WHERE user_id=?");
		            updatestm.setInt(1, user.getId());
		            updatestm.executeUpdate();
		           
	           	
				}
			}
			
		}catch(SQLException e){
			e.printStackTrace();
			
		}
		 return user;
	}

	public boolean register(String fullName, String phone, LocalDate dob, String email,String address, String password,
			String confirmPassword, String role){
		Timestamp now = new Timestamp(System.currentTimeMillis());

			String sql = "INSERT INTO user (name, phone, dob, email, address, password, role, created_at, last_login, active) " +
		             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement ps = conn.prepareStatement(sql)) {
		    ps.setString(1, fullName);
		    ps.setString(2, phone);
		    ps.setDate(3, Date.valueOf(dob));
		    ps.setString(4, email);
		    ps.setString(5, address);
		    ps.setString(6, password); 
		    ps.setString(7, role); 
		    ps.setTimestamp(8, now);
		    ps.setTimestamp(9, now);
		    ps.setBoolean(10, true);      // active = true

		    int rowsAffected = ps.executeUpdate();
		    return rowsAffected>0;

		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean checkUserExists(String email) {
		try{PreparedStatement ps=conn.prepareStatement("SELECT email from user where email=?");
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
			return rs.next(); //true if at least one record is retrived
		}
		catch(SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public List<User> getAllUsers() throws SQLException {
	    String sql = "SELECT * FROM user";
	    List<User> userList = new ArrayList<>();
	    
	    try (PreparedStatement stmt = conn.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery()) {
	        
	        while (rs.next()) {
	            User user = new User();
	            user.setId(rs.getInt("user_id"));
	            user.setFullName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPhone(rs.getString("phone"));
	            user.setActive(rs.getBoolean("active")); 
	            user.setCreatedAt(rs.getTimestamp("created_at"));

	            userList.add(user);
	        }
	    }

	    return userList;
	}

	public User getUserById(int id) throws SQLException {
	    String sql = "SELECT * FROM user WHERE user_id = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setInt(1, id);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("user_id"));
	                user.setFullName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhone(rs.getString("phone"));
	                user.setActive(rs.getBoolean("active"));
	                String roleStr = rs.getString("role");
	                user.setRole(UserRole.valueOf(roleStr.toUpperCase()));
	                user.setCreatedAt(rs.getTimestamp("created_at"));

	                return user;
	            }
	        }
	    }
	    return null;
	}

	public void updateUserStatus(int userId, Boolean status) throws SQLException {
	    String sql = "UPDATE user SET active = ? WHERE user_id = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setBoolean(1, status);
	        stmt.setInt(2, userId);
	        stmt.executeUpdate();
	    }
	}

	public List<Booking> getAllBookings() throws SQLException {
	    List<Booking> bookings = new ArrayList<>();

	    String query = "SELECT " +
	                   "b.booking_id AS id, " +
	                   "b.property_id AS propertyId, " +
	                   "b.user_id AS userId, " +
	                   "b.booking_time AS bookingTime, " +
	                   "b.meeting_location AS meetingLocation, " +
	                   "b.status AS status " +
	                   "FROM booking b";

	    try (PreparedStatement stmt = conn.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            Booking booking = new Booking();

	            booking.setId(rs.getInt("id"));
	            booking.setPropertyId(rs.getInt("propertyId"));
	            booking.setUserId(rs.getInt("userId"));
	            booking.setBookingTime(rs.getTimestamp("bookingTime"));
	            booking.setMeetingLocation(rs.getString("meetingLocation"));

	            // Convert database enum to Java enum
	            String statusStr = rs.getString("status");
	            if (statusStr != null && !statusStr.isEmpty()) {
	                try {
	                    booking.setStatus(Booking.Status.valueOf(statusStr));
	                } catch (IllegalArgumentException e) {
	                    // Handle unknown status gracefully
	                    booking.setStatus(null);
	                }
	            }
	            bookings.add(booking);
	        }
	    }
	    return bookings;
	}
	
	public void updateBookingStatus(int id, String status) throws SQLException {
	    String sql = "UPDATE Booking SET status = ? WHERE booking_id = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, status);
	        stmt.setInt(2, id);
	        stmt.executeUpdate();
	    }
	}

	public List<Booking> getBookingsByUserId(int userId) throws SQLException {
	    List<Booking> bookings = new ArrayList<>();
	    String query = "SELECT * FROM booking WHERE user_id = ? AND status = 'PENDING'";

	    try (PreparedStatement stmt = conn.prepareStatement(query)) {
	        stmt.setInt(1, userId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Booking booking = new Booking();
	            booking.setId(rs.getInt("booking_id"));
	            booking.setPropertyId(rs.getInt("property_id"));
	            booking.setUserId(rs.getInt("user_id"));
	            booking.setBookingTime(rs.getTimestamp("booking_time"));
	            booking.setMeetingLocation(rs.getString("meeting_location"));
	            booking.setStatus(Booking.Status.valueOf(rs.getString("status")));

	            bookings.add(booking);
	        }
	    }

	    return bookings;
	}
	
}
