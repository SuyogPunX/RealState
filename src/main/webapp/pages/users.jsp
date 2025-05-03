<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shangri-La Estates - Users Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/users.css">
    <link rel="stylesheet" href="../css/admin.css">
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
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="nav-link">
                        <span>📊</span> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/properties.jsp" class="nav-link ">
                        <span>🏠</span> Properties
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/pages/users.jsp" class="nav-link active">
                        <span>👥</span> Users
                    </a>
                </li>
            </ul>
                <!-- <li class="nav-item">
                    <a href="../pages/inquaries.html" class="nav-link ">
                        <span>📝</span> Inquiries
                    </a>
                </li>
                <li class="nav-item">
                    <a href="../pages/transaction.html" class="nav-link">
                        <span>💰</span> Transactions
                    </a>
                </li>
                <li class="nav-item">
                    <a href="../pages/report.html" class="nav-link">
                        <span>📈</span> Reports
                    </a>
                </li> -->
            
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="page-header">
                <div class="header-title">
                    <h1>Users Management</h1>
                </div>
                <div class="header-actions">
                    <div class="user-profile">
                        <div class="user-avatar">A</div>
                    </div>
                </div>
            </div>

            <!-- Users Overview Cards -->
            <div class="dashboard-cards">
                <div class="card status-card">
                    <div class="status-card-icon icon-users">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="status-card-title">Total Users</div>
                    <div class="status-card-value" id="total-users-count">0</div>
                    <div class="status-card-change change-positive" id="users-growth">+0% from last month</div>
                </div>
                <div class="card status-card">
                    <div class="status-card-icon icon-users" style="background-color: rgba(52, 152, 219, 0.1); color: #3498db;">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="status-card-title">New Users</div>
                    <div class="status-card-value" id="new-users-count">0</div>
                    <div class="status-card-change change-positive" id="new-users-growth">+0% from last month</div>
                </div>
                <div class="card status-card">
                    <div class="status-card-icon icon-sales">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="status-card-title">Active Users</div>
                    <div class="status-card-value" id="active-users-count">0</div>
                    <div class="status-card-change change-positive" id="active-users-growth">+0% from last month</div>
                </div>
                <div class="card status-card">
                    <div class="status-card-icon icon-inquiries" style="background-color: rgba(231, 76, 60, 0.1); color: #e74c3c;">
                        <i class="fas fa-user-slash"></i>
                    </div>
                    <div class="status-card-title">Inactive Users</div>
                    <div class="status-card-value" id="inactive-users-count">0</div>
                    <div class="status-card-change" id="inactive-users-growth">+0% from last month</div>
                </div>
            </div>

            <!-- Users Table Section -->
            <div class="table-container">
                <div class="table-header">
                    <h3 class="table-title">User Management</h3>
                    <div class="table-actions">
                        <div class="search-box">
                            <i class="fas fa-search"></i>
                            <input type="text" id="search-users" placeholder="Search users...">
                        </div>
                        <button id="add-user-btn" class="btn btn-primary">
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
                        <!-- User data will be populated here by JavaScript -->
                    </tbody>
                </table>
                
                <!-- Standardized Pagination -->
                <div class="pagination">
                    <div class="pagination-info">
                        Showing <span id="showing-start">0</span> to <span id="showing-end">0</span> of <span id="total-items">0</span> users
                    </div>
                    <div class="pagination-buttons" id="pagination">
                        <!-- Pagination will be populated by JavaScript -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Add/Edit User -->
    <div id="user-modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modal-title">Add New User</h2>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <form id="user-form">
                    <input type="hidden" id="user-id">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                            <option value="Pending">Pending</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="button" id="cancel-btn" class="btn btn-outline">Cancel</button>
                        <button type="submit" id="save-user-btn" class="btn btn-primary">Save User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirm-modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Confirm Deletion</h2>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this user? This action cannot be undone.</p>
                <div class="form-actions">
                    <button type="button" id="cancel-delete-btn" class="btn btn-outline">Cancel</button>
                    <button type="button" id="confirm-delete-btn" class="btn btn-primary" style="background-color: #f53689;">Delete</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/pages/users.jsp"></script>
</body>
</html>

  