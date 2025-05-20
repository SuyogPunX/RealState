<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css " />
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png " alt="Sangri-La Estates" class="logo-icon" />
                    <span>Sangri-La Estates</span>
                </div>
            </div>
            
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin?action=properties" class="nav-link">Properties</a>
            <a href="${pageContext.request.contextPath}/admin?action=users" class="nav-link active">Users</a>
        </div>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Header -->
            <div class="page-header">
                <h1>Users Management</h1>
            </div>

            <!-- User Statistics Cards -->
            <div class="dashboard-cards">
                <div class="card status-card">
                    <div class="status-card-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="status-card-title">Total Users</div>
                    <div class="status-card-value">${totalUsers}</div>
                    <div class="status-card-change change-positive">
                        +<fmt:formatNumber value="${newUserGrowthPercentage}" pattern="0.0"/>% from last month
                    </div>
                </div>

                <div class="card status-card" style="background-color: rgba(52, 152, 219, 0.1); color: #3498db;">
                    <div class="status-card-icon icon-user-plus">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="status-card-title">New Users</div>
                    <div class="status-card-value">${newUsers}</div>
                    <div class="status-card-change change-positive">
                        +<fmt:formatNumber value="${newUserGrowthPercentage}" pattern="0.0"/>% from last month
                    </div>
                </div>

                <div class="card status-card">
                    <div class="status-card-icon icon-user-check">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="status-card-title">Active Users</div>
                    <div class="status-card-value">${activeUsers}</div>
                    <div class="status-card-change change-positive">
					    <c:if test="${inactiveUsers > 0}">
					        <fmt:formatNumber value="${activeUserPercentage}" pattern="0.0"/>%
					        since last month
					    </c:if>
					</div>
                </div>

                <div class="card status-card" style="background-color: rgba(231, 76, 60, 0.1); color: #e74c3c;">
                    <div class="status-card-icon icon-user-slash">
                        <i class="fas fa-user-slash"></i>
                    </div>
                    <div class="status-card-title">Inactive Users</div>
                    <div class="status-card-value">${inactiveUsers}</div>
                    <div class="status-card-change">
					    <c:if test="${activeUsers > 0}">
					        <fmt:formatNumber value="${inactiveUserPercentage}" pattern="0.0"/>%
					        since last month
					    </c:if>
					</div>
                </div>
            </div>

            <!-- Users Table Section -->
            <div class="table-container">
                <div class="table-header">
                    <h3 class="table-title">User Management</h3>
                    <div class="table-actions">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" id="search-users" placeholder="Search users..." onkeyup="filterTable(this.value)">
                        </div>
                        <button id="add-user-btn" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/user?action=add'">
                            <i class="fas fa-plus"></i> Add User
                        </button>
                    </div>
                </div>
                
                <table id="users-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>
                            <th>Joined Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="users-table-body">
                        <c:if test="${not empty users}">
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.fullName}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phone}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.active == 'Active'}">
                                                <span class="badge badge-active">${user.active}</span>
                                            </c:when>
                                            <c:when test="${user.active == 'Inactive'}">
                                                <span class="badge badge-inactive">${user.active}</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>${user.createdAt}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/viewUser?id=${user.id}">
                                                <button class="btn-icon view-btn" title="View Details">👁️</button>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/editUser?id=${user.id}">
                                                <button class="btn-icon edit-btn" title="Edit">✏️</button>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty users}">
                            <tr><td colspan="7" class="text-center">No users found.</td></tr>
                        </c:if>
                    </tbody>
                </table>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <div class="pagination-info">
                            Showing ${startItem} to ${endItem} of ${totalUsers}
                        </div>
                        <div class="pagination-buttons">
                            <c:if test="${currentPage > 1}">
                                <a href="?page=${currentPage - 1}&sort=${param.sort}"
                                   class="pagination-btn">&#8592; Prev</a>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}&sort=${param.sort}"
                                   class="pagination-btn ${currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <a href="?page=${currentPage + 1}&sort=${param.sort}"
                                   class="pagination-btn">Next →</a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Optional JS -->
    <script>
        function filterTable(value) {
            const rows = document.querySelectorAll("#users-table tbody tr");
            const search = value.toLowerCase();

            rows.forEach(row => {
                const name = row.cells[1].textContent.toLowerCase();
                const email = row.cells[2].textContent.toLowerCase();
                const phone = row.cells[3].textContent.toLowerCase();
                const status = row.cells[4].textContent.toLowerCase();

                if (name.includes(search) || email.includes(search) || phone.includes(search) || status.includes(search)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</body>
</html>