package com.sijan.DAO;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.sijan.database.DatabaseConnection;
import com.sijan.model.User;

public class UserDAO {
	
	private Connection conn;
	
	public UserDAO() throws ClassFormatException, SQLException{
		this.conn = DatabaseConnection.connect();
		
	}

	public User login(String email, String password) {
		
		return null;
	}

}
