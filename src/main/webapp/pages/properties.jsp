<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Properties - Sangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/properties.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <img src="${pageContext.request.contextPath}/pictures/logo.png" alt="Shangri-La Estates" class="logo-icon" />
                    <span>Sangri-La Estates</span>
                </div>
            </div>
           <a href="${pageContext.request.contextPath}/admin" class="nav-link">Dashboard</a>
			<a href="${pageContext.request.contextPath}/admin?action=properties" class="nav-link active">Properties</a>
			<a href="${pageContext.request.contextPath}/admin?action=users" class="nav-link">Users</a>
			<a href="${pageContext.request.contextPath}/admin?action=inquiries" class="nav-link">Inquaries</a>
		
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-title">
                    <h1>Properties</h1>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="card filter-card">
                <div class="filter-header">
                    <h2>Property Filters</h2>
                </div>
                <div class="filter-body">
                    <form action="${pageContext.request.contextPath}/adminproperties" method="get" id="filterForm">
                        <div class="filter-row">
                            <!-- Property Type -->
                            <div class="filter-item">
                                <label for="propertyType">Property Type</label>
                                <select name="propertyType" id="propertyType" class="form-select">
                                    <option value="">All Types</option>
                                    <option value="Apartment" ${param.propertyType == 'Apartment' ? 'selected' : ''}>Apartment</option>
									<option value="House" ${param.propertyType == 'House' ? 'selected' : ''}>House</option>
									<option value="Commercial" ${param.propertyType == 'Commercial' ? 'selected' : ''}>Commercial</option>
                                </select>
                            </div>

                            <!-- Location -->
                            <div class="filter-item">
                                <label for="location">Location</label>
                                <select name="location" id="location" class="form-select">
                                    <option value="">All Locations</option>
                                    <option value="Kathmandu" ${param.location == 'Kathmandu' ? 'selected' : ''}>Kathmandu</option>
                                    <option value="Pokhara" ${param.location == 'Pokhara' ? 'selected' : ''}>Pokhara</option>
                                    <option value="Lalitpur" ${param.location == 'Lalitpur' ? 'selected' : ''}>Lalitpur</option>
                                    <option value="Bhaktapur" ${param.location == 'Bhaktapur' ? 'selected' : ''}>Bhaktapur</option>
                                    <option value="Biratnagar" ${param.location == 'Biratnagar' ? 'selected' : ''}>Biratnagar</option>
                                </select>
                            </div>

                            <!-- Price Range -->
                            <div class="filter-item">
                                <label>Price Range</label>
                                <div class="price-range">
                                    <input type="number" name="minPrice" placeholder="Min" class="form-input" value="${param.minPrice}">
                                    <span>-</span>
                                    <input type="number" name="maxPrice" placeholder="Max" class="form-input" value="${param.maxPrice}">
                                </div>
                            </div>

                            <!-- Status -->


                        <div class="filter-actions">
                            <button type="submit" class="btn btn-primary">Apply Filters</button>
                            <button type="button" class="btn btn-outline" onclick="resetFilters()">Reset</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Table View -->
            <div class="table-container">
                <div class="table-header">
                    <div class="table-title">All Properties</div>
                    <div class="table-actions">
                        <div class="search-box">
                            <span>🔍</span>
                            <input type="text" placeholder="Search properties..." onkeyup="filterTable(this.value)">
                        </div>
                        <button class="btn btn-primary" id="addPropertyBtn" onclick="openModal()">+ Add Property</button>
                    </div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Property</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th>Added Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="propertyTableBody">
                        <c:if test="${not empty properties}">
                            <c:forEach var="property" items="${properties}" varStatus="loop">
                                <tr>
                                    <td>
                                        <div class="property-item">
                                            <div>${property.title}</div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${property.title.contains('Apartment')}">Apartment</c:when>
                                            <c:when test="${property.title.contains('Land')}">Land</c:when>
                                            <c:when test="${property.title.contains('Commercial')}">Commercial</c:when>
                                            <c:when test="${property.title.contains('Villa')}">Villa</c:when>
                                            <c:otherwise>House</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${property.location}</td>
                                    <td>₨ ${property.formattedPrice}</td>
                                    <td>
									    <c:choose>
									        <c:when test="${property.available}">
									            <span class="badge badge-sale">For Sale</span>
									        </c:when>
									        <c:otherwise>
									            <span class="badge badge-sold">Sold</span>
									        </c:otherwise>
									    </c:choose>
									</td>
                                    <td>${property.createdAt}</td>
                            
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/viewProperty?id=${property.propertyId}">
											    <button class="btn-icon view-btn" title="View Details">👁️</button>
											</a>
											
											<a href="${pageContext.request.contextPath}/editProperty?id=${property.propertyId}">
											    <button class="btn-icon edit-btn" title="Edit">✏️</button>
											</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty properties}">
                            <tr>
                                <td colspan="8" style="text-align:center;">No properties found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <div class="pagination-info">
                            Showing ${startItem} to ${endItem} of ${totalProperties} properties
                        </div>
                        <div class="pagination-buttons">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&sort=${param.sort}"
                                   class="pagination-btn">&#8592; Prev</a>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&sort=${param.sort}"
                                   class="pagination-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}&location=${param.location}&propertyType=${param.propertyType}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&sort=${param.sort}"
                                   class="pagination-btn">Next →</a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Add Property Modal -->
