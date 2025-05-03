package com.web.middleware;

import java.io.IOException;

import com.webmodel.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")  // Apply the filter to any page under /admin/*
public class AdminFilter implements Filter {
    
    public AdminFilter() {
        // Empty constructor
    }

    public void init(FilterConfig fConfig) throws ServletException {
        // Optional: Filter initialization if required
    }

    public void destroy() {
        // Optional: Clean-up code if required
    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        HttpSession session = request.getSession(false); 
        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            // User is not an admin, redirect to unauthorized page
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return;
        }
        
        // If user is logged in and is an admin, continue to the requested resource
        chain.doFilter(request, response);
    }
}
