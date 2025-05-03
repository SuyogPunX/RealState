<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Sangri-La Estates | Find Your Perfect Home in Nepal</title>
    <link rel="stylesheet" href="../css/home.css">
</head>
<body>
	   <!-- Header -->
   	    <!-- Include Header -->
    <jsp:include page="/pages/header.jsp" />


    <!-- Hero Section -->
    <section class="hero" style="background-image: url('/api/placeholder/1200/500');">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <div class="badge">Featured Property</div>
            <h1 class="hero-title">Luxury Apartment in Pokhara</h1>
            <div class="hero-location">
                📍 Kajipokhari, Pokhara, Nepal
            </div>
            <div class="hero-price">रू 55,000,000</div>
            <div class="hero-details">
                <div class="hero-detail">4 Beds</div>
                <div class="hero-detail">3 Baths</div>
                <div class="hero-detail">2,500 Sq Ft</div>
            </div>
            <div class="hero-buttons">
                <button class="btn btn-primary" style="margin-right: 15px;">View Details</button>
                <button class="btn btn-outline" style="background-color: rgba(255,255,255,0.2);">Schedule Viewing</button>
            </div>
        </div>
    </section>

  

    <!-- Recent Properties -->
    <section class="recent-properties">
        <h2 class="section-title">Recently Added</h2>
        <div class="property-grid">
            <!-- Property 1 - House -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="Modern House in Lalitpur">
                    <div class="property-tag">For Sale</div>
                    <div class="property-category">House</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">Modern House with Garden</h3>
                    <div class="property-location">
                        📍 NayaBazar, Pokhara
                    </div>
                    <div class="property-price">रू 42,500,000</div>
                    <div class="property-features">
                        <span>4 Beds</span>
                        <span>3 Baths</span>
                        <span>2,800 Sq Ft</span>
                    </div>
                    <div class="property-type">
                        🏠 Residential House
                    </div>
                   
                </div>
            </div>

            <!-- Property 2 - Apartment -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="City Apartment">
                    <div class="property-tag">For Rent</div>
                    <div class="property-category">Apartment</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">City Center Apartment</h3>
                    <div class="property-location">
                        📍Manipal Area, Pokhara
                    </div>
                    <div class="property-price">रू 45,000/month</div>
                    <div class="property-features">
                        <span>2 Beds</span>
                        <span>2 Baths</span>
                        <span>1,200 Sq Ft</span>
                    </div>
                    <div class="property-type">
                        🏠 Apartment
                    </div>
                </div>
            </div>

            <!-- Property 3 - Land -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="Commercial Land">
                    <div class="property-tag">For Sale</div>
                    <div class="property-category">Land</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">Commercial Plot</h3>
                    <div class="property-location">
                        📍 Lakeside, Pokhara
                    </div>
                    <div class="property-price">रू 27,500,000</div>
                    <div class="property-features">
                        <span>8 Aana</span>
                        <span>Road Access</span>
                        <span>Commercial Zone</span>
                    </div>
                    <div class="property-type">
                        🏠 Commercial Land
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Restaurant Properties -->
    <section class="recent-properties">
        <h2 class="section-title">Restaurant Properties</h2>
        <div class="property-grid">
            <!-- Restaurant 1 -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="Lakeside Restaurant">
                    <div class="property-tag">For Sale</div>
                    <div class="property-category">Restaurant</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">Lakeside Restaurant</h3>
                    <div class="property-location">
                        📍 Lakeside, Pokhara
                    </div>
                    <div class="property-price">रू 18,500,000</div>
                    <div class="property-features">
                        <span>100 Seats</span>
                        <span>Fully Furnished</span>
                        <span>2,000 Sq Ft</span>
                    </div>
                    <div class="property-type">
                        🏠 Commercial Property
                    </div>
                </div>
            </div>

            <!-- Restaurant 2 -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="Mountain View Restaurant">
                    <div class="property-tag">For Lease</div>
                    <div class="property-category">Restaurant</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">Mountain View Restaurant</h3>
                    <div class="property-location">
                        📍Malepatan, Pokhara
                    </div>
                    <div class="property-price">रू 125,000/month</div>
                    <div class="property-features">
                        <span>60 Seats</span>
                        <span>Rooftop</span>
                        <span>1,500 Sq Ft</span>
                    </div>
                    <div class="property-type">
                        🏠 Lease Property
                    </div>
                </div>
            </div>

            <!-- Restaurant 3 -->
            <div class="property-card">
                <div class="property-image">
                    <img src="/api/placeholder/400/200" alt="City Restaurant">
                    <div class="property-tag">For Sale</div>
                    <div class="property-category">Restaurant</div>
                </div>
                <div class="property-content">
                    <h3 class="property-title">Tourist Hub Restaurant</h3>
                    <div class="property-location">
                        📍 Bagar, Pokhara
                    </div>
                    <div class="property-price">रू 22,750,000</div>
                    <div class="property-features">
                        <span>80 Seats</span>
                        <span>Kitchen Equipment</span>
                        <span>2,200 Sq Ft</span>
                    </div>
                    <div class="property-type">
                        🏠 Commercial Business
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <h2 class="cta-title">Ready to Find Your Dream Property in Nepal?</h2>
        <p class="cta-text">Whether you're looking to buy, rent, or sell property in Nepal, our experienced agents are here to help you every step of the way.</p>
        <div class="cta-buttons">
            <button class="btn btn-light">Browse Properties</button>
            <button class="btn btn-outline" style="border-color: white; color: white;">Contact An Agent</button>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonials">
        <h2 class="section-title">What Our Clients Say</h2>
        <div class="testimonial-grid">
            <!-- Testimonial 1 -->
            <div class="testimonial-card">
                <div class="testimonial-avatar"></div>
                <h3 class="testimonial-name">Raj Sharma</h3>
                <div class="testimonial-role">New Homeowner</div>
                <p class="testimonial-text">"Shangri-La Estates helped me find a perfect family home in Kathmandu. The entire process was smooth and professional from start to finish."</p>
            </div>

            <!-- Testimonial 2 -->
            <div class="testimonial-card">
                <div class="testimonial-avatar"></div>
                <h3 class="testimonial-name">Sunita Gurung</h3>
                <div class="testimonial-role">Property Investor</div>
                <p class="testimonial-text">"As a property investor, I've worked with many real estate companies. Shangri-La Estates consistently delivers the best market insights and investment options."</p>
            </div>

            <!-- Testimonial 3 -->
            <div class="testimonial-card">
                <div class="testimonial-avatar"></div>
                <h3 class="testimonial-name">Hari Thapa</h3>
                <div class="testimonial-role">Restaurant Owner</div>
                <p class="testimonial-text">"Shangri-La Estates helped me find the perfect location for my restaurant in Pokhara. Their understanding of commercial properties is outstanding!"</p>
            </div>

            <div class="testimonial-card">
                <div class="testimonial-avatar"></div>
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
</body>
</html>