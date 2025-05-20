package com.web.model;

import java.sql.Timestamp;
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
    private Timestamp bookingTime;    // booking_time
    private String meetingLocation;   // meeting_location
    private Status status;            // status enum
    
    // Default constructor
    public Booking() {
    }
    
    // Parameterized constructor
    public Booking(Integer id, Integer propertyId, Integer userId, Timestamp scheduledAt,
                  Timestamp createdAt, Timestamp bookingDate, Timestamp bookingTime,
                  String customerComments, String meetingLocation, Status status) {
        this.id = id;
        this.propertyId = propertyId;
        this.userId = userId;
        this.bookingTime = bookingTime;
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

    public Timestamp getBookingTime() {
        return bookingTime;
    }
    
    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
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
                ", bookingTime=" + bookingTime +
                ", meetingLocation='" + meetingLocation + '\'' +
                ", status=" + status +
                '}';
    }
}