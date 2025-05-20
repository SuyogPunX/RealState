//package com.web.controller;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//import com.web.DAO.UserDAO;
//import com.web.model.Inquiries;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//@WebServlet("/admin?action=inquiries")
//public class InquiriesServlet extends HttpServlet {
//    private UserDAO userDAO;
//
//    @Override
//    public void init() throws ServletException {
//        try {
//            userDAO = new UserDAO(); // Assuming it has getAllInquiries()
//        } catch (Exception e) {
//            throw new ServletException("Error initializing DAO", e);
//        }
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        List<Inquiries> inquiries;
//		try {
//			inquiries = userDAO.getAllInquiries();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		request.setAttribute("inquiries", inquiries);
//		request.getRequestDispatcher("/pages/admin/inquiries.jsp").forward(request, response);
//    }
//}
