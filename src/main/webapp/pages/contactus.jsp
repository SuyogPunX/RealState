<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Shangri-La Estates</title>
    <link rel="stylesheet" href="../css/contactus.css">
</head>
<body>
      <!-- Header -->
   <jsp:include page="/pages/headerSignout.jsp" />

    <main>
        <div class="container">
            <h1 class="page-title">Contact Us</h1>
            
            <div class="quick-contact">
                <a href="tel:+9771423456" class="contact-btn">
                    <span>📞</span> Call Us
                </a>
                <a href="mailto:info@dreamhomenepal.com" class="contact-btn">
                    <span>📧</span> Email Us
                </a>
                <a href="https://wa.me/9771423456" class="contact-btn">
                    <span>💬</span> WhatsApp
                </a>
            </div>
            
            <section class="contact-section">
                <div class="contact-info">
                    <h3>Our Office</h3>
                    <div class="contact-detail">
                        <strong>Address:</strong>
                        <p>123 Durbar Marg, Kathmandu, Nepal</p>
                    </div>
                    <div class="contact-detail">
                        <strong>Email:</strong>
                        <p>info@shangrilasstates.com</p>
                    </div>
                    <div class="contact-detail">
                        <strong>Phone:</strong>
                        <p>+977 1 4234567</p>
                    </div>
                    <div class="contact-detail">
                        <strong>Office Hours:</strong>
                        <p>Sunday - Friday: 9:00 AM - 5:00 PM</p>
                        <p>Saturday: Closed</p>
                    </div>
                </div>
            </section>
            
            <section class="map-container">
                <iframe src="https://maps.google.com/maps?q=27.7172,85.3240&z=15&output=embed" allowfullscreen></iframe>
                <button id="directionsBtn" class="btn btn-primary directions-btn">Get Directions</button>
            </section>
        </div>
    </main>

    <!-- Footer -->
    <footer>
      <jsp:include page="/pages/footer.jsp" />
    </footer>

	<script src="${pageContext.request.contextPath}/js/contactus.js"></script>
</body>
</html>