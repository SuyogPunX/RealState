//package com.web.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.Cookie;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.web.DAO.CartDAO;
//import com.web.DAO.PropertyDAO;
//import com.web.model.Property;
//
//public class CartServlet extends HttpServlet {
//    private static final String CART_COOKIE_NAME = "propertyCart";
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String action = request.getParameter("action");
//
//        if (action == null) {
//            action = "view"; // default action
//        }
//
//        switch (action) {
//            case "add":
//                addToCart(request, response);
//                break;
//            case "remove":
//                removeFromCart(request, response);
//                break;
//            case "view":
//            default:
//			try {
//				showCart(request, response);
//			} catch (ServletException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//                break;
//        }
//    }
//
//    // Helper: Add property to cart via cookie
//    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
//        String userId = request.getSession().getId();
//
//        List<Integer> cart = getCartFromCookie(request);
//        if (!cart.contains(propertyId)) {
//            cart.add(propertyId);
//        }
//
//        saveCartToCookie(cart, response);
//        CartDAO.saveCartToDB(userId, cart);
//
//        response.sendRedirect("cart");
//    }
//
//    // Helper: Remove property from cart
//    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int propertyIdToRemove = Integer.parseInt(request.getParameter("propertyId"));
//        String userId = request.getSession().getId();
//
//        List<Integer> cart = getCartFromCookie(request);
//        cart.removeIf(id -> id == propertyIdToRemove);
//
//        saveCartToCookie(cart, response);
//        CartDAO.saveCartToDB(userId, cart);
//
//        response.sendRedirect("cart");
//    }
//
//    // Helper: Show cart page
//    private void showCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
//        List<Integer> cart = getCartFromCookie(request);
//        String userId = request.getSession().getId();
//
//        // Sync with DB
//        CartDAO.saveCartToDB(userId, cart);
//
//        List<Property> cartProperties = new ArrayList<>();
//        if (!cart.isEmpty()) {
//            //cartProperties = PropertyDAO.getPropertiesByIds(cart); // Implement this DAO method
//        }
//
//        request.setAttribute("cartProperties", cartProperties);
//        request.getRequestDispatcher("/cart.jsp").forward(request, response);
//    }
//
//    // Helper: Read cart from cookie
//    private List<Integer> getCartFromCookie(HttpServletRequest request) {
//        Cookie[] cookies = request.getCookies();
//        Cookie cartCookie = null;
//
//        if (cookies != null) {
//            for (Cookie c : cookies) {
//                if (CART_COOKIE_NAME.equals(c.getName())) {
//                    cartCookie = c;
//                    break;
//                }
//            }
//        }
//
//        List<Integer> cart = new ArrayList<>();
//        if (cartCookie != null && cartCookie.getValue() != null && !cartCookie.getValue().isEmpty()) {
//            String[] ids = cartCookie.getValue().split(",");
//            for (String s : ids) {
//                try {
//                    cart.add(Integer.parseInt(s));
//                } catch (NumberFormatException ignored) {}
//            }
//        }
//
//        return cart;
//    }
//
//    // Helper: Save cart to cookie
//    private void saveCartToCookie(List<Integer> cart, HttpServletResponse response) {
//        StringBuilder sb = new StringBuilder();
//        for (Integer id : cart) {
//            sb.append(id).append(",");
//        }
//
//        if (sb.length() > 0) {
//            sb.setLength(sb.length() - 1); // remove last comma
//        }
//
//        Cookie cookie = new Cookie(CART_COOKIE_NAME, sb.toString());
//        cookie.setMaxAge(86400); // 24 hours
//        cookie.setPath("/");
//        response.addCookie(cookie);
//    }
//}
