<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inquiries / Bookings</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        .main-content {
            max-width: 1200px;
            margin: auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .status-pill {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 13px;
        }

        .status-pending { background-color: #ffc107; color: #333; }
        .status-confirmed { background-color: #28a745; color: white; }
        .status-cancelled { background-color: #dc3545; color: white; }

        .actions {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
        }

        .btn-edit { background-color: #007bff; color: white; }
        .btn-delete { background-color: #dc3545; color: white; }
    </style>
</head>
<body>

<div class="main-content">
    <div class="page-header">
        <h1>Inquiries </h1>
    </div>

    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Property ID</th>
                <th>Customer ID</th>
                <th>Booking Time</th>
                <th>Meeting Location</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${bookings}" var="booking" varStatus="loop">
                <tr>
                    <td>${booking.id}</td>
                    <td>${booking.propertyId}</td>
                    <td>${booking.userId}</td>
                    <td>${booking.bookingTime}</td>
                    <td>${booking.meetingLocation} </td>
              
                    <td>
                        <span class="status-pill 
                            <c:if test="${booking.status == 'PENDING'}">status-pending</c:if>
                            <c:if test="${booking.status == 'CONFIRMED'}">status-confirmed</c:if>
                            <c:if test="${booking.status == 'CANCELLED'}">status-cancelled</c:if>
                        ">
                            ${booking.status}
                        </span>
                    </td>
                    <td>
                        <div class="actions">
                            <form action="${pageContext.request.contextPath}/admin?action=updateBookingStatus" method="post">
                                <input type="hidden" name="bookingId" value="${booking.id}">
                                <input type="hidden" name="status" value="CONFIRMED">
                                <button type="submit" class="btn btn-edit">Confirm</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin?action=updateBookingStatus" method="post">
                                <input type="hidden" name="bookingId" value="${booking.id}">
                                <input type="hidden" name="status" value="CANCELLED">
                                <button type="submit" class="btn btn-delete">Cancel</button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>