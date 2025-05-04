<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.webmodel.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.web.DAO.PropertyDAO" %> 

<%
    // Create a mock PropertyDAO if the actual one isn't available yet
    PropertyDAO propertyDAO;
    try {
        propertyDAO = new PropertyDAO();
    } catch (Exception e) {
        // Create a mock PropertyDAO for testing
        propertyDAO = new PropertyDAO() {
            public List<Property> getFilteredProperties(
                String location, String propertyType, Double minPrice, Double maxPrice, 
                Double minArea, Double maxArea, String[] bedrooms, String[] bathrooms) {
                
                List<Property> mockProperties = new ArrayList<>();
                
                // Add some mock properties
                Property p1 = new Property();
                p1.setPropertyId(1);
                p1.setTitle("Luxury Villa in Kathmandu");
                p1.setLocation("Baluwatar, Kathmandu");
                p1.setPrice(45000000.0);
                p1.setBedrooms(4);
                p1.setBathrooms(3);
                p1.setAreaSqft(2500.0);
                p1.setAvailable(true);
         
                mockProperties.add(p1);
                
                Property p2 = new Property();
                p2.setPropertyId(2);
                p2.setTitle("Modern Apartment in Patan");
                p2.setLocation("Patan, Lalitpur");
                p2.setPrice(25500000.0);
                p2.setBedrooms(3);
                p2.setBathrooms(2);
                p2.setAreaSqft(1800.0);
                p2.setAvailable(true);

                mockProperties.add(p2);
                
                Property p3 = new Property();
                p3.setPropertyId(3);
                p3.setTitle("Commercial Land in Kalanki");
                p3.setLocation("Kalanki, Kathmandu");
                p3.setPrice(70000000.0);
                p3.setBedrooms(0);
                p3.setBathrooms(0);
                p3.setAreaSqft(10000.0);
                p3.setAvailable(true);

                mockProperties.add(p3);
                
                // Filter properties based on parameters
                List<Property> filteredProperties = new ArrayList<>();
                for (Property property : mockProperties) {
                    boolean matchesFilters = true;
                    
                    // Apply location filter
                    if (location != null && !location.equals("All of Nepal")) {
                        if (!property.getLocation().contains(location)) {
                            matchesFilters = false;
                        }
                    }
                    
                    // Apply property type filter
                    if (propertyType != null && !propertyType.equals("All Types")) {
                        if (!property.getTitle().toLowerCase().contains(propertyType.toLowerCase())) {
                            matchesFilters = false;
                        }
                    }
                    
                    // Apply price filter
                    if (minPrice != null && property.getPrice() < minPrice) {
                        matchesFilters = false;
                    }
                    if (maxPrice != null && property.getPrice() > maxPrice) {
                        matchesFilters = false;
                    }
                    
                    // Apply area filter
                    if (minArea != null && property.getAreaSqft() < minArea) {
                        matchesFilters = false;
                    }
                    if (maxArea != null && property.getAreaSqft() > maxArea) {
                        matchesFilters = false;
                    }
                    
                    // Apply bedroom filter
                    if (bedrooms != null && bedrooms.length > 0) {
                        boolean bedroomMatch = false;
                        for (String bedroom : bedrooms) {
                            int bedroomCount = Integer.parseInt(bedroom);
                            if (bedroomCount == 4 && property.getBedrooms() >= 4) {
                                bedroomMatch = true;
                                break;
                            } else if (property.getBedrooms() == bedroomCount) {
                                bedroomMatch = true;
                                break;
                            }
                        }
                        if (!bedroomMatch) {
                            matchesFilters = false;
                        }
                    }
                    
                    // Apply bathroom filter
                    if (bathrooms != null && bathrooms.length > 0) {
                        boolean bathroomMatch = false;
                        for (String bathroom : bathrooms) {
                            int bathroomCount = Integer.parseInt(bathroom);
                            if (bathroomCount == 3 && property.getBathrooms() >= 3) {
                                bathroomMatch = true;
                                break;
                            } else if (property.getBathrooms() == bathroomCount) {
                                bathroomMatch = true;
                                break;
                            }
                        }
                        if (!bathroomMatch) {
                            matchesFilters = false;
                        }
                    }
                    
                    if (matchesFilters) {
                        filteredProperties.add(property);
                    }
                }
                
                return filteredProperties;
            }
        };
    }
    
    // Initialize filter parameters with defaults
    String location = request.getParameter("location") != null ? request.getParameter("location") : "All of Nepal";
    String propertyType = request.getParameter("propertyType") != null ? request.getParameter("propertyType") : "All Types";
    String budget = request.getParameter("budget") != null ? request.getParameter("budget") : "Any Budget";
    
    // Parse min/max values if present
    Double minPrice = null;
    Double maxPrice = null;
    Double minArea = null; 
    Double maxArea = null;
    
    if(request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty()) {
        try {
            minPrice = Double.parseDouble(request.getParameter("minPrice"));
        } catch(NumberFormatException e) {
            // Handle parsing error
        }
    }
    
    if(request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty()) {
        try {
            maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
        } catch(NumberFormatException e) {
            // Handle parsing error
        }
    }
    
    if(request.getParameter("minArea") != null && !request.getParameter("minArea").isEmpty()) {
        try {
            minArea = Double.parseDouble(request.getParameter("minArea"));
        } catch(NumberFormatException e) {
            // Handle parsing error
        }
    }
    
    if(request.getParameter("maxArea") != null && !request.getParameter("maxArea").isEmpty()) {
        try {
            maxArea = Double.parseDouble(request.getParameter("maxArea"));
        } catch(NumberFormatException e) {
            // Handle parsing error
        }
    }
    
    // Get bedroom and bathroom filters
    String[] bedrooms = request.getParameterValues("bedrooms");
    String[] bathrooms = request.getParameterValues("bathrooms");
    
    // Get properties based on filters
    List<Property> properties = propertyDAO.getFilteredProperties(
        location, propertyType, minPrice, maxPrice, 
        minArea, maxArea, bedrooms, bathrooms
    );
    
    // For sorting
    String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "Newest";
    
    // Sort the properties based on the selected option
    if(sortBy.equals("Price: Low to High")) {
        properties.sort((p1, p2) -> Double.compare(p1.getPrice(), p2.getPrice()));
    } else if(sortBy.equals("Price: High to Low")) {
        properties.sort((p1, p2) -> Double.compare(p2.getPrice(), p1.getPrice()));
    } else if(sortBy.equals("Area: Low to High")) {
        properties.sort((p1, p2) -> Double.compare(p1.getAreaSqft(), p2.getAreaSqft()));
    } else if(sortBy.equals("Area: High to Low")) {
        properties.sort((p1, p2) -> Double.compare(p2.getAreaSqft(), p1.getAreaSqft()));
    }
    // "Newest" sorting would be handled by createdAt, but we'll leave default DAO sorting for this
    
    // Pagination
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int propertiesPerPage = 6;
    int startIndex = (currentPage - 1) * propertiesPerPage;
    int endIndex = Math.min(startIndex + propertiesPerPage, properties.size());
    
    List<Property> pagedProperties = properties.subList(startIndex, endIndex);
    int totalPages = (int) Math.ceil((double) properties.size() / propertiesPerPage);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buy Properties - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buypage.css">
    <style>
        /* Add additional styles for images */
        .property-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
            border-radius: 8px 8px 0 0;
        }
        
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="/pages/headerSignout.jsp" />

    <!-- Hero Section -->
    <section class="hero">
        <h1>Find Your Dream Property in Nepal</h1>
        <p>Browse through our extensive collection of properties for sale across Nepal.</p>
        
        <form action="${pageContext.request.contextPath}/buy" method="get" class="search-container">
            <div class="search-input">
                <label>Location</label>
                <select name="location">
                    <option value="All of Nepal" <%= location.equals("All of Nepal") ? "selected" : "" %>>All of Nepal</option>
                    <option value="Kathmandu" <%= location.equals("Kathmandu") ? "selected" : "" %>>Kathmandu</option>
                    <option value="Pokhara" <%= location.equals("Pokhara") ? "selected" : "" %>>Pokhara</option>
                    <option value="Lalitpur" <%= location.equals("Lalitpur") ? "selected" : "" %>>Lalitpur</option>
                    <option value="Bhaktapur" <%= location.equals("Bhaktapur") ? "selected" : "" %>>Bhaktapur</option>
                    <option value="Chitwan" <%= location.equals("Chitwan") ? "selected" : "" %>>Chitwan</option>
                </select>
            </div>
            <div class="search-input">
                <label>Property Type</label>
                <select name="propertyType">
                    <option value="All Types" <%= propertyType.equals("All Types") ? "selected" : "" %>>All Types</option>
                    <option value="House" <%= propertyType.equals("House") ? "selected" : "" %>>House</option>
                    <option value="Apartment" <%= propertyType.equals("Apartment") ? "selected" : "" %>>Apartment</option>
                    <option value="Land" <%= propertyType.equals("Land") ? "selected" : "" %>>Land</option>
                    <option value="Commercial" <%= propertyType.equals("Commercial") ? "selected" : "" %>>Commercial</option>
                </select>
            </div>
            <div class="search-input">
                <label>Budget</label>
                <select name="budget">
                    <option value="Any Budget" <%= budget.equals("Any Budget") ? "selected" : "" %>>Any Budget</option>
                    <option value="Below 5,000,000" <%= budget.equals("Below 5,000,000") ? "selected" : "" %>>Below 5,000,000</option>
                    <option value="5,000,000 - 10,000,000" <%= budget.equals("5,000,000 - 10,000,000") ? "selected" : "" %>>5,000,000 - 10,000,000</option>
                    <option value="10,000,000 - 20,000,000" <%= budget.equals("10,000,000 - 20,000,000") ? "selected" : "" %>>10,000,000 - 20,000,000</option>
                    <option value="20,000,000 - 50,000,000" <%= budget.equals("20,000,000 - 50,000,000") ? "selected" : "" %>>20,000,000 - 50,000,000</option>
                    <option value="Above 50,000,000" <%= budget.equals("Above 50,000,000") ? "selected" : "" %>>Above 50,000,000</option>
                </select>
            </div>
            <button type="submit" class="search-btn">Search Properties</button>
        </form>
    </section>

    <!-- Main Content -->
    <div class="content-container">
        <!-- Filter Sidebar -->
        <div class="filter-sidebar">
            <h3 class="filter-title">Filter Properties</h3>
            
            <form action="${pageContext.request.contextPath}/buy" method="get" id="filterForm">
                <div class="filter-group">
                    <label class="filter-label">Price Range</label>
                    <div class="price-inputs">
                        <input type="text" name="minPrice" placeholder="Min" class="filter-input" value="<%= minPrice != null ? minPrice : "" %>">
                        <input type="text" name="maxPrice" placeholder="Max" class="filter-input" value="<%= maxPrice != null ? maxPrice : "" %>">
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Property Type</label>
                    <div class="checkbox-group">
                        <input type="checkbox" id="house" name="propertyType" value="House" <%= propertyType.equals("House") ? "checked" : "" %>> <label for="house">House</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="apartment" name="propertyType" value="Apartment" <%= propertyType.equals("Apartment") ? "checked" : "" %>> <label for="apartment">Apartment</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="land" name="propertyType" value="Land" <%= propertyType.equals("Land") ? "checked" : "" %>> <label for="land">Land</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="commercial" name="propertyType" value="Commercial" <%= propertyType.equals("Commercial") ? "checked" : "" %>> <label for="commercial">Commercial</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Bedrooms</label>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bed1" name="bedrooms" value="1" <%= bedrooms != null && java.util.Arrays.asList(bedrooms).contains("1") ? "checked" : "" %>> <label for="bed1">1 Bedroom</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bed2" name="bedrooms" value="2" <%= bedrooms != null && java.util.Arrays.asList(bedrooms).contains("2") ? "checked" : "" %>> <label for="bed2">2 Bedrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bed3" name="bedrooms" value="3" <%= bedrooms != null && java.util.Arrays.asList(bedrooms).contains("3") ? "checked" : "" %>> <label for="bed3">3 Bedrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bed4" name="bedrooms" value="4" <%= bedrooms != null && java.util.Arrays.asList(bedrooms).contains("4") ? "checked" : "" %>> <label for="bed4">4+ Bedrooms</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Bathrooms</label>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bath1" name="bathrooms" value="1" <%= bathrooms != null && java.util.Arrays.asList(bathrooms).contains("1") ? "checked" : "" %>> <label for="bath1">1 Bathroom</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bath2" name="bathrooms" value="2" <%= bathrooms != null && java.util.Arrays.asList(bathrooms).contains("2") ? "checked" : "" %>> <label for="bath2">2 Bathrooms</label>
                    </div>
                    <div class="checkbox-group">
                        <input type="checkbox" id="bath3" name="bathrooms" value="3" <%= bathrooms != null && java.util.Arrays.asList(bathrooms).contains("3") ? "checked" : "" %>> <label for="bath3">3+ Bathrooms</label>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">Area (Sq Ft)</label>
                    <div class="price-inputs">
                        <input type="text" name="minArea" placeholder="Min" class="filter-input" value="<%= minArea != null ? minArea : "" %>">
                        <input type="text" name="maxArea" placeholder="Max" class="filter-input" value="<%= maxArea != null ? maxArea : "" %>">
                    </div>
                </div>
                
                <button type="submit" class="filter-btn">Apply Filters</button>
                <button type="reset" class="reset-btn" onclick="resetForm()">Reset Filters</button>
            </form>
        </div>
        
        <!-- Properties Container -->
        <div class="properties-container">
            <div class="sort-container">
                <div class="property-count">Showing <%= pagedProperties.size() %> of <%= properties.size() %> properties</div>
                <form id="sortForm" action="${pageContext.request.contextPath}/buy" method="get">
                    <!-- Hidden inputs to maintain filter state -->
                    <input type="hidden" name="location" value="<%= location %>">
                    <input type="hidden" name="propertyType" value="<%= propertyType %>">
                    <input type="hidden" name="budget" value="<%= budget %>">
                    <% if(minPrice != null) { %>
                        <input type="hidden" name="minPrice" value="<%= minPrice %>">
                    <% } %>
                    <% if(maxPrice != null) { %>
                        <input type="hidden" name="maxPrice" value="<%= maxPrice %>">
                    <% } %>
                    <% if(minArea != null) { %>
                        <input type="hidden" name="minArea" value="<%= minArea %>">
                    <% } %>
                    <% if(maxArea != null) { %>
                        <input type="hidden" name="maxArea" value="<%= maxArea %>">
                    <% } %>
                    <% if(bedrooms != null) { 
                        for(String bedroom : bedrooms) { %>
                            <input type="hidden" name="bedrooms" value="<%= bedroom %>">
                        <% }
                    } %>
                    <% if(bathrooms != null) { 
                        for(String bathroom : bathrooms) { %>
                            <input type="hidden" name="bathrooms" value="<%= bathroom %>">
                        <% }
                    } %>
                    
                    <select name="sortBy" class="sort-select" onchange="document.getElementById('sortForm').submit()">
                        <option value="Newest" <%= sortBy.equals("Newest") ? "selected" : "" %>>Sort by: Newest</option>
                        <option value="Price: Low to High" <%= sortBy.equals("Price: Low to High") ? "selected" : "" %>>Price: Low to High</option>
                        <option value="Price: High to Low" <%= sortBy.equals("Price: High to Low") ? "selected" : "" %>>Price: High to Low</option>
                        <option value="Area: Low to High" <%= sortBy.equals("Area: Low to High") ? "selected" : "" %>>Area: Low to High</option>
                        <option value="Area: High to Low" <%= sortBy.equals("Area: High to Low") ? "selected" : "" %>>Area: High to Low</option>
                    </select>
                </form>
            </div>
            
            <div class="property-grid">
                <% for(Property property : pagedProperties) { %>
                    <div class="property-card">
                        <div class="property-image">
                            <% if(property.getImagePath() != null && !property.getImagePath().isEmpty()) { %>
                                <img src="${pageContext.request.contextPath}<%= property.getImagePath() %>" alt="<%= property.getTitle() %>">
                            <% } else { %>
                                <img src="${pageContext.request.contextPath}/assets/images/property-placeholder.jpg" alt="Property Image">
                            <% } %>
                            <div class="property-tag"><%= property.isAvailable() ? "For Sale" : "Sold" %></div>
                        </div>
                        <div class="property-info">
                            <h3 class="property-title"><%= property.getTitle() %></h3>
                            <div class="property-location">📍 <%= property.getLocation() %></div>
                            <div class="property-price">₨ <%= String.format("%,.0f", property.getPrice()) %></div>
                            <div class="property-details">
                                <% if(property.getBedrooms() > 0) { %>
                                    <span class="property-detail"><%= property.getBedrooms() %> Beds</span>
                                <% } %>
                                <% if(property.getBathrooms() > 0) { %>
                                    <span class="property-detail"><%= property.getBathrooms() %> Baths</span>
                                <% } %>
                                <span class="property-detail"><%= String.format("%,.0f", property.getAreaSqft()) %> Sq Ft</span>
                                <% if(property.getStorey() > 0) { %>
                                    <span class="property-detail"><%= property.getStorey() %> Storey</span>
                                <% } %>
                            </div>
                            <% 
                                String propertyTypeDisplay = "";
                                if(property.getTitle().toLowerCase().contains("apartment")) {
                                    propertyTypeDisplay = "Apartment";
                                } else if(property.getTitle().toLowerCase().contains("land") || 
                                          property.getTitle().toLowerCase().contains("commercial")) {
                                    propertyTypeDisplay = "Commercial Land";
                                } else if(property.getTitle().toLowerCase().contains("villa")) {
                                    propertyTypeDisplay = "Villa";
                                } else {
                                    propertyTypeDisplay = "Residential";
                                }
                            %>
                            <div class="property-type"><%= propertyTypeDisplay %></div>
                            <a href="${pageContext.request.contextPath}/property?id=<%= property.getPropertyId() %>" class="view-details-btn">View Details</a>
                        </div>
                    </div>
                <% } %>
                
                <% if(pagedProperties.size() == 0) { %>
                    <div class="no-properties">
                        <h3>No properties found matching your criteria</h3>
                        <p>Try adjusting your filters or search terms.</p>
                    </div>
                <% } %>
            </div>
            
            <!-- Pagination -->
            <% if(totalPages > 1) { %>
                <div class="pagination">
                    <% if(currentPage > 1) { %>
                        <a href="${pageContext.request.contextPath}/buy?page=<%= currentPage - 1 %>&location=<%= location %>&propertyType=<%= propertyType %>&budget=<%= budget %>&sortBy=<%= sortBy %>"
                           class="pagination-item">←</a>
                    <% } %>
                    
                    <% for(int i = 1; i <= totalPages; i++) { %>
                        <a href="${pageContext.request.contextPath}/buy?page=<%= i %>&location=<%= location %>&propertyType=<%= propertyType %>&budget=<%= budget %>&sortBy=<%= sortBy %>"
                           class="pagination-item <%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
                    <% } %>
                    
                    <% if(currentPage < totalPages) { %>
                        <a href="${pageContext.request.contextPath}/buy?page=<%= currentPage + 1 %>&location=<%= location %>&propertyType=<%= propertyType %>&budget=<%= budget %>&sortBy=<%= sortBy %>"
                           class="pagination-item">→</a>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="/pages/footer.jsp" />
    
    <script>
        function resetForm() {
            document.getElementById('filterForm').reset();
            document.getElementById('filterForm').submit();
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/buypage.js"></script>
</body>
</html>