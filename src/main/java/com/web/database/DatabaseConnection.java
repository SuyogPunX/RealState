package com.web.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private final static String databaseName="Shangrila";
	private final static String userName="root";
	private final static String password="suyog123";
	private final static String jdbcURL="jdbc:mysql://localhost:3306/"+databaseName;


	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection conn=null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(jdbcURL,userName,password);
		return conn;
	}
	
	public static void main(String[] args) {
		Connection conn=null;
		try {
			conn=DatabaseConnection.getConnection();
			if(conn!=null)
			{
				System.out.println("Connection sucess !");
			}
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}



}

