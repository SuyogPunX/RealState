<%@page import="com.web.model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String currentPage = request.getRequestURI();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.active a {
    font-weight: bold;
    color: #007BFF; /* Highlight color */
}

/* Profile popup styles */
.profile-dropdown {
    position: relative;
    display: inline-block;
}

.profile-icon {
    cursor: pointer;
    font-size: 24px;
    border-radius: 50%;
    background-color: #f0f0f0;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.profile-dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: #fff;
    min-width: 250px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    border-radius: 5px;
    padding: 15px;
}

.profile-dropdown-content.show {
    display: block;
}

.profile-header {
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 10px;
    font-weight: bold;
}

.profile-detail {
    margin: 8px 0;
    display: flex;
    align-items: center;
}

.detail-icon {
    margin-right: 10px;
    color: #666;
    width: 16px;
    text-align: center;
}

.signout-btn {
    margin-top: 15px;
    width: 100%;
    padding: 8px;
    background-color: #f44336;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.signout-btn:hover {
    background-color: #d32f2f;
}

.header-actions {
    display: flex;
    align-items: center;
    gap: 15px;
}

.header-icon {
    cursor: pointer;
}
.cart-button {
    font-size: 24px; /* make the cart icon bigger */
    padding: 10px 14px;
    margin-left: -10px; /* move it slightly to the left */
    background-color: transparent;
    border: none;
    cursor: pointer;
    transition: transform 0.2s;
}

.cart-button:hover {
    transform: scale(1.1); /* optional: makes the button grow slightly on hover */
}

</style>
</head>
<body>
<header>
<a href="${pageContext.request.contextPath}/pages/home.jsp" class="logo">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/pictures/logo.png" alt="Sangri-La Estates" class="logo-icon" />
        <span>Sangri-La Estates</span>
    </div>
</a>

<nav>
    <ul>
        <li class="<%= currentPage.endsWith("home.jsp") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/pages/home.jsp">Home</a>
        </li>
        <li class="<%= currentPage.endsWith("buy.jsp") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/pages/buy.jsp">Booking</a>
        </li>
        <li class="<%= currentPage.endsWith("aboutus.jsp") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/pages/aboutus.jsp">About Us</a>
        </li>
        <li class="<%= currentPage.endsWith("contactus.jsp") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/pages/contactus.jsp">Contact</a>
        </li>
    </ul>
</nav>

<div class="header-actions">
    <a href="${pageContext.request.contextPath}/user?action=cart">
    <button class="btn-icon cart-button" title="My Cart">🛒</button>
	</a>
	
    <div class="profile-dropdown">
        <div class="profile-icon" onclick="toggleProfileDropdown()">👤</div>
       <div class="profile-dropdown-content" id="profileDropdown">
	    <c:choose>
	        <c:when test="${not empty user}">
	        
	            <div class="profile-header">User Profile</div>
	            <div class="profile-detail">
	                <div class="detail-icon">👤</div>
	                <div>${user.fullName}</div>
	            </div>
	            <div class="profile-detail">
	                <div class="detail-icon">✉️</div>
	                <div>${user.email}</div>
	            </div>
	            <div class="profile-detail">
	                <div class="detail-icon">📞</div>
	                <div>${user.phone}</div>
	            </div>
	            <div class="profile-detail">
	                <div class="detail-icon">🏠</div>
	                <div>${user.address}</div>
	            </div>
	            <a href="${pageContext.request.contextPath}/pages/home.jsp?action=signout">
                    <button class="signout-btn">Sign Out</button>
                </a>
	        </c:when>
	    </c:choose>
	</div>
    </div>
</div>
</header>

<script>
function toggleProfileDropdown() {
    document.getElementById("profileDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
    if (!event.target.matches('.profile-icon')) {
        var dropdowns = document.getElementsByClassName("profile-dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}
</script>
</body>
</html>