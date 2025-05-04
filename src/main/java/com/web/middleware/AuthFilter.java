package com.web.middleware;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false); // do not create new session here
        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        
        //  Prevent caching of protected pages
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Handle signout
        if ("signout".equals(action)) {
            if (session != null) {
                session.invalidate(); // destroy session
            }
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return;
        }

        // Public pages and servlets
        boolean isLoginPage = uri.endsWith("login.jsp");
        boolean isRegisterPage = uri.endsWith("registration.jsp");
        boolean isLoginServlet = uri.endsWith("LoginServlet");
        boolean isRegisterServlet = uri.endsWith("RegisterServlet");
        boolean isHomePage = uri.endsWith("home.jsp");
        
        // Public resources
        boolean isPublicResource = uri.contains("/css/") || uri.contains("/js/") ||
                uri.contains("/images/") || uri.contains("/fonts/") ||
                uri.endsWith("favicon.ico");

        // Pages allowed without login (only home, login, and register pages are public)
        boolean isPublicPage = isHomePage || isLoginPage || isRegisterPage;
        boolean isPublicServlet = isLoginServlet || isRegisterServlet;

        // If user is trying to access a protected resource without being logged in
        if (!loggedIn && !isPublicPage && !isPublicResource && !isPublicServlet) {
            // Store the original request URI for redirection after login
            // We create a session here only to store the redirect URL
            HttpSession redirectSession = request.getSession(true);
            redirectSession.setAttribute("redirectAfterLogin", uri);
            
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Continue chain
        chain.doFilter(req, res);
    }

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void destroy() {}
}