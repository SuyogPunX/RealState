<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Properties - Shangri-La Estates</title>
    <link rel="stylesheet" href="../css/properties.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png" alt="Sangri-La Estates" class="logo-icon" />
                    <span>Sangri-La Estates</span>
                </div>
            </div>
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="nav-link">
                        <span>📊</span> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/properties.jsp" class="nav-link active">
                        <span>🏠</span> Properties
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/users.jsp" class="nav-link">
                        <span>👥</span> Users
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="page-header">
                <div class="header-title">
                    <h1>Properties</h1>
                </div>
                <div class="header-actions">
                    <div class="user-profile">
                        <div class="user-avatar">A</div>
                    </div>
                </div>
            </div>
            
            <!-- Property Filters -->
            <div class="card filter-card">
                <div class="filter-header">
                    <h2>Property Filters</h2>
                </div>
                <div class="filter-body">
                    <div class="filter-row">
                        <div class="filter-item">
                            <label>Property Type</label>
                            <select class="form-select">
                                <option value="">All Types</option>
                                <option value="apartment">Apartment</option>
                                <option value="house">House</option>
                                <option value="land">Land</option>
                                <option value="commercial">Commercial</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label>Location</label>
                            <select class="form-select">
                                <option value="">All Locations</option>
                                <option value="kathmandu">Kathmandu</option>
                                <option value="lalitpur">Lalitpur</option>
                                <option value="bhaktapur">Bhaktapur</option>
                                <option value="pokhara">Pokhara</option>
                                <option value="biratnagar">Biratnagar</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label>Price Range</label>
                            <div class="price-range">
                                <input type="number" placeholder="Min" class="form-input">
                                <span>-</span>
                                <input type="number" placeholder="Max" class="form-input">
                            </div>
                        </div>
                        <div class="filter-item">
                            <label>Status</label>
                            <select class="form-select">
                                <option value="">All Status</option>
                                <option value="sale">For Sale</option>
                                <option value="rent">For Rent</option>
                                <option value="pending">Pending</option>
                                <option value="active">Active</option>
                            </select>
                        </div>
                    </div>
                    <div class="filter-actions">
                        <button class="btn btn-outline">Reset</button>
                        <button class="btn btn-primary">Apply Filters</button>
                    </div>
                </div>
            </div>
            
            <!-- Property List -->
            <div class="table-container">
                <div class="table-header">
                    <div class="table-title">All Properties</div>
                    <div class="table-actions">
                        <div class="search-box">
                            <span>🔍</span>
                            <input type="text" placeholder="Search properties...">
                        </div>
                        <button class="btn btn-primary" id="addPropertyBtn">+ Add Property</button>
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
                            <th>Featured</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Luxury Apartment">
                                    </div>
                                    <div>Luxury Apartment in Kathmandu</div>
                                </div>
                            </td>
                            <td>Apartment</td>
                            <td>Baluwatar, Kathmandu</td>
                            <td>Rs. 55,000,000</td>
                            <td><span class="badge badge-sale">For Sale</span></td>
                            <td>10 Feb 2025</td>
                            <td><span class="badge badge-featured">Featured</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="City Apartment">
                                    </div>
                                    <div>City Apartment</div>
                                </div>
                            </td>
                            <td>Apartment</td>
                            <td>Thamel, Kathmandu</td>
                            <td>Rs. 125,000/month</td>
                            <td><span class="badge badge-rent">For Rent</span></td>
                            <td>15 Mar 2025</td>
                            <td><span class="badge">-</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Commercial Land">
                                    </div>
                                    <div>Commercial Land</div>
                                </div>
                            </td>
                            <td>Land</td>
                            <td>Biratnagar</td>
                            <td>Rs. 35,000,000</td>
                            <td><span class="badge badge-pending">Pending</span></td>
                            <td>28 Feb 2025</td>
                            <td><span class="badge">-</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Modern House">
                                    </div>
                                    <div>Modern House in Lalitpur</div>
                                </div>
                            </td>
                            <td>House</td>
                            <td>Lalitpur</td>
                            <td>Rs. 42,800,000</td>
                            <td><span class="badge badge-active">Active</span></td>
                            <td>03 Mar 2025</td>
                            <td><span class="badge badge-featured">Featured</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Lakeside Restaurant">
                                    </div>
                                    <div>Lakeside Restaurant</div>
                                </div>
                            </td>
                            <td>Restaurant</td>
                            <td>Lakeside, Pokhara</td>
                            <td>Rs. 18,500,000</td>
                            <td><span class="badge badge-sale">For Sale</span></td>
                            <td>21 Mar 2025</td>
                            <td><span class="badge">-</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Mountain View Villa">
                                    </div>
                                    <div>Mountain View Villa</div>
                                </div>
                            </td>
                            <td>Villa</td>
                            <td>Budhanilkantha, Kathmandu</td>
                            <td>Rs. 78,500,000</td>
                            <td><span class="badge badge-sale">For Sale</span></td>
                            <td>18 Jan 2025</td>
                            <td><span class="badge badge-featured">Featured</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="property-item">
                                    <div class="property-image">
                                        <img src="/api/placeholder/60/40" alt="Office Space">
                                    </div>
                                    <div>Prime Office Space</div>
                                </div>
                            </td>
                            <td>Commercial</td>
                            <td>Durbar Marg, Kathmandu</td>
                            <td>Rs. 250,000/month</td>
                            <td><span class="badge badge-rent">For Rent</span></td>
                            <td>05 Mar 2025</td>
                            <td><span class="badge">-</span></td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-icon view-btn" title="View Details">👁️</button>
                                    <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                    <button class="btn-icon delete-btn" title="Delete">🗑️</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                

                    <!-- Standardized Pagination -->
            <div class="pagination">
                <div class="pagination-info">
                    Showing <span id="showing-start">1</span> to <span id="showing-end">5</span> of <span id="total-items">25</span> properties
                </div>
                    <div class="pagination-buttons" id="pagination">
                        <!-- Pagination buttons will be populated by JavaScript -->
                        <button class="pagination-btn" id="prev-btn" disabled><i class="fas fa-chevron-left"></i></button>
                        <div class="pagination-numbers">
                            <button class="pagination-btn active">1</button>
                            <button class="pagination-btn">2</button>
                            <button class="pagination-btn">3</button>
                            <!-- More buttons will be dynamically added by JavaScript -->
                        </div>
                        <button class="pagination-btn" id="next-btn"><i class="fas fa-chevron-right"></i></button>
                    </div>
                </div>
            </div>

            <!-- Add Property Modal -->
            <div class="modal" id="propertyModal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>Add New Property</h2>
                        <button class="close-btn">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form id="propertyForm">
                            <div class="form-group">
                                <label>Property Title</label>
                                <input type="text" class="form-input" placeholder="Enter property title">
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Property Type</label>
                                    <select class="form-select">
                                        <option value="">Select Type</option>
                                        <option value="apartment">Apartment</option>
                                        <option value="house">House</option>
                                        <option value="land">Land</option>
                                        <option value="commercial">Commercial</option>
                                        <option value="villa">Villa</option>
                                        <option value="restaurant">Restaurant</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select class="form-select">
                                        <option value="">Select Status</option>
                                        <option value="sale">For Sale</option>
                                        <option value="rent">For Rent</option>
                                        <option value="pending">Pending</option>
                                        <option value="active">Active</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Price (Rs.)</label>
                                    <input type="number" class="form-input" placeholder="Enter price">
                                </div>
                                <div class="form-group">
                                    <label>Rental (if applicable)</label>
                                    <div class="rental-group">
                                        <input type="number" class="form-input" placeholder="Enter rental amount">
                                        <select class="form-select">
                                            <option value="month">/month</option>
                                            <option value="year">/year</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Location</label>
                                    <input type="text" class="form-input" placeholder="Enter location">
                                </div>
                                <div class="form-group">
                                    <label>City</label>
                                    <select class="form-select">
                                        <option value="">Select City</option>
                                        <option value="kathmandu">Kathmandu</option>
                                        <option value="lalitpur">Lalitpur</option>
                                        <option value="bhaktapur">Bhaktapur</option>
                                        <option value="pokhara">Pokhara</option>
                                        <option value="biratnagar">Biratnagar</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Bedrooms</label>
                                    <input type="number" class="form-input" placeholder="No. of bedrooms">
                                </div>
                                <div class="form-group">
                                    <label>Bathrooms</label>
                                    <input type="number" class="form-input" placeholder="No. of bathrooms">
                                </div>
                                <div class="form-group">
                                    <label>Area (sq.ft)</label>
                                    <input type="number" class="form-input" placeholder="Area in square feet">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <textarea class="form-textarea" rows="4" placeholder="Enter property description"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Upload Images</label>
                                <div class="file-upload">
                                    <input type="file" id="propertyImages" multiple>
                                    <label for="propertyImages">Choose Files</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="checkbox-group">
                                    <input type="checkbox" id="featured">
                                    <label for="featured">Mark as Featured</label>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-outline">Cancel</button>
                        <button class="btn btn-primary">Save Property</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/properties.js"></script>
</body>
</html>