package com.webmodel;

public class House {
	private int propertyId;
    private String description;
    private double areaSqft;
    private int storey;
    private int bedrooms;
    private int bathrooms;
    private boolean kitchen;
    private String listedBy;
    private boolean available;
    private String createdAt;
    private int yearBuilt;
    private String title;
    private String location;
    private double price;
    private String furnishing;
    private String ownerName;
    private String ownerContact;
    private double longitude;
    private double latitude;

    // Getters and Setters for all attributes
    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getAreaSqft() { return areaSqft; }
    public void setAreaSqft(double areaSqft) { this.areaSqft = areaSqft; }

    public int getStorey() { return storey; }
    public void setStorey(int storey) { this.storey = storey; }

    public int getBedrooms() { return bedrooms; }
    public void setBedrooms(int bedrooms) { this.bedrooms = bedrooms; }

    public int getBathrooms() { return bathrooms; }
    public void setBathrooms(int bathrooms) { this.bathrooms = bathrooms; }

    public boolean isKitchen() { return kitchen; }
    public void setKitchen(boolean kitchen) { this.kitchen = kitchen; }

    public String getListedBy() { return listedBy; }
    public void setListedBy(String listedBy) { this.listedBy = listedBy; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public int getYearBuilt() { return yearBuilt; }
    public void setYearBuilt(int yearBuilt) { this.yearBuilt = yearBuilt; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getFurnishing() { return furnishing; }
    public void setFurnishing(String furnishing) { this.furnishing = furnishing; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public String getOwnerContact() { return ownerContact; }
    public void setOwnerContact(String ownerContact) { this.ownerContact = ownerContact; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

}
