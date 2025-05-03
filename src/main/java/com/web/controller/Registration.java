//package com.sijan.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.time.LocalDate;
//import java.time.format.DateTimeParseException;
//
//import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;
//
//import com.sijan.DAO.UserDAO;
//import com.sijan.utility.EncryptDecrypt;
//
///**
// * Servlet implementation class Registration
// */
//@WebServlet("/Registration")
//public class Registration extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//    /**
//     * @see HttpServlet#HttpServlet()
//     */
//    public Registration() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//		//check if user exists
//		 HttpSession session = request.getSession(false);
//	        if (session != null && session.getAttribute("user") != null) {
//	            // User is already logged in, redirect to home page
//	            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
//	            return;
//	        }
//	        
//	        // If not logged in, forward to registration page
//	        request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//	    
//	}
//
//	/**
//	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
//	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//		System.out.println("RegistrationServlet: doPost method entered");
//		// Check if user is already logged in
//        HttpSession session = request.getSession(false);
//        if (session != null && session.getAttribute("user") != null) {
//            // User is already logged in, redirect to home page
//            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
//            return;
//        }
//		
//		String firstName=request.getParameter("firstName");
//		String lastName=request.getParameter("lastName");
//		String fullName=firstName+" "+lastName;
//		String phone=request.getParameter("phone");
//		String dobStr = request.getParameter("dob");
//
//		LocalDate dob = null;
//		try {
//		    dob = LocalDate.parse(dobStr); // works if format is 'yyyy-MM-dd'
//		} catch (DateTimeParseException e) {
//		    e.printStackTrace(); // handle invalid format
//		}
//
//		String address=request.getParameter("address");
//		String email=request.getParameter("email");
//		String password=request.getParameter("password");
//		String confirmPassword=request.getParameter("confirmPassword");
//		String role=request.getParameter("role");
//		
//		// Basic validation
//	    
////        if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(phone) || 
////            isEmpty(dob) || isEmpty(email) || isEmpty(password) || 
////            isEmpty(confirmPassword)) {
////            request.setAttribute("errorMessage", "All fields are required");
////            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
////            return;
////        }
//        
//		
//        UserDAO userDAO = null;
//        
//		try {
//			userDAO = new UserDAO();
//			
//			if (password == null || !password.equals(confirmPassword)) {
//			    request.setAttribute("errorMessage", "Passwords do not match");
//			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//			    return;
//			}
//			
//			// Check if email already exists
//			if (userDAO.checkUserExists(email)) {
//			    request.setAttribute("errorMessage", "Email already registered");
//			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//			    return;
//			}
//			
//			//encrypt before sending to dao
//			String encryptedPassword = EncryptDecrypt.encrypt(password);
//			
//			boolean user = userDAO.register(fullName,phone,dob,email,address,encryptedPassword,confirmPassword,role);
//			
//			if (user==true) {
//			    // Registration successful
//	            response.sendRedirect(request.getContextPath()+"/pages/login.jsp");
//			    
//			} else {
//			    // Registration failed
//			    request.setAttribute("errorMessage", "Registration failed. Please try again.");
//			    request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//			}
//			
//		 } catch (ClassFormatException e) {
//	            e.printStackTrace();
//	            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
//	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	            request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
//	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//	        } catch (ClassNotFoundException e) {
//	            e.printStackTrace();
//	            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
//	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
//	            request.getRequestDispatcher("/pages/registration.jsp").forward(request, response);
//	        }
//	
//	}
//	
//	 // method to check if a string is null or empty
//    private boolean isEmpty(String value) {
//        return value == null || value.trim().isEmpty();
//    }
//
//	}
////
////
//

