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
	<style>
	    .header-actions {
	    display: flex;
	    align-items: center;
	    gap: 15px;
	}
	
	.profile-dropdown {
	    position: relative;
	    display: inline-block;
	}
	
	.profile-icon {
	    font-size: 24px;
	    cursor: pointer;
	    border-radius: 50%;
	    background-color: #f0f0f0;
	    width: 40px;
	    height: 40px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	}
	
	.profile-dropdown-content {
	    display: none;
	    position: absolute;
	    right: 0;
	    top: 50px;
	    background-color: #fff;
	    min-width: 250px;
	    box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
	    z-index: 1000;
	    border-radius: 5px;
	    padding: 15px;
	}
	
	.profile-dropdown-content.show {
	    display: block;
	}
	
	.profile-header {
	    border-bottom: 1px solid #eee;
	    padding-bottom: 10px;
	    margin-bottom: 10px;
	    font-weight: bold;
	}
	
	.profile-detail {
	    display: flex;
	    align-items: center;
	    margin: 8px 0;
	}
	
	.detail-icon {
	    margin-right: 10px;
	    color: #666;
	    width: 16px;
	    text-align: center;
	}
	
	.signout-btn {
	    margin-top: 15px;
	    width: 100%;
	    padding: 8px;
	    background-color: #f44336;
	    color: white;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.signout-btn:hover {
	    background-color: #d32f2f;
	}
	</style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <img src="${pageContext.request.contextPath}/pictures/logo.png" alt="Sangri-La Estates" class="logo-icon" />
                    <span>Sangri-La Estates</span>
                </div>
            </div>
            
           <a href="${pageContext.request.contextPath}/admin" class="nav-link active" >Dashboard</a>
			<a href="${pageContext.request.contextPath}/admin?action=properties" class="nav-link">Properties</a>
			<a href="${pageContext.request.contextPath}/admin?action=users" class="nav-link">Users</a>
			<a href="${pageContext.request.contextPath}/admin?action=inquiries" class="nav-link">Inquaries</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">
        
            <!-- Header -->
            
            <div class="page-header">
                <div class="header-title">
                    <h1>Dashboard</h1>
                </div>
                <div class="page-header">
			    <!-- Profile Dropdown -->
			    <div class="header-actions">
			        <div class="profile-dropdown">
			            <div class="profile-icon" onclick="toggleProfileDropdown()">👤</div>
			
			            <div class="profile-dropdown-content" id="profileDropdown">
			                <c:choose>
			                    <c:when test="${not empty user}">
			                        <div class="profile-header">User Profile</div>
			                        <div class="profile-detail">
			                            <div class="detail-icon">👤</div>
			                            <div>${user.fullName}</div>
			                        </div>
			                        <div class="profile-detail">
			                            <div class="detail-icon">✉️</div>
			                            <div>${user.email}</div>
			                        </div>
			                        <div class="profile-detail">
			                            <div class="detail-icon">📞</div>
			                            <div>${user.phone}</div>
			                        </div>
			                        <div class="profile-detail">
			                            <div class="detail-icon">🏠</div>
			                            <div>${user.address}</div>
			                        </div>
			                        <a href="${pageContext.request.contextPath}/admin?action=signout">
			                            <button class="signout-btn">Sign Out</button>
			                        </a>
			                    </c:when>
			                </c:choose>
			            </div>
			        </div>
			    </div>
			</div>				
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
    
    
		    <script>
		function toggleProfileDropdown() {
		    document.getElementById("profileDropdown").classList.toggle("show");
		}
		
		// Close dropdown if clicked outside
		window.onclick = function(event) {
		    if (!event.target.matches('.profile-icon')) {
		        var dropdowns = document.getElementsByClassName("profile-dropdown-content");
		        for (var i = 0; i < dropdowns.length; i++) {
		            var openDropdown = dropdowns[i];
		            if (openDropdown.classList.contains('show')) {
		                openDropdown.classList.remove('show');
		            }
		        }
		    }
		}
		</script>

    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>
