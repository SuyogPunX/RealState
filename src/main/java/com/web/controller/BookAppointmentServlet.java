package com.web.controller;

import com.web.DAO.BookingDAO;
import com.web.model.Booking;
import com.web.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        	
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get form data
        String propertyIdStr = request.getParameter("propertyId");
        String meetingLocation = request.getParameter("meeting_location");
        String bookingTimeStr = request.getParameter("booking_time"); // Format: "yyyy-MM-dd'T'HH:mm"

        try {
            Integer propertyId = Integer.parseInt(propertyIdStr);

            // Parse LocalDateTime from  datetime-local input
            LocalDateTime bookingDateTime = LocalDateTime.parse(bookingTimeStr);
            Timestamp bookingTimestamp = Timestamp.valueOf(bookingDateTime);

            // Create Booking object
            Booking booking = new Booking();
            booking.setPropertyId(propertyId);
            booking.setUserId(user.getId());
            booking.setBookingTime(bookingTimestamp);
            booking.setMeetingLocation(meetingLocation);
            booking.setStatus(Booking.Status.PENDING); // Default status

            // Save to DB
            boolean success = false;
            BookingDAO bookingDAO=new BookingDAO();
			try {
				success = bookingDAO.saveBooking(booking);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            if (success) {
                session.setAttribute("successMessage", "Appointment booked successfully!");
                response.sendRedirect(request.getContextPath() + "/pages/buy.jsp");
            } else {
                session.setAttribute("errorMessage", "Failed to book appointment.");
                response.sendRedirect(request.getContextPath() + "/pages/buy.jsp");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid property ID.");
            response.sendRedirect(request.getContextPath() + "/pages/buy.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while booking.");
            response.sendRedirect(request.getContextPath() + "/pages/buy.jsp");
        }
    }
}