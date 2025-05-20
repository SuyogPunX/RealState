<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Property Status - Shangri-La Estates</title>

    <!-- Inline CSS -->
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

        .sidebar .logo-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .sidebar .logo-icon {
            width: 30px;
            height: 30px;
            margin-right: 10px;
        }

        .sidebar .nav-link {
            display: block;
            padding: 10px 15px;
            margin-bottom: 10px;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
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

        .form-group input[type="checkbox"] {
            transform: scale(1.2);
            margin-right: 10px;
        }

        .form-group p {
            margin: 5px 0;
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
            margin-left: 10px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .modal-footer {
            margin-top: 20px;
        }
    </style>
</head>
<body>


   <form action="${pageContext.request.contextPath}/adminproperties?action=edit" method="post">
    <input type="hidden" name="propertyId" value="${property.propertyId}" />

    <!-- Editable Fields -->
    <input type="text" name="title" value="${property.title}" required>

    <select name="available">
        <option value="true" ${property.available ? 'selected' : ''}>For Sale</option>
        <option value="false" ${!property.available ? 'selected' : ''}>Sold</option>
    </select>

    <button type="submit">Save Changes</button>
</form>
</body>
</html>