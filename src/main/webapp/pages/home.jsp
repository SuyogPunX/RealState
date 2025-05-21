<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shangri-La Estates | Find Your Perfect Home in Nepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<!-- Header -->
   	    <!-- Include Header -->
		<%
		    HttpSession currentSession = request.getSession(false);
		    if (currentSession != null && currentSession.getAttribute("user") != null) {
		%>
		    <jsp:include page="/pages/headerSignout.jsp" />
		<%
		    } else {
		%>
		    <jsp:include page="/pages/header.jsp" />
		<%
		    }
		%>
   		


    <!-- Hero Section -->
    <section class="hero" style="background-image: url('${pageContext.request.contextPath}/pictures/sijanhouse.jpg');">
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <div class="badge">Featured Property</div>
        <h1 class="hero-title">Luxury Apartment in Pokhara</h1>
        <div class="hero-location">📍 Kajipokhari, Pokhara, Nepal</div>
        <div class="hero-price">रू 55,000,000</div>
        <div class="hero-details">
            <div class="hero-detail">4 Beds</div>
            <div class="hero-detail">3 Baths</div>
            <div class="hero-detail">2,500 Sq Ft</div>
        </div>
    </div>
</section>

<!-- Recent Properties -->
<section class="recent-properties">
    <h2 class="section-title">Recently Added</h2>
    <div class="property-grid">

        <c:if test="${not empty recentProperties}">
            <c:forEach var="property" items="${recentProperties}" varStatus="loop">
                <c:if test="${loop.index < 3}">
                    <div class="property-card">
                       <div class="property-image">
<img src="${pageContext.request.contextPath}${property.primaryImagePath}"
     alt="${property.title}"
     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/pictures/default.jpg';">
						    <div class="property-tag">${property.available ? 'For Sale' : 'For Lease'}</div>
						    <div class="property-category">Apartment</div>
						</div>  
                        <div class="property-content">
                            <h3 class="property-title">${property.title}</h3>
                            <div class="property-location">📍 ${property.location}</div>
                            <div class="property-price">₨ ${property.formattedPrice}</div>
                            <div class="property-details">
                                <span>${property.bedrooms} Beds</span>
                                <span>${property.bathrooms} Baths</span>
                                <span>${property.areaSqft} Sq Ft</span>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>

    </div>
</section>

<!-- Restaurant Properties -->
<section class="recent-properties">
    <h2 class="section-title">Apartment</h2>
    <div class="property-grid">
        <c:if test="${not empty apartments}">
            <c:forEach var="property" items="${apartments}" varStatus="loop">
                <c:if test="${loop.index < 3}">
                    <div class="property-card">
<div class="property-image">
    <img src="${pageContext.request.contextPath}${property.primaryImagePath}"
     alt="${property.title}"
     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/pictures/default.jpg';">

    <div class="property-tag">${property.available ? 'For Sale' : 'For Lease'}</div>
    <div class="property-category">Apartment</div>
</div>                 <div class="property-content">
                            <h3 class="property-title">${property.title}</h3>
                            <div class="property-location">📍 ${property.location}</div>
                            <div class="property-price">₨ ${property.formattedPrice}</div>
                            <div class="property-features">
                                <span>${property.bedrooms} Beds</span>
                                <span>${property.bathrooms} Baths</span>
                                <span>${property.areaSqft} Sq Ft</span>
                            </div>
                            <div class="property-type">🏢 Commercial</div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>

    </div>
</section>

<!-- Testimonials -->
<section class="testimonials">
    <h2 class="section-title">What Our Clients Say</h2>
    <div class="testimonial-grid">
        <!-- Testimonial 1 -->
        <div class="testimonial-card">
            <div class="testimonial-avatar">
                <img src="${pageContext.request.contextPath}/pictures/person1.jpg" alt="Raj Sharma">
            </div>
            <h3 class="testimonial-name">Rupa Sharma</h3>
            <div class="testimonial-role">New Homeowner</div>
            <p class="testimonial-text">"Shangri-La Estates helped me find a perfect family home in Kathmandu. The entire process was smooth and professional from start to finish."</p>
        </div>

        <!-- Testimonial 2 -->
        <div class="testimonial-card">
            <div class="testimonial-avatar">
                <img src="${pageContext.request.contextPath}/pictures/person4.png" alt="Sunita Gurung">
            </div>
            <h3 class="testimonial-name">Sunita Gurung</h3>
            <div class="testimonial-role">Property Investor</div>
            <p class="testimonial-text">"As a property investor, I've worked with many real estate companies. Shangri-La Estates consistently delivers the best market insights and investment options."</p>
        </div>

        <!-- Testimonial 3 -->
        <div class="testimonial-card">
            <div class="testimonial-avatar">
                <img src="${pageContext.request.contextPath}/pictures/person2.jpg" alt="Hari Thapa">
            </div>
            <h3 class="testimonial-name">Hari Thapa</h3>
            <div class="testimonial-role">Restaurant Owner</div>
            <p class="testimonial-text">"Shangri-La Estates helped me find the perfect location for my restaurant in Pokhara. Their understanding of commercial properties is outstanding!"</p>
        </div>

        <!-- Testimonial 4 -->
        <div class="testimonial-card">
            <div class="testimonial-avatar">
                <img src="${pageContext.request.contextPath}/pictures/person3.jpg" alt="Biduth Khatri">
            </div>
            <h3 class="testimonial-name">Biduth Khatri</h3>
            <div class="testimonial-role">Property Investor</div>
            <p class="testimonial-text">"Shangri-La Estates made my property investment journey smooth and profitable. Their team's dedication and market insight are truly impressive!"</p>
        </div>
    </div>
</section>


<!-- Footer -->
<jsp:include page="/pages/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/home.js"></script>
</body>
</html>