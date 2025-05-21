package com.web.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

import com.web.DAO.UserDAO;
import com.web.utility.EncryptDecrypt;



@WebServlet( "/RegistrationServlet" )
public class RegistrationServlet extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		//check if user exists
		 HttpSession session = request.getSession(false);
	        if (session != null && session.getAttribute("user") != null) {
	            // User is already logged in, redirect to home page
	            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
	            return;
	        }
	        
	        // If not logged in, forward to registration page
	        request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
	    
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {);
		// Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return;
        }
        
		
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");
		String fullName=firstName+" "+lastName;
		String phone=request.getParameter("phone");
		String dobStr = request.getParameter("dob");
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		LocalDate dob = null;
		try {
		    dob = LocalDate.parse(dobStr, formatter);
		} catch (DateTimeParseException e) {
		    e.printStackTrace(); // log the error
		    // Optionally set an error message to display back to user
		}



		String address=request.getParameter("address");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String confirmPassword=request.getParameter("confirmPassword");
		String role="CUSTOMER";
		
		
		// Basic validation
	    
        if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(phone) || 
            isEmpty(dobStr) || isEmpty(email) || isEmpty(password) || 
            isEmpty(confirmPassword) || isEmpty(role)) {
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
            return;
        }
        
		
        UserDAO userDAO = null;
        
		try {
			userDAO = new UserDAO();
			
			if (password == null || !password.equals(confirmPassword)) {
			    request.setAttribute("errorMessage", "Passwords do not match");
			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
			    return;
			}
			
			// Check if email already exists
			if (userDAO.checkUserExists(email)) {
			    request.setAttribute("errorMessage", "Email already registered");
			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
			    return;
			}
			
			//encrypt before sending to dao
			String encryptedPassword = EncryptDecrypt.encrypt(password);
			
			boolean user = userDAO.register(fullName,phone,dob,email,address,encryptedPassword,confirmPassword,role);
			
			if (user==true) {
			    // Registration successful
	            response.sendRedirect(request.getContextPath()+"/pages/login.jsp");
			    
			} else {
			    // Registration failed
			    request.setAttribute("errorMessage", "Registration failed. Please try again.");
			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
			}
			
		 } catch (ClassFormatException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
	        }
	
	}
	
	 // method to check if a string is null or empty
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

}
