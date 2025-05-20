<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Sangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            
           <a href="${pageContext.request.contextPath}/admin" class="nav-link">Dashboard</a>
			<a href="${pageContext.request.contextPath}/admin?action=properties" class="nav-link">Properties</a>
			<a href="${pageContext.request.contextPath}/admin?action=users" class="nav-link">Users</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
        
            <!-- Header -->
            
            <div class="page-header">
                <div class="header-title">
                    <h1>Dashboard</h1>
                </div>
                <a href="${pageContext.request.contextPath}/admin?action=signout" class="btn-signout">
    <i class="fas fa-sign-out-alt"></i> Sign Out
</a>

            </div>
            
            <!-- Dashboard Cards -->
            <div class="dashboard-cards">
                <div class="card status-card">
                    <div class="status-card-icon icon-properties">🏠</div>
                    <div class="status-card-title">Total Properties</div>
                    <div class="status-card-value">${stats.totalProperties}</div>
                    <div class="status-card-change change-positive">+12% from last month</div>
                </div>
                
                <div class="card status-card">
                    <div class="status-card-icon icon-users">👥</div>
                    <div class="status-card-title">Total Users</div>
                    <div class="status-card-value">${stats.totalUsers}</div>
                    <div class="status-card-change change-positive">+8% from last month</div>
                </div>
                
                <div class="card status-card">
                    <div class="status-card-icon icon-sales">💰</div>
                    <div class="status-card-title">Sales Revenue</div>
                    <div class="status-card-value">Rs. ${stats.salesRevenue}</div>
                    <div class="status-card-change change-positive">+15% from last month</div>
                </div>
                
				<a href="${pageContext.request.contextPath}/admin?action=inquiries" class="status-card-link">
				    <div class="card status-card">
				        <div class="status-card-icon icon-inquiries">📝</div>
				        <div class="status-card-title">New Inquiries</div>
				        <div class="status-card-value">${stats.newInquiries}</div>
				        <div class="status-card-change change-positive">+5% from last month</div>
				    </div>
				</a>
            </div>
            
            <!-- Properties Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3 class="table-title">Recent Properties</h3>
                    <div class="table-actions">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search properties...">
                        </div>
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
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="property" items="${recentProperties}">
                            <tr>
                                <td>
                                    <div class="property-item">
                                        <div class="property-image">
                                            <img src="/api/placeholder/60/40" alt="${property.title}">
                                        </div>
                                        <div>${property.title}</div>
                                    </div>
                                </td>
                                <td>${property.storey == 1 ? 'House' : 'Apartment'}</td>
                                <td>${property.location}</td>
                                <td>Rs. ${property.price}</td>
                                <td><span class="badge badge-sale">${property.available ? 'For Sale' : 'For Rent'}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
