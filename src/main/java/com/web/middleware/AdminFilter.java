package com.web.middleware;

import java.io.IOException;

import com.web.model.User;

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
        String uri = request.getRequestURI();

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Check if user is an admin
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            return;
        }

        // If accessing .jsp file directly, redirect to servlet
        if (uri.endsWith(".jsp")) {
            String redirectPath = uri.replace("/pages/admin.jsp", "/admin")
                                     .replace("/pages/properties.jsp", "/admin?action=properties")
                                     .replace("/pages/users.jsp", "/admin?action=users");
            response.sendRedirect(redirectPath);
            return;
        }

        // Otherwise, continue with normal flow
        chain.doFilter(request, response);
    }
 }
