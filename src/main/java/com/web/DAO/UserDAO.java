package com.web.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.database.DatabaseConnection;
import com.web.utility.EncryptDecrypt;
import com.webmodel.User;
import com.webmodel.UserRole;

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
					user.setDob(rs.getString("dob"));
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
		
		 String sql = "INSERT INTO user (name, phone, dob, email, address, password, role, created_at, last_login) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
		    ps.setString(1, fullName);
		    ps.setString(2, phone);
		    ps.setDate(3, Date.valueOf(dob));
		    ps.setString(4, email);
		    ps.setString(5, address);
		    ps.setString(6, password); 
		    ps.setString(7, role);
		    
		    int rowsAffected=ps.executeUpdate();
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
	
	

}
