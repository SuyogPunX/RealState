<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Properties - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buy.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buypage.css">
    
    	<style>
		.appointment-btn {
	    margin-top: 10px;
	    background-color: #3498db; /* Blue */
	    color: white;
	    border: none;
	    padding: 10px 15px;
	    font-size: 14px;
	    font-weight: bold;
	    border-radius: 6px;
	    cursor: pointer;
	    transition: background-color 0.3s ease;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    display: flex;
	    justify-content:center;
	}
	
	.appointment-btn:hover {
	    background-color: #2980b9;
	}
	/* Modal Overlay */
	.modal {
	    display: none;
	    position: fixed;
	    z-index: 9999;
	    left: 0; top: 0;
	    width: 100%; height: 100%;
	    background-color: rgba(0, 0, 0, 0.4);
	    justify-content: center;
	    align-items: center;
	}
	
	/* Glassmorphism Form Container */
	.form-container {
	    background: rgba(255, 255, 255, 0.85);
	    backdrop-filter: blur(10px);
	    border-radius: 16px;
	    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
	    padding: 40px;
	    width: 100%;
	    max-width: 500px;
	    animation: fadeIn 0.5s ease-in-out;
	}
	
	@keyframes fadeIn {
	    from { opacity: 0; transform: translateY(10px); }
	    to { opacity: 1; transform: translateY(0); }
	}
	
	/* Form Group */
	.form-group {
	    margin-bottom: 20px;
	}
	
	.form-group label {
	    display: block;
	    font-weight: bold;
	    margin-bottom: 6px;
	    color: #333;
	}
	
	/* Input Styles */
	.form-control {
	    width: 100%;
	    padding: 10px 14px;
	    font-size: 14px;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    background-color: #f9f9f9;
	    transition: border-color 0.3s;
	}
	
	.form-control:focus {
	    border-color: #3498db;
	    outline: none;
	}
	
	/* Button Styles */
	.form-actions {
	    display: flex;
	    justify-content: space-between;
	    gap: 10px;
	    margin-top: 20px;
	}
	
	.btn {
	    flex: 1;
	    padding: 10px 15px;
	    border: none;
	    border-radius: 8px;
	    cursor: pointer;
	    font-size: 14px;
	    font-weight: bold;
	    transition: background-color 0.3s ease;
	}
	
	.btn-primary {
	    background-color: #3498db;
	    color: white;
	}
	.btn-primary:hover {
	    background-color: #2980b9;
	}
	
	.btn-outline {
	    background-color: transparent;
	    color: #3498db;
	    border: 2px solid #3498db;
	}
	.btn-outline:hover {
	    background-color: #3498db;
	    color: white;
	}
	
		.appointment-btn:disabled {
	    background-color: #bdc3c7;
	    cursor: not-allowed;
	}
	
		/* Pagination Styles */
	.pagination {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    margin: 30px 0;
	    gap: 8px;
	    flex-wrap: wrap;
	}
	
	.pagination-item {
	    display: inline-block;
	    padding: 8px 14px;
	    border-radius: 6px;
	    background-color: #ecf0f1;
	    color: #2c3e50;
	    text-decoration: none;
	    font-weight: bold;
	    transition: background-color 0.3s ease, color 0.3s ease;
	    cursor: pointer;
	    border: 1px solid transparent;
	    user-select: none;
	}
	
	.pagination-item:hover {
	    background-color: #3498db;
	    color: white;
	    border-color: #2980b9;
	}
	
	.pagination-item.active {
	    background-color: #2980b9;
	    color: white;
	    border-color: #2471a3;
	    pointer-events: none;
	    box-shadow: 0 0 0 2px rgba(41, 128, 185, 0.5);
	}
	
	.property-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
    padding: 20px 0;
	}
	
	.sort-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    flex-wrap: wrap;
    gap: 10px;
	}
	
	.property-count {
	    font-size: 14px;
	    color: #555;
	}
	
	.sort-select {
	    padding: 8px 12px;
	    font-size: 14px;
	    border-radius: 6px;
	    border: 1px solid #ccc;
	}
	
	</style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/pages/headerSignout.jsp" />
    
	<%
	    // Check if no query parameters exist (i.e., user accessed buy.jsp directly)
	    if (request.getQueryString() == null || request.getQueryString().isEmpty()) {
	        // Redirect to propertyServlet with default filters
	        response.sendRedirect(request.getContextPath() + "/propertyServlet?location=All+of+Nepal&propertyType=All+Types");
	        return; // Stop further processing of the JSP
	    }
	%>

    <!-- Hero Section -->
    <section class="hero">
        <h1>Find Your Dream Property in Nepal</h1>
        <p>Browse through our extensive collection of properties for sale across Nepal.</p>
        
        <form action="${pageContext.request.contextPath}/propertyServlet" method="get" id="searchForm">
            <div class="search-container">
                <div class="search-input">
                    <label>Location</label>
                    <select name="location">
                        <option value="All of Nepal" ${param.location == 'All of Nepal' ||  empty param.location  ? 'selected' : ''}>All of Nepal</option>
                        <option value="Kathmandu" ${param.location == 'Kathmandu' ? 'selected' : ''}>Kathmandu</option>
                        <option value="Pokhara" ${param.location == 'Pokhara' ? 'selected' : ''}>Pokhara</option>
                        <option value="Lalitpur" ${param.location == 'Lalitpur' ? 'selected' : ''}>Lalitpur</option>
                        <option value="Bhaktapur" ${param.location == 'Bhaktapur' ? 'selected' : ''}>Bhaktapur</option>
                        <option value="Chitwan" ${param.location == 'Chitwan' ? 'selected' : ''}>Chitwan</option>
                    </select>
                </div>
                <div class="search-input">
                    <label>Property Type</label>
                    <select name="propertyType">
                        <option value="All Types" ${param.propertyType == 'All Types' || empty param.propertyType ? 'selected' : ''}>All Types</option>
                        <option value="House" ${param.propertyType == 'House' ? 'selected' : ''}>House</option>
                        <option value="Apartment" ${param.propertyType == 'Apartment' ? 'selected' : ''}>Apartment</option>
                        <option value="Land" ${param.propertyType == 'Land' ? 'selected' : ''}>Land</option>
                        <option value="Commercial" ${param.propertyType == 'Commercial' ? 'selected' : ''}>Commercial</option>
                    </select>
                </div>
                <div class="search-input">
                    <label>Budget</label>
                    <select name="budgetRange">
                        <option value="">Any Budget</option>
                        <option value="0-5000000" ${param.budgetRange == '0-5000000' ? 'selected' : ''}>Below 5,000,000</option>
                        <option value="5000000-10000000" ${param.budgetRange == '5000000-10000000' ? 'selected' : ''}>5,000,000 - 10,000,000</option>
                        <option value="10000000-20000000" ${param.budgetRange == '10000000-20000000' ? 'selected' : ''}>10,000,000 - 20,000,000</option>
                        <option value="20000000-50000000" ${param.budgetRange == '20000000-50000000' ? 'selected' : ''}>20,000,000 - 50,000,000</option>
                        <option value="50000000-999999999" ${param.budgetRange == '50000000-999999999' ? 'selected' : ''}>Above 50,000,000</option>
                    </select>
                </div>
                <button type="submit" class="search-btn">Search Properties</button>
            </div>
        </form>
    </section>

    <!-- Main Content -->
    <div class="content-container">
        <!-- Filter Sidebar -->
        <div class="filter-sidebar">
            <h3 class="filter-title">Filter Properties</h3>
            
            <form action="${pageContext.request.contextPath}/propertyServlet" method="get" id="filterForm">
                <!-- Hidden inputs to preserve search values -->
                <input type="hidden" name="location" value="${param.location}">
                <input type="hidden" name="sort" id="sortInput" value="${param.sortBy}">
                
                <div class="filter-group">
                    <label class="filter-label">Price Range</label>
                    <div class="price-inputs">
                        <input type="text" name="minPrice" placeholder="Min" class="filter-input" value="${param.minPrice}">
                        <input type="text" name="maxPrice" placeholder="Max" class="filter-input" value="${param.maxPrice}">
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Property Type</label>
                    <div class="checkbox-group">
                        <input type="radio" id="all-types" name="propertyType" value="All Types" ${param.propertyType == 'All Types' || param.propertyType == null ? 'checked' : ''}> 
                        <label for="all-types">All Types</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="house" name="propertyType" value="House" ${param.propertyType == 'House' ? 'checked' : ''}> 
                        <label for="house">House</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="apartment" name="propertyType" value="Apartment" ${param.propertyType == 'Apartment' ? 'checked' : ''}> 
                        <label for="apartment">Apartment</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="land" name="propertyType" value="Land" ${param.propertyType == 'Land' ? 'checked' : ''}>
                        <label for="land">Land</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="commercial" name="propertyType" value="Commercial" ${param.propertyType == 'Commercial' ? 'checked' : ''}>
                        <label for="commercial">Commercial</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Bedrooms</label>
                    <div class="checkbox-group">
                        <input type="radio" id="bed-all" name="bedrooms" value="" ${param.bedrooms == null ? 'checked' : ''}> 
                        <label for="bed-all">Any</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bed1" name="bedrooms" value="bed1" ${param.bedrooms == 'bed1' ? 'checked' : ''}> 
                        <label for="bed1">1 Bedroom</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bed2" name="bedrooms" value="bed2" ${param.bedrooms == 'bed2' ? 'checked' : ''}> 
                        <label for="bed2">2 Bedrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bed3" name="bedrooms" value="bed3" ${param.bedrooms == 'bed3' ? 'checked' : ''}>
                        <label for="bed3">3 Bedrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bed4" name="bedrooms" value="bed4" ${param.bedrooms == 'bed4' ? 'checked' : ''}>
                        <label for="bed4">4+ Bedrooms</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Bathrooms</label>
                    <div class="checkbox-group">
                        <input type="radio" id="bath-all" name="bathrooms" value="" ${param.bathrooms == null ? 'checked' : ''}> 
                        <label for="bath-all">Any</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bath1" name="bathrooms" value="bath1" ${param.bathrooms == 'bath1' ? 'checked' : ''}> 
                        <label for="bath1">1 Bathroom</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bath2" name="bathrooms" value="bath2" ${param.bathrooms == 'bath2' ? 'checked' : ''}> 
                        <label for="bath2">2 Bathrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="radio" id="bath3" name="bathrooms" value="bath3" ${param.bathrooms == 'bath3' ? 'checked' : ''}>
                        <label for="bath3">3+ Bathrooms</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Area (Sq Ft)</label>
                    <div class="price-inputs">
                        <input type="text" name="minArea" placeholder="Min" class="filter-input" value="${param.minArea}">
                        <input type="text" name="maxArea" placeholder="Max" class="filter-input" value="${param.maxArea}">
                    </div>
                </div>
                
                <button type="submit" class="filter-btn">Apply Filters</button>
                <button type="button" class="reset-btn" onclick="resetFilters()">Reset Filters</button>
            </form>
        </div>
        
        <!-- Properties Container -->
        <div class="properties-container">
            <div class="sort-container">
                <div class="property-count">Showing ${properties.size()} of ${totalProperties} properties</div>
                <select class="sort-select" id="sortSelect" onchange="changeSort()">
                    <option value="newest" ${param.sort == 'newest' || param.sort == null ? 'selected' : ''}>Sort by: Newest</option>
                    <option value="priceAsc" ${param.sort == 'priceAsc' ? 'selected' : ''}>Price: Low to High</option>
                    <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Price: High to Low</option>
                    <option value="areaAsc" ${param.sort == 'areaAsc' ? 'selected' : ''}>Area: Low to High</option>
                    <option value="areaDesc" ${param.sort == 'areaDesc' ? 'selected' : ''}>Area: High to Low</option>
                </select>
            </div>
            
            <div class="property-grid">
                <c:if test="${not empty properties}">
                    <c:forEach var="property" items="${properties}">
                        <div class="property-card">
                           <div class="property-image" 
							     style="background-image: url('${pageContext.request.contextPath}${property.primaryImagePath}');">
							    <div class="property-tag">For Sale</div>
							</div>
                            <div class="property-info">
                                <h3 class="property-title">${property.title}</h3>
                                <div class="property-location">📍 ${property.location}</div>
                                <div class="property-price">₨ ${property.formattedPrice}</div>
                                <div class="property-details">
                                    <c:if test="${property.bedrooms > 0}">
                                        <span class="property-detail">${property.bedrooms} Beds</span>
                                    </c:if>
                                    <c:if test="${property.bathrooms > 0}">
                                        <span class="property-detail">${property.bathrooms} Baths</span>
                                    </c:if>
                                    <span class="property-detail">${property.areaSqft} Sq Ft</span>
                                </div>
                                <div class="property-type">${property.title.contains('Apartment') ? 'Apartment' : 
                                                         property.title.contains('Land') ? 'Land' : 
                                                         property.title.contains('Commercial') ? 'Commercial' : 'Residential'}</div>
                           		<div class="book-appointment">
   									 <button class="appointment-btn" onclick="openBookingModal(${property.propertyId})">Appointment</button>
								</div>                     
                                   
                            </div>
                        </div>

                    </c:forEach>
                </c:if>
                
                <!-- If no properties found -->
                <c:if test="${empty properties}">
                    <div class="no-properties">
                        <h3>No properties found matching your criteria</h3>
                        <p>Please try adjusting your filters or search terms.</p>
                    </div>
                </c:if>
            </div>
            
            <!-- Pagination -->
					<c:if test="${totalPages > 1}">
		    <div class="pagination">
		        <!-- Previous Button -->
		        <c:if test="${currentPage > 1}">
		            <a href="${pageContext.request.contextPath}/propertyServlet?page=${currentPage - 1}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&minArea=${param.minArea}&maxArea=${param.maxArea}&sort=${param.sort}" 
		               class="pagination-item">←</a>
		        </c:if>
		
		        <!-- Page Numbers -->
		        <c:forEach begin="1" end="${totalPages}" var="i">
		            <c:choose>
		                <c:when test="${currentPage == i}">
		                    <span class="pagination-item active">${i}</span>
		                </c:when>
		                <c:otherwise>
		                    <a href="${pageContext.request.contextPath}/propertyServlet?page=${i}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&minArea=${param.minArea}&maxArea=${param.maxArea}&sort=${param.sort}" 
		                       class="pagination-item">${i}</a>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		
		        <!-- Next Button -->
		        <c:if test="${currentPage < totalPages}">
		            <a href="${pageContext.request.contextPath}/propertyServlet?page=${currentPage + 1}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&minArea=${param.minArea}&maxArea=${param.maxArea}&sort=${param.sort}" 
		               class="pagination-item">→</a>
		        </c:if>
		    </div>
		</c:if>
        </div>
    </div>

	<!-- Booking Modal -->
