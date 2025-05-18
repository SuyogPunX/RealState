package com.web.model;

public class Statistics {
    private int totalProperties;
    private int totalUsers;
    private double salesRevenue;
    private int newInquiries;

    // Getters and Setters
    public int getTotalProperties() { return totalProperties; }
    public void setTotalProperties(int totalProperties) { this.totalProperties = totalProperties; }

    public int getTotalUsers() { return totalUsers; }
    public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }

    public double getSalesRevenue() { return salesRevenue; }
    public void setSalesRevenue(double salesRevenue) { this.salesRevenue = salesRevenue; }

    public int getNewInquiries() { return newInquiries; }
    public void setNewInquiries(int newInquiries) { this.newInquiries = newInquiries; }
}

