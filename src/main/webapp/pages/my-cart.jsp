<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart - Shangri-La Estates</title>
    <style>
        /* Base Styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f1f4f9;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            padding: 30px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            margin-top: 40px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: #2c3e50;
            text-align: center;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #7f8c8d;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .back-btn:hover {
            background-color: #63797f;
        }

        .empty-cart {
            text-align: center;
            padding: 40px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .empty-cart p {
            font-style: italic;
            color: #888;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-top: 20px;
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            color: #555;
            font-weight: bold;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            color: white;
        }

        .badge-pending { background-color: #ffc107; color: #333; }
        .badge-confirmed { background-color: #28a745; }
        .badge-cancelled { background-color: #dc3545; }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-icon {
            background: none;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }

        .edit-btn {
            color: #28a745;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            position: relative;
        }

        .close-btn {
            position: absolute;
            right: 10px;
            top: 5px;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .close-btn:hover {
            color: #000;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
            }

            .page-title {
                font-size: 20px;
            }

            .btn, .back-btn {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Back Button -->
    <a href="${pageContext.request.contextPath}/pages/buy.jsp" class="back-btn">← Go Back</a>

    <!-- Page Title -->
    <h2 class="page-title">My Cart</h2>

    <!-- Empty Cart Message -->
    <c:if test="${empty cartItems}">
        <div class="empty-cart">
            <p>Your cart is empty.</p>
            <a href="${pageContext.request.contextPath}/pages/buy.jsp" class="btn">Browse Properties</a>
        </div>
    </c:if>

    <!-- Cart Items Table -->
    <c:if test="${not empty cartItems}">
        <table>
            <thead>
                <tr>
                    <th>Property ID</th>
                    <th>Meeting Time</th>
                    <th>Meeting Location</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td>${item.propertyId}</td>
                        <td><fmt:formatDate value="${item.bookingTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>${item.meetingLocation}</td>
                        <td>
                            <span class="badge 
                                <c:choose>
                                    <c:when test='${item.status == "PENDING"}'>badge-pending</c:when>
                                    <c:when test='${item.status == "CONFIRMED"}'>badge-confirmed</c:when>
                                    <c:when test='${item.status == "CANCELLED"}'>badge-cancelled</c:when>
                                </c:choose>
                            ">${item.status}</span>
                        </td>
                        <td>
                            <button class="btn-icon edit-btn" onclick="openModal(${item.id}, '${item.status}')">✏️</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<!-- Status Change Modal -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h3>Update Cart Item</h3>
        <form id="statusForm" method="post" action="${pageContext.request.contextPath}/updateCartItemStatus">
            <input type="hidden" id="bookingId" name="id">
            <div>
                <label for="newStatus">Select New Status:</label>
                <select id="newStatus" name="status" required style="width: 100%; padding: 8px;">
                    <option value="PENDING">Pending</option>
                    <option value="CONFIRMED">Confirmed</option>
                    <option value="CANCELLED">Cancelled</option>
                </select>
            </div>
            <br>
            <button type="submit" class="btn-primary">Save Changes</button>
        </form>
    </div>
</div>

<script>
function openModal(id, currentStatus) {
    document.getElementById("bookingId").value = id;
    document.getElementById("newStatus").value = currentStatus;
    document.getElementById("statusModal").style.display = "block";
}

function closeModal() {
    document.getElementById("statusModal").style.display = "none";
}

window.onclick = function(event) {
    const modal = document.getElementById("statusModal");
    if (event.target === modal) closeModal();
}
</script>

</body>
</html>