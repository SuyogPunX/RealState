<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
</head>
<body>

<header>
    <a href="${pageContext.request.contextPath}/pages/home.jsp" class="logo">
            <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png" alt="Sangri-La Estates" class="logo-icon" />
            <span>Sangri-La Estates</span>
    </a>
    
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/home.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/booking.jsp">Booking</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/aboutus.jsp">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/contactus.jsp">Contact</a></li>
        </ul>
    </nav>
    
    <div class="header-actions">
        <a href="${pageContext.request.contextPath}/pages/login.jsp"><button class="btn btn-outline">Sign In</button></a>
        <a href="${pageContext.request.contextPath}/pages/registration.jsp"><button class="btn btn-primary">Register</button></a>
    </div>
</header>

</body>
</html>
