<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Properties - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buypage.css">
</head>
<body>
       <!-- Header -->
  <jsp:include page="/pages/header1.jsp" />

    <!-- Hero Section -->
    <section class="hero">
        <h1>Find Your Dream Property in Nepal</h1>
        <p>Browse through our extensive collection of properties for sale across Nepal.</p>
        
        <div class="search-container">
            <div class="search-input">
                <label>Location</label>
                <select>
                    <option>All of Nepal</option>
                    <option>Kathmandu</option>
                    <option>Pokhara</option>
                    <option>Lalitpur</option>
                    <option>Bhaktapur</option>
                    <option>Chitwan</option>
                </select>
            </div>
            <div class="search-input">
                <label>Property Type</label>
                <select>
                    <option>All Types</option>
                    <option>House</option>
                    <option>Apartment</option>
                    <option>Land</option>
                    <option>Commercial</option>
                </select>
            </div>
            <div class="search-input">
                <label>Budget</label>
                <select>
                    <option>Any Budget</option>
                    <option>Below 5,000,000</option>
                    <option>5,000,000 - 10,000,000</option>
                    <option>10,000,000 - 20,000,000</option>
                    <option>20,000,000 - 50,000,000</option>
                    <option>Above 50,000,000</option>
                </select>
            </div>
            <button class="search-btn">Search Properties</button>
        </div>
    </section>

    <!-- Main Content -->
    <div class="content-container">
        <!-- Filter Sidebar -->
        <div class="filter-sidebar">
            <h3 class="filter-title">Filter Properties</h3>
            
            <div class="filter-group">
                <label class="filter-label">Price Range</label>
                <div class="price-inputs">
                    <input type="text" placeholder="Min" class="filter-input">
                    <input type="text" placeholder="Max" class="filter-input">
                </div>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Property Type</label>
                <div class="checkbox-group">
                    <input type="checkbox" id="house"> <label for="house">House</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="apartment"> <label for="apartment">Apartment</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="land"> <label for="land">Land</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="commercial"> <label for="commercial">Commercial</label>
                </div>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Bedrooms</label>
                <div class="checkbox-group">
                    <input type="checkbox" id="bed1"> <label for="bed1">1 Bedroom</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="bed2"> <label for="bed2">2 Bedrooms</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="bed3"> <label for="bed3">3 Bedrooms</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="bed4"> <label for="bed4">4+ Bedrooms</label>
                </div>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Bathrooms</label>
                <div class="checkbox-group">
                    <input type="checkbox" id="bath1"> <label for="bath1">1 Bathroom</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="bath2"> <label for="bath2">2 Bathrooms</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" id="bath3"> <label for="bath3">3+ Bathrooms</label>
                </div>
            </div>
            
            <div class="filter-group">
                <label class="filter-label">Area (Sq Ft)</label>
                <div class="price-inputs">
                    <input type="text" placeholder="Min" class="filter-input">
                    <input type="text" placeholder="Max" class="filter-input">
                </div>
            </div>
            
            <button class="filter-btn">Apply Filters</button>
            <button class="reset-btn">Reset Filters</button>
        </div>
        
        <!-- Properties Container -->
        <div class="properties-container">
            <div class="sort-container">
                <div class="property-count">Showing 12 of 58 properties</div>
                <select class="sort-select">
                    <option>Sort by: Newest</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Area: Low to High</option>
                    <option>Area: High to Low</option>
                </select>
            </div>
            
            <div class="property-grid">
                <!-- Property 1 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Luxury Villa in Kathmandu</h3>
                        <div class="property-location">📍 Baluwatar, Kathmandu</div>
                        <div class="property-price">₨ 45,000,000</div>
                        <div class="property-details">
                            <span class="property-detail">4 Beds</span>
                            <span class="property-detail">3 Baths</span>
                            <span class="property-detail">2,500 Sq Ft</span>
                        </div>
                        <div class="property-type">Residential</div>
                    </div>
                </div>
                
                <!-- Property 2 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Modern Apartment in Patan</h3>
                        <div class="property-location">📍 Patan, Lalitpur</div>
                        <div class="property-price">₨ 25,500,000</div>
                        <div class="property-details">
                            <span class="property-detail">3 Beds</span>
                            <span class="property-detail">2 Baths</span>
                            <span class="property-detail">1,800 Sq Ft</span>
                        </div>
                        <div class="property-type">Apartment</div>
                    </div>
                </div>
                
                <!-- Property 3 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Commercial Land in Kalanki</h3>
                        <div class="property-location">📍 Kalanki, Kathmandu</div>
                        <div class="property-price">₨ 70,000,000</div>
                        <div class="property-details">
                            <span class="property-detail">10,000 Sq Ft</span>
                            <span class="property-detail">Road Access</span>
                            <span class="property-detail">Flat</span>
                        </div>
                        <div class="property-type">Commercial Land</div>
                    </div>
                </div>
                
                <!-- Property 4 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Family House in Bhaktapur</h3>
                        <div class="property-location">📍 Nagarkot, Bhaktapur</div>
                        <div class="property-price">₨ 38,000,000</div>
                        <div class="property-details">
                            <span class="property-detail">5 Beds</span>
                            <span class="property-detail">3 Baths</span>
                            <span class="property-detail">3,200 Sq Ft</span>
                        </div>
                        <div class="property-type">Residential</div>
                    </div>
                </div>
                
                <!-- Property 5 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Riverside Villa in Pokhara</h3>
                        <div class="property-location">📍 Lakeside, Pokhara</div>
                        <div class="property-price">₨ 55,000,000</div>
                        <div class="property-details">
                            <span class="property-detail">4 Beds</span>
                            <span class="property-detail">4 Baths</span>
                            <span class="property-detail">3,500 Sq Ft</span>
                        </div>
                        <div class="property-type">Villa</div>
                    </div>
                </div>
                
                <!-- Property 6 -->
                <div class="property-card">
                    <div class="property-image" style="background-image: url('/api/placeholder/350/200')">
                        <div class="property-tag">For Sale</div>
                    </div>
                    <div class="property-info">
                        <h3 class="property-title">Luxury Apartment in Baluwatar</h3>
                        <div class="property-location">📍 Baluwatar, Kathmandu</div>
                        <div class="property-price">₨ 55,000,000</div>
                        <div class="property-details">
                            <span class="property-detail">4 Beds</span>
                            <span class="property-detail">3 Baths</span>
                            <span class="property-detail">2,500 Sq Ft</span>
                        </div>
                        <div class="property-type">Apartment</div>
                    </div>
                </div>
            </div>
            
            <!-- Pagination -->
            <div class="pagination">
                <div class="pagination-item active">1</div>
                <div class="pagination-item">2</div>
                <div class="pagination-item">3</div>
                <div class="pagination-item">4</div>
                <div class="pagination-item">5</div>
                <div class="pagination-item">→</div>
            </div>
        </div>
    </div>

    <!-- Footer -->
   <jsp:include page="/pages/footer.jsp" />
    <script src="${pageContext.request.contextPath}/js/buypage.js"></script>
</body>
</html>