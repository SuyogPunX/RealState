<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Property Details - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="container">

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-header">
            <h1>Property Details</h1>
            <a href="${pageContext.request.contextPath}/admin?action=properties" class="btn btn-outline">Back</a>
        </div>

        <div class="card property-details">
            <table class="details-table">
                <tr><th>Title</th><td>${property.title}</td></tr>
                <tr><th>Type</th><td>${property.propertyType}</td></tr>
                <tr><th>Location</th><td>${property.location}</td></tr>
                <tr><th>Price</th><td>₨ ${property.price}</td></tr>
                <tr><th>Status</th><td>
                    <c:choose>
                        <c:when test="${property.available}"><span class="badge badge-sale">For Sale</span></c:when>
                        <c:otherwise><span class="badge badge-sold">Sold</span></c:otherwise>
                    </c:choose>
                </td></tr>
                <tr><th>Area (sq.ft)</th><td>${property.areaSqft}</td></tr>
                <tr><th>Storey</th><td>${property.storey}</td></tr>
                <tr><th>Bedrooms</th><td>${property.bedrooms}</td></tr>
                <tr><th>Bathrooms</th><td>${property.bathrooms}</td></tr>
                <tr><th>Kitchen</th><td>${property.kitchen ? '✔' : '✘'}</td></tr>
                <tr><th>Description</th><td>${property.description}</td></tr>
                <tr><th>Owner Name</th><td>${property.ownerName}</td></tr>
                <tr><th>Owner Contact</th><td>${property.ownerContact}</td></tr>
                <tr><th>Year Built</th><td>${property.yearBuilt}</td></tr>
                <tr><th>Furnishing</th><td>${property.furnishing}</td></tr>
                <tr><th>Added On</th><td>${property.createdAt}</td></tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>