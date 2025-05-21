<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User - Shangri-La Estates</title>
    <style>
        /* Reset & Base Styles */
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e0ecff, #f7f9fc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

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

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #333;
        }

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

        select.form-control {
            appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22 width%3D%2212%22 height%3D%2212%22 viewBox%3D%220 0 24 24%22 fill%3D%22none%22 stroke%3D%22%23666%22 stroke-width%3D%222%22%3E%3Cpolyline points%3D%226 9 12 15 18 9%22%3E%3C%2Fpolyline%3E%3C%2Fsvg%3E');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 12px;
            padding-right: 36px;
        }

        .badge {
            display: inline-block;
            padding: 4px 8px;
            font-size: 12px;
            border-radius: 4px;
            color: white;
            font-weight: bold;
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
    </style>
</head>
<body>

<div class="form-container">
    <h1>Edit User</h1>

    <form action="${pageContext.request.contextPath}/editUser" method="post">
        <input type="hidden" name="userId" value="${user.id}" />
        <input type="hidden" name="action" value="edit" />

        <!-- Full Name -->
        <div class="form-group">
            <label>User Name</label>
            <p><strong>${user.fullName}</strong></p>
        </div>

        <!-- Email -->
        <div class="form-group">
            <label>Email</label>
            <p>${user.email}</p>
        </div>

        <!-- Role -->
        <div class="form-group">
            <label>Role</label>
            <c:choose>
                <c:when test="${user.role == 'ADMIN'}">
                    <span class="badge badge-admin">Admin</span>
                </c:when>
                <c:when test="${user.role == 'CUSTOMER'}">
                    <span class="badge badge-user">Customer</span>
                </c:when>
            </c:choose>
        </div>

        <!-- Status -->
        <div class="form-group">
            <label for="status">Status</label>
            <select id="status" name="status" class="form-control" required>
                <option value="true" ${user.active ? 'selected' : ''}>Active</option>
                <option value="false" ${!user.active ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <!-- Action Buttons -->
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-outline">Back</a>
        </div>
    </form>
</div>

</body>
</html>