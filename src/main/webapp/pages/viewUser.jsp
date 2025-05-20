<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Details - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="main-content">
    <div class="page-header">
        <h1>User Details</h1>
        <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-outline">Back</a>
    </div>

   <div class="card user-details-card">
    <table class="details-table">
        <tr>
            <th>ID</th>
            <td>${user.id}</td>
        </tr>
        <tr>
            <th>Name</th>
            <td>${user.fullName}</td>
        </tr>
        <tr>
            <th>Email</th>
            <td>${user.email}</td>
        </tr>
        <tr>
            <th>Phone</th>
            <td>${user.phone}</td>
        </tr>
        <tr>
            <th>Status</th>
            <td>
                <c:choose>
                    <c:when test="${user.active}">
                        <span class="badge badge-active">Active</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-inactive">Inactive</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>Role</th>
            <td>
                <c:choose>
                    <c:when test="${user.role == 'ADMIN'}">
                        <span class="badge badge-admin">Admin</span>
                    </c:when>
                    <c:when test="${user.role == 'CUSTOMER'}">
                        <span class="badge badge-user">Customer</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge">${user.role}</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>Joined Date</th>
            <td>${user.createdAt}</td>
        </tr>
    </table>
</div>
</div>
</body>
</html>