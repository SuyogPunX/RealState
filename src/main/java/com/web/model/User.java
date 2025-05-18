package com.web.model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String fullName;
    private String phone;
    private Timestamp dob;
    private String email;
    private String address;
    private String password;
    private UserRole role; 
    private Timestamp createdAt;
    private Timestamp lastLogin;
    
    

    public User(int id, String fullName, String phone, Timestamp dob, String email, String address, String password,
			UserRole role, Timestamp createdAt, Timestamp lastLogin) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.phone = phone;
		this.dob = dob;
		this.email = email;
		this.address = address;
		this.password = password;
		this.role = role;
		this.createdAt = createdAt;
		this.lastLogin = lastLogin;
	}

	// Getters and Setters

	public User() {
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Timestamp getDob() {
        return dob;
    }

    public void setDob(Timestamp dob) {
        this.dob = dob;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}

    

}
