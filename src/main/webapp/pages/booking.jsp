<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Properties - Shangri-La Estates</title>
    
    <!-- Stylesheets -->
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buy.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buypage.css">
</head>
<body>

<!-- Header -->
<jsp:include page="/pages/headerSignout.jsp" />
<c:if test="${empty properties}">
    <jsp:forward page="/propertyServlet" />
</c:if>

<!-- Hero Section -->
<section class="hero">
    <h1>Find Your Dream Property in Nepal</h1>
    <p>Browse through our extensive collection of properties for sale across Nepal.</p>

    <!-- Search Form -->
    <form action="${pageContext.request.contextPath}/propertyServlet" method="get" id="searchForm">
        <div class="search-container">
            <!-- Location -->
            <div class="search-input">
                <label for="location">Location</label>
                <select name="location" id="location">
                    <option value="All of Nepal" ${param.location == 'All of Nepal' || empty param.location ? 'selected' : ''}>All of Nepal</option>
                    <option value="Kathmandu" ${param.location == 'Kathmandu' ? 'selected' : ''}>Kathmandu</option>
                    <option value="Pokhara" ${param.location == 'Pokhara' ? 'selected' : ''}>Pokhara</option>
                    <option value="Lalitpur" ${param.location == 'Lalitpur' ? 'selected' : ''}>Lalitpur</option>
                    <option value="Bhaktapur" ${param.location == 'Bhaktapur' ? 'selected' : ''}>Bhaktapur</option>
                    <option value="Chitwan" ${param.location == 'Chitwan' ? 'selected' : ''}>Chitwan</option>
                </select>
            </div>

            <!-- Property Type -->
            <div class="search-input">
                <label for="propertyType">Property Type</label>
                <select name="propertyType" id="propertyType">
                    <option value="All Types" ${empty param.propertyType || param.propertyType == 'All Types' ? 'selected' : ''}>All Types</option>
                    <option value="House" ${param.propertyType == 'House' ? 'selected' : ''}>House</option>
                    <option value="Apartment" ${param.propertyType == 'Apartment' ? 'selected' : ''}>Apartment</option>
                    <option value="Land" ${param.propertyType == 'Land' ? 'selected' : ''}>Land</option>
                    <option value="Commercial" ${param.propertyType == 'Commercial' ? 'selected' : ''}>Commercial</option>
                </select>
            </div>

            <!-- Budget Range -->
            <div class="search-input">
                <label for="budgetRange">Budget</label>
                <select name="budgetRange" id="budgetRange">
                    <option value="" ${empty param.budgetRange ? 'selected' : ''}>Any Budget</option>
                    <option value="0-5000000" ${param.budgetRange == '0-5000000' ? 'selected' : ''}>Below ₨5,000,000</option>
                    <option value="5000000-10000000" ${param.budgetRange == '5000000-10000000' ? 'selected' : ''}>₨5,000,000 - 10,000,000</option>
                    <option value="10000000-20000000" ${param.budgetRange == '10000000-20000000' ? 'selected' : ''}>₨10,000,000 - 20,000,000</option>
                    <option value="20000000-50000000" ${param.budgetRange == '20000000-50000000' ? 'selected' : ''}>₨20,000,000 - 50,000,000</option>
                    <option value="50000000-999999999" ${param.budgetRange == '50000000-999999999' ? 'selected' : ''}>Above ₨50,000,000</option>
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
            <!-- Hidden Fields -->
            <input type="hidden" name="location" value="${param.location}">
            <input type="hidden" name="sort" id="sortInput" value="${param.sort}">

            <!-- Price Range -->
            <div class="filter-group">
                <label class="filter-label">Price Range</label>
                <div class="price-inputs">
                    <input type="text" name="minPrice" placeholder="Min" class="filter-input" value="${param.minPrice}">
                    <input type="text" name="maxPrice" placeholder="Max" class="filter-input" value="${param.maxPrice}">
                </div>
            </div>

            <!-- Property Type -->
            <div class="filter-group">
                <label class="filter-label">Property Type</label>
                <div class="checkbox-group">
                    <input type="radio" id="all-types" name="propertyType" value="All Types" ${empty param.propertyType || param.propertyType == 'All Types' ? 'checked' : ''}>
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

            <!-- Bedrooms -->
            <div class="filter-group">
                <label class="filter-label">Bedrooms</label>
                <div class="checkbox-group">
                    <input type="radio" id="bed-all" name="bedrooms" value="" ${empty param.bedrooms ? 'checked' : ''}>
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

            <!-- Bathrooms -->
            <div class="filter-group">
                <label class="filter-label">Bathrooms</label>
                <div class="checkbox-group">
                    <input type="radio" id="bath-all" name="bathrooms" value="" ${empty param.bathrooms ? 'checked' : ''}>
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

            <!-- Area -->
            <div class="filter-group">
                <label class="filter-label">Area (Sq Ft)</label>
                <div class="price-inputs">
                    <input type="text" name="minArea" placeholder="Min" class="filter-input" value="${param.minArea}">
                    <input type="text" name="maxArea" placeholder="Max" class="filter-input" value="${param.maxArea}">
                </div>
            </div>

            <!-- Buttons -->
            <button type="submit" class="filter-btn">Apply Filters</button>
            <button type="button" class="reset-btn" onclick="resetFilters()">Reset Filters</button>
        </form>
    </div>

    <!-- Properties Container -->
    <div class="properties-container">
        <!-- Sort Controls -->
        <div class="sort-container">
            <div class="property-count">Showing ${properties.size()} of ${totalProperties} properties</div>
            <select class="sort-select" id="sortSelect" onchange="changeSort()">
                <option value="newest" ${empty param.sort || param.sort == 'newest' ? 'selected' : ''}>Sort by: Newest</option>
                <option value="priceAsc" ${param.sort == 'priceAsc' ? 'selected' : ''}>Price: Low to High</option>
                <option value="priceDesc" ${param.sort == 'priceDesc' ? 'selected' : ''}>Price: High to Low</option>
                <option value="areaAsc" ${param.sort == 'areaAsc' ? 'selected' : ''}>Area: Low to High</option>
                <option value="areaDesc" ${param.sort == 'areaDesc' ? 'selected' : ''}>Area: High to Low</option>
            </select>
        </div>

        <!-- Property Cards -->
        <div class="property-grid">
            <c:if test="${not empty properties}">
            <p>Rendering ${fn:length(properties)} properties</p>
                <c:forEach var="property" items="${properties}">
                    <div class="property-card">
                        <div class="property-image" style="background-image: url('${not empty property.primaryImagePath ? property.primaryImagePath : '/images/default.jpg'}')">
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
                            <div class="property-type">
                                <c:choose>
                                    <c:when test="${property.title.contains('Apartment')}">Apartment</c:when>
                                    <c:when test="${property.title.contains('Land')}">Land</c:when>
                                    <c:when test="${property.title.contains('Commercial')}">Commercial</c:when>
                                    <c:otherwise>House</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty properties}">
                <div class="no-properties">
                    <h3>No properties found</h3>
                    <p>Please adjust your filters.</p>
                </div>
            </c:if>
        </div>

         <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages > 5 ? 5 : totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/property?page=${i}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&minArea=${param.minArea}&maxArea=${param.maxArea}&sort=${param.sort}" 
                           class="pagination-item ${currentPage == i ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/property?page=${currentPage + 1}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&minArea=${param.minArea}&maxArea=${param.maxArea}&sort=${param.sort}" 
                           class="pagination-item">→</a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>


<!-- Footer -->
<jsp:include page="/pages/footer.jsp" />

<!-- JavaScript -->
<script>
    function changeSort() {
        document.getElementById("sortInput").value = document.getElementById("sortSelect").value;
        document.getElementById("filterForm").submit();
    }

    function resetFilters() {
        window.location.href = "${pageContext.request.contextPath}/propertyServlet";
    }

    // Handle budget range selection
    document.addEventListener('DOMContentLoaded', function () {
        const budgetRangeSelect = document.querySelector('select[name="budgetRange"]');
        if (budgetRangeSelect) {
            budgetRangeSelect.addEventListener('change', function () {
                const selectedValue = this.value;
                let minPriceField = document.querySelector('input[name="minPrice"]', document.getElementById('searchForm'));
                let maxPriceField = document.querySelector('input[name="maxPrice"]', document.getElementById('searchForm'));

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

                if (selectedValue) {
                    const [min, max] = selectedValue.split('-');
                    minPriceField.value = min;
                    maxPriceField.value = max;
                } else {
                    minPriceField.value = '';
                    maxPriceField.value = '';
                }
            });
        }
    });
</script>

</body>
</html>