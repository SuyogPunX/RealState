<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Shangri-La Estates</title>
    <link rel="stylesheet" href="../css/aboutus.css">
</head>
	 	    <!-- Include Header -->
    <jsp:include page="/pages/headerSignout.jsp" />

    <!-- Hero Section -->
    <section class="about-hero">
        <h1>Our Story</h1>
        <p>Helping you find your dream home in Nepal since 2010</p>
    </section>

    <!-- About Content -->
    <div class="about-content">
        <section class="about-section">
            <div class="about-text">
                <h2>Who We Are</h2>
                <p>Shangri-La Estates was founded in 2010 with a simple mission: to make finding your perfect home in Nepal an enjoyable and stress-free experience. Our team of dedicated professionals brings together decades of experience in Nepal's real estate market.</p>
                <p>We pride ourselves on our deep local knowledge, ethical business practices, and commitment to our clients' satisfaction. Whether you're looking to buy, sell, or rent property in Nepal, we're here to guide you every step of the way.</p>
            </div>
            <div class="about-image" style="background-image: url('https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
        </section>

        <section class="about-section reverse">
            <div class="about-image" style="background-image: url('https://images.unsplash.com/photo-1560520031-3a4dc4e9de0c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')"></div>
            <div class="about-text">
                <h2>Our Approach</h2>
                <p>At Shangri-La Estates, we believe in personalized service. We take the time to understand your unique needs and preferences, ensuring we find properties that truly match your requirements.</p>
                <p>Our comprehensive services include property valuation, legal assistance, financing options, and post-purchase support. We maintain a carefully curated portfolio of properties across Kathmandu, Pokhara, and other major cities in Nepal.</p>
                <button class="btn btn-primary" id="learnMoreBtn">Learn More About Our Services</button>
            </div>
        </section>
    </div>

    <!-- Team Section -->
    <section class="team-section">
        <h2>Meet Our Team</h2>
        <p>The experienced professionals behind DreamHome Realty</p>
        
        <div class="team-grid">
            <div class="team-member">
                <div class="member-image" style="background-image: url('https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744863814/TKPI0014_xgqjjg.jpg')"></div>
                <div class="member-info">
                    <h3>Teju Khatri</h3>
                    <p>Html, css, js </p>
                    <p>15+ years in real estate</p>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image" style="background-image: url('https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744863879/IMG_2621_wcw8qv.jpg')"></div>
                <div class="member-info">
                    <h3>Sashant Shrestha</h3>
                    <p>Html, css, js</p>
                    <p>15+ years in real estate</p>
                </div>
            </div>
        
            <div class="team-member">
                <div class="member-image" style="background-image: url('https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744863815/20240512_145829_uf3njs.jpg')"></div>
                <div class="member-info">
                    <h3>Sijan Thapa</h3>
                    <p>Java Developer</p>
                    <p>Specializes in Nepal</p>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image" style="background-image: url('https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80')"></div>
                <div class="member-info">
                    <h3>Suyog pun</h3>
                    <p>Legal Advisor</p>
                    <p>Property law specialist</p>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image" style="background-image: url('https://images.unsplash.com/photo-1542190891-2093d38760f2?ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80')"></div>
                <div class="member-info">
                    <h3>Saurav Baral</h3>
                    <p>Customer Relations</p>
                    <p>Documentation</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="values-section">
        <h2 style="text-align: center;">Our Core Values</h2>
        <p style="text-align: center; max-width: 800px; margin: 20px auto;">These principles guide everything we do at DreamHome Realty</p>
        
        <div class="values-grid">
            <div class="value-card">
                <div class="value-icon">✓</div>
                <h3>Integrity</h3>
                <p>We believe in complete transparency and honesty in all our dealings. No hidden fees, no false promises.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">❤️</div>
                <h3>Client Focus</h3>
                <p>Your needs come first. We listen carefully and work tirelessly to find solutions that work for you.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">🏆</div>
                <h3>Expertise</h3>
                <p>Our team brings deep knowledge of Nepal's real estate market and legal landscape.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">🌱</div>
                <h3>Sustainability</h3>
                <p>We promote eco-friendly properties and sustainable development practices.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">🤝</div>
                <h3>Community</h3>
                <p>We're committed to giving back to the communities where we work.</p>
            </div>
            
            <div class="value-card">
                <div class="value-icon">🔑</div>
                <h3>Results</h3>
                <p>We measure our success by your satisfaction and the lasting relationships we build.</p>
            </div>
        </div>
    </section>

   <!-- Footer -->
   <footer>
    <jsp:include page="/pages/footer.jsp" />
</footer>

    <script src="${pageContext.request.contextPath}/js/aboutus.js"></script>
</body>
</html>