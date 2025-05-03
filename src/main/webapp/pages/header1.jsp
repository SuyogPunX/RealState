<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <header>
    <a href="${pageContext.request.contextPath}/pages/home.jsp"  class="logo">
        <div class="logo-container">
            <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png" alt="Sangri-La Estates" class="logo-icon" />
            <span>Sangri-La Estates</span>
        </div>
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
        	<div class="header-icon">📍</div>
        <div class="header-icon">🛒</div>
            <a href="${pageContext.request.contextPath}/pages/home.jsp"><button class="btn btn-outline">Sign Out</button></a>
        </div>
    </header>
</body>
</html>