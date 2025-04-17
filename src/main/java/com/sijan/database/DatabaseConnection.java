package com.sijan.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

	public static Connection connect() throws SQLException {
		 try {

	            Class.forName("com.mysql.cj.jdbc.Driver");  
	            String url = "jdbc:mysql://localhost:3306/apttutorials"; 
	            String user = "root"; 
	            String password = ""; 
	            
	            return DriverManager.getConnection(url, user, password);
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	            throw new SQLException("MySQL Driver not found.");
	        }
   }
}