<div class="modal" id="propertyModal" style="display:none;">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Add New Property</h2>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <div class="modal-body">
            <form id="propertyForm" action="${pageContext.request.contextPath}/adminproperties" method="post">
                <!-- Title -->
                <div class="form-group">
                    <label>Property Title</label>
                    <input type="text" name="title" class="form-input" placeholder="Enter property title" required>
                </div>

                <!-- Property Type & Status -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Property Type</label>
                        <select name="propertyType" class="form-select" required>
                            <option value="">Select Type</option>
                            <option value="Apartment">Apartment</option>
                            <option value="House">House</option>
                            <option value="Land">Land</option>
                            <option value="Commercial">Commercial</option>
                            <option value="Villa">Villa</option>
                            <option value="Restaurant">Restaurant</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select name="available" class="form-select">
                            <option value="true" selected>For Sale</option>
                            <option value="false">For Rent</option>
                        </select>
                    </div>
                </div>

                <!-- Price & Area -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Price (Rs.)</label>
                        <input type="number" name="price" class="form-input" step="1000" required>
                    </div>
                    <div class="form-group">
                        <label>Area (sq.ft)</label>
                        <input type="number" name="areaSqft" class="form-input" required>
                    </div>
                </div>

                <!-- Location -->
                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="location" class="form-input" placeholder="Enter location" required>
                </div>

                <!-- Storey, Bedrooms, Bathrooms -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Floors / Storeys</label>
                        <input type="number" name="storey" class="form-input" min="0" value="0" required>
                    </div>
                    <div class="form-group">
                        <label>Bedrooms</label>
                        <input type="number" name="bedrooms" class="form-input" min="0" value="0">
                    </div>
                    <div class="form-group">
                        <label>Bathrooms</label>
                        <input type="number" name="bathrooms" class="form-input" min="0" value="0">
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" class="form-textarea" rows="4" placeholder="Enter property description"></textarea>
                </div>

                <!-- Owner Info -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Owner Name</label>
                        <input type="text" name="ownerName" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label>Owner Contact</label>
                        <input type="text" name="ownerContact" class="form-input" required>
                    </div>
                </div>

                <!-- Year Built -->
                <div class="form-group">
                    <label>Year Built</label>
                    <input type="number" name="yearBuilt" class="form-input" min="1800" max="2025" value="2025">
                </div>

                <!-- Furnishing -->
                <div class="form-group">
                    <label>Furnishing</label>
                    <input type="text" name="furnishing" class="form-input" placeholder="e.g. Semi-furnished">
                </div>

                <!-- Coordinates -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Longitude</label>
                        <input type="number" name="longitude" class="form-input" step="any" placeholder="e.g. 85.3245">
                    </div>
                    <div class="form-group">
                        <label>Latitude</label>
                        <input type="number" name="latitude" class="form-input" step="any" placeholder="e.g. 27.7172">
                    </div>
                </div>

                <!-- Image URL -->
                <div class="form-group">
                    <label>Primary Image URL</label>
                    <input type="text" name="primaryImagePath" class="form-input" placeholder="Enter image URL">
                </div>

                <!-- Additional Features -->
                <div class="form-row">
                    <div class="form-group">
                        <label>Kitchen</label>
                        <input type="checkbox" name="kitchen" value="true">
                    </div>
                </div>

                <!-- Created At -->
                <div class="form-group">
                    <label>Created At</label>
                    <input type="text" name="createdAt" class="form-input" placeholder="Leave blank for auto-date">
                </div>

                <!-- Submit Buttons -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Property</button>
                </div>
            </form>
        </div>
    </div>
</div>

    <!-- JavaScript -->
    <script>
        // Open Modal
        function openModal() {
            document.getElementById("propertyModal").style.display = "block";
        }

        // Close Modal
        function closeModal() {
            document.getElementById("propertyModal").style.display = "none";
        }

        // Reset Filters
        function resetFilters() {
            window.location.href = "${pageContext.request.contextPath}/adminproperties";
        }
    </script>
</body>
</html>