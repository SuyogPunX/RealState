package com.web.middleware;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletRequest;


@WebFilter("/pages/home.jsp")
public class HomeRedirectFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // Prevent infinite loop by checking if it's not already forwarded from servlet
        String previousUri = (String) httpRequest.getAttribute("javax.servlet.forward.request_uri");

        if (previousUri == null || !previousUri.endsWith("/home")) {
            // Forward internally to servlet
            httpRequest.getRequestDispatcher("/home").forward(request, response);
        } else {
            // Already came from servlet – render JSP normally
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}