package com.web.controller;

import com.web.DAO.UserDAO;
import com.web.model.User;
import com.web.model.UserRole;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

import org.apache.tomcat.jakartaee.bcel.classfile.ClassFormatException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("loginservlet");
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // Already logged in
            User user = (User) session.getAttribute("user");

            if (user.getRole() == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            } else {
                String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                if (redirectURL != null) {
                    session.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(redirectURL);
                } else {
                	System.out.println("home ma ");
                    response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }
            }
            return;
        }

        // Not logged in
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
       

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String plainPassword = request.getParameter("password");
        System.out.println("loginservlet2");
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.login(email, plainPassword);

            if (user != null) {
                // Login success
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(60 * 60); // 1 hour

                if (user.getRole() == UserRole.ADMIN) {
                    response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
                } else if(user.getRole() == UserRole.CUSTOMER) {
                	 response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }
            } else {
                // Invalid credentials
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }

        } catch (ClassFormatException | SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "A system error occurred. Please try again later.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}
