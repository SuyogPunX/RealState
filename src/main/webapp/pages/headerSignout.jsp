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
</style>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/pages/home.jsp" class="logo">
        <div class="logo-container">
            <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png" alt="Sangri-La Estates" class="logo-icon" />
            <span>Sangri-La Estates</span>
        </div>
    </a>

    <nav>
        <ul>
            <li class="<%= currentPage.endsWith("home.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/pages/home.jsp">Home</a>
            </li>
            <li class="<%= currentPage.endsWith("booking.jsp") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/pages/booking.jsp">Booking</a>
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
        <div class="header-icon">📍</div>
        <div class="header-icon">🛒</div>
        <a href="${pageContext.request.contextPath}/pages/home.jsp?action=signout">
            <button class="btn btn-outline">Sign Out</button>
        </a>
    </div>
</header>
</body>
</html>