<div id="bookingModal" class="modal">
    <div class="form-container">
        <h1>Book an Appointment</h1>
        <form action="${pageContext.request.contextPath}/BookAppointmentServlet" method="post">
            <!-- Property ID -->
            <div class="form-group">
                <label for="propertyId">Property ID</label>
                <input type="text" id="propertyId" name="propertyId" value="" readonly class="form-control" />
            </div>

            <!-- Booking Time -->
            <div class="form-group">
                <label for="bookingTime">Select Date & Time</label>
                <input type="datetime-local" id="bookingTime" name="booking_time" class="form-control" required />
            </div>

            <!-- Meeting Location -->
            <div class="form-group">
                <label for="meetingLocation">Meeting Location</label>
                <input type="text" id="meetingLocation" name="meeting_location" placeholder="Enter meeting address" class="form-control" required />
            </div>

            <!-- Action Buttons -->
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Confirm Appointment</button>
                <button type="button" class="btn btn-outline" onclick="closeBookingModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>


	
	<script>
	// JavaScript to Open/Close Modal
	function openBookingModal(propertyId) {
	    document.getElementById("propertyId").value = propertyId;
	    document.getElementById("bookingModal").style.display = "flex";
	}
	
	function closeBookingModal() {
	    document.getElementById("bookingModal").style.display = "none";
	}
	</script>
    
    <script>
        function changeSort() {
            const sortSelect = document.getElementById('sortSelect');
            document.getElementById('sortInput').value = sortSelect.value;
            document.getElementById('filterForm').submit();
        }
        
        function resetFilters() {
            window.location.href = "${pageContext.request.contextPath}/propertyServlet";
        }
        
        // Handle the budget range selection
        document.addEventListener('DOMContentLoaded', function() {
            const budgetRangeSelect = document.querySelector('select[name="budgetRange"]');
            
            if (budgetRangeSelect) {
                budgetRangeSelect.addEventListener('change', function() {
                    const selectedValue = this.value;
                    
                    if (selectedValue) {
                        const [min, max] = selectedValue.split('-');
                        
                        // Set hidden fields in the search form
                        let minPriceField = document.querySelector('input[name="minPrice"]', document.getElementById('searchForm'));
                        let maxPriceField = document.querySelector('input[name="maxPrice"]', document.getElementById('searchForm'));
                        
                        // If they don't exist, create them
                        if (!minPriceField) {
                            minPriceField = document.createElement('input');
                            minPriceField.type = 'hidden';
                            minPriceField.name = 'minPrice';
                            document.getElementById('searchForm').appendChild(minPriceField);
                        }
                        
                        if (!maxPriceField) {
                            maxPriceField = document.createElement('input');
                            maxPriceField.type = 'hidden';
                            maxPriceField.name = 'maxPrice';
                            document.getElementById('searchForm').appendChild(maxPriceField);
                        }
                        
                        minPriceField.value = min;
                        maxPriceField.value = max;
                    }
                });
            }
            
            // Debug - log if properties are available
            console.log('Properties count: ${properties.size()}');
            console.log('Total properties: ${totalProperties}');
        });

  
    </script>
</body>
</html>