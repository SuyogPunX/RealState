package com.web.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * Entity class representing a booking record.
 */
public class Booking {
    
    // Enum for booking status
    public enum Status {
        PENDING, CONFIRMED, CANCELLED
    }
    
    // Fields
    private Integer id;               // booking_id (PK, auto_increment)
    private Integer propertyId;       // property_id (FK)
    private Integer userId;           // user_id (FK)
    private LocalDateTime scheduledAt;// scheduled_at
    private LocalDateTime createdAt;  // created_at
    private LocalDate bookingDate;    // booking_date
    private LocalTime bookingTime;    // booking_time
    private String customerComments;  // customer_comments
    private String meetingLocation;   // meeting_location
    private Status status;            // status enum
    
    // Default constructor
    public Booking() {
    }
    
    // Parameterized constructor
    public Booking(Integer id, Integer propertyId, Integer userId, LocalDateTime scheduledAt,
                  LocalDateTime createdAt, LocalDate bookingDate, LocalTime bookingTime,
                  String customerComments, String meetingLocation, Status status) {
        this.id = id;
        this.propertyId = propertyId;
        this.userId = userId;
        this.scheduledAt = scheduledAt;
        this.createdAt = createdAt;
        this.bookingDate = bookingDate;
        this.bookingTime = bookingTime;
        this.customerComments = customerComments;
        this.meetingLocation = meetingLocation;
        this.status = status;
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(Integer propertyId) {
        this.propertyId = propertyId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public LocalDateTime getScheduledAt() {
        return scheduledAt;
    }
    
    public void setScheduledAt(LocalDateTime scheduledAt) {
        this.scheduledAt = scheduledAt;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDate getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(LocalDate bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public LocalTime getBookingTime() {
        return bookingTime;
    }
    
    public void setBookingTime(LocalTime bookingTime) {
        this.bookingTime = bookingTime;
    }
    
    public String getCustomerComments() {
        return customerComments;
    }
    
    public void setCustomerComments(String customerComments) {
        this.customerComments = customerComments;
    }
    
    public String getMeetingLocation() {
        return meetingLocation;
    }
    
    public void setMeetingLocation(String meetingLocation) {
        this.meetingLocation = meetingLocation;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "Booking{" +
                "id=" + id +
                ", propertyId=" + propertyId +
                ", userId=" + userId +
                ", scheduledAt=" + scheduledAt +
                ", createdAt=" + createdAt +
                ", bookingDate=" + bookingDate +
                ", bookingTime=" + bookingTime +
                ", customerComments='" + customerComments + '\'' +
                ", meetingLocation='" + meetingLocation + '\'' +
                ", status=" + status +
                '}';
    }
}