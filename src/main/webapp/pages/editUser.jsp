<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User - Shangri-La Estates</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: #f4f6f8;
            color: #333;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }

        .logo-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .logo-icon {
            width: 30px;
            height: 30px;
            margin-right: 10px;
        }

        .nav-link {
            display: block;
            padding: 10px 15px;
            margin-bottom: 10px;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
        }

        .nav-link:hover,
        .nav-link.active {
            background-color: #e9ecef;
        }

        /* Main Content */
        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #fff;
        }

        .page-header {
            margin-bottom: 20px;
        }

        .page-header h1 {
            font-size: 24px;
            margin: 0;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-outline {
            background-color: transparent;
            color: #3498db;
            border: 1px solid #3498db;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .modal-footer {
            margin-top: 20px;
        }

        .badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            color: white;
        }

        .badge-admin {
            background-color: #e67e22;
        }

        .badge-user {
            background-color: #2ecc71;
        }

        .badge-agent {
            background-color: #3498db;
        }

        .form-actions {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>

<!-- Main Content -->
<div class="main-content">
    <div class="page-header">
        <h1>Edit User</h1>
    </div>

    <div class="card user-edit-card">
        <form action="${pageContext.request.contextPath}/editUser" method="post">
            <input type="hidden" name="userId" value="${user.id}" />
            <input type="hidden" name="action" value="edit" />

            <!-- Property Title -->
            <div class="form-group">
                <label>User Name</label>
                <p><strong>${user.fullName}</strong></p>
            </div>

            <!-- Current Role -->
            <div class="form-group">
                <label>Current Role</label>
                <p>
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}">
                            <span class="badge badge-admin">Admin</span>
                        </c:when>
                        <c:when test="${user.role == 'CUSTOMER'}">
                            <span class="badge badge-agent">Customer</span>
                        </c:when>
                    </c:choose>
                </p>
            </div>

            <!-- New Status -->
            <div class="form-group">
                <label for="status">New Status</label>
                <select name="status" id="status" class="form-select" required>
                    <option value="true" ${user.active ? 'selected' : ''}>Active</option>
                    <option value="false" ${!user.active ? 'selected' : ''}>Inactive</option>
                </select>
            </div>

            <!-- Action Buttons -->
            <div class="modal-footer form-actions">
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Changes</button>
                <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>