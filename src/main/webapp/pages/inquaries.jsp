<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inquiries Management - Shangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css " />
    <style>
        .dashboard-cards {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .card {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            flex: 1;
            min-width: 200px;
        }

        .status-card-icon {
            font-size: 24px;
            color: white;
            background-color: #3498db;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .status-card-title {
            font-size: 14px;
            color: #777;
            text-transform: uppercase;
        }

        .status-card-value {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }

        .status-card-change {
            font-size: 12px;
            margin-top: 5px;
        }

        .change-positive {
            color: #28a745;
        }

        .table-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .table-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .search-box {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px 10px;
            width: 250px;
        }

        .search-box i {
            color: #aaa;
            margin-right: 8px;
        }

        .search-box input {
            border: none;
            outline: none;
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            color: #555;
            font-weight: bold;
        }

        .badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .badge-pending {
            background-color: #ffc107;
            color: #333;
        }

        .badge-processed {
            background-color: #28a745;
            color: #fff;
        }

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

        .view-btn { color: #007bff; }
        .edit-btn { color: #28a745; }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 10px;
            flex-wrap: wrap;
        }

        .pagination a {
            padding: 8px 14px;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
            transition: background 0.3s ease;
        }

        .pagination a:hover,
        .pagination .active {
            background-color: #007bff;
            color: white;
        }
        
		        .badge {
		    padding: 5px 10px;
		    border-radius: 20px;
		    font-size: 12px;
		    font-weight: bold;
		    text-transform: uppercase;
		    color: white;
		}
		
		.badge-pending {
		    background-color: #ffc107;
		    color: #333;
		}
		
		.badge-confirmed {
		    background-color: #28a745;
		}
		
		.badge-cancelled {
		    background-color: #dc3545;
		}
		
		.btn-icon {
		    background: none;
		    border: none;
		    font-size: 16px;
		    cursor: pointer;
		}
		
		.view-btn { color: #007bff; }
		.edit-btn { color: #28a745; }
		
		.text-center {
		    text-align: center;
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
		        margin: 10% auto;
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
    </style>

</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo-container">
                    <img src="${pageContext.request.contextPath}/pictures/logo.png"" alt="Sangri-La Estates" class="logo-icon" />
                    <span>Sangri-La Estates</span>
                </div>
            </div>
            
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin?action=properties" class="nav-link">Properties</a>
             <a href="${pageContext.request.contextPath}/admin?action=users" class="nav-link ">Users</a>
            <a href="${pageContext.request.contextPath}/admin?action=inquiries" class="nav-link active">Inquiries</a>
            
        </div>

        <!-- Main Content -->
        <div class="main-content">

            <!-- Header -->
            <div class="page-header">
                <h1>Inquiries </h1>
            </div>

          
            <!-- Inquiries Table Section -->
            <div class="table-container">
                <div class="table-header">
                    <h3 class="table-title">Inquiry Management</h3>
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="search-inquiries" placeholder="Search inquiries..." onkeyup="filterTable(this.value)">
                    </div>
                </div>
                
        <table id="bookings-table">
			    <thead>
			        <tr>
			            <th>Booking ID</th>
			            <th>Property ID</th>
			            <th>User ID</th>
			            <th>Booking Time</th>
			            <th>Meeting Location</th>
			            <th>Status</th>
			            <th>Actions</th>
			        </tr>
			    </thead>
    
	    <tbody id="bookings-table-body">
	        <c:if test="${empty inquiries}">
	            <tr>
	                <td colspan="7" class="text-center">No bookings found.</td>
	            </tr>
	        </c:if>
	
	        <c:forEach var="booking" items="${inquiries}" varStatus="loop">
	            <tr>
	                <td>${booking.id}</td>
	                <td>${booking.propertyId}</td>
	                <td>${booking.userId}</td>
	                <td><fmt:formatDate value="${booking.bookingTime}" pattern="yyyy-MM-dd HH:mm" /></td>
	                <td>${booking.meetingLocation}</td>
	                <td>
	                    <span class="badge 
	                        <c:if test='${booking.status == "PENDING"}'>badge-pending</c:if>
	                        <c:if test='${booking.status == "CONFIRMED"}'>badge-confirmed</c:if>
	                        <c:if test='${booking.status == "CANCELLED"}'>badge-cancelled</c:if>
	                    ">
	                        ${booking.status}
	                    </span>
	                </td>
	                <td>
	              	<button class="btn-icon edit-btn" title="Edit" onclick="openModal(${booking.id}, '${booking.status}')">✏️</button>
	                </td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>

		<!-- Status Change Modal -->
	<div id="statusModal" class="modal">
	    <div class="modal-content">
	        <span class="close-btn" onclick="closeModal()">&times;</span>
	        <h3>Update Inquiry Status</h3>
	        <form id="statusForm" method="post" action="${pageContext.request.contextPath}/admin?action=updateInquiryStatus">
	            <input type="hidden" id="bookingId" name="id">
	            <div>
	                <label for="newStatus">Select New Status:</label>
	                <select id="newStatus" name="status" required>
	                    <option value="PENDING">Pending</option>
	                    <option value="CONFIRMED">Confirmed</option>
	                    <option value="CANCELLED">Cancelled</option>
	                </select>
	            </div>
	            <br>
	            <button type="submit" class="btn btn-primary">Save Changes</button>
	        </form>
	    </div>
	</div>
		
	
		   
	
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <div class="pagination-info">
                            Showing ${startItem} to ${endItem} of ${totalInquiries}
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
            const rows = document.querySelectorAll("#inquiries-table tbody tr");
            const search = value.toLowerCase();

            rows.forEach(row => {
                const user = row.cells[1].textContent.toLowerCase();
                const property = row.cells[2].textContent.toLowerCase();
                const type = row.cells[3].textContent.toLowerCase();
                const status = row.cells[4].textContent.toLowerCase();

                if (user.includes(search) || property.includes(search) || type.includes(search) || status.includes(search)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
    
		
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
	        var modal = document.getElementById("statusModal");
	        if (event.target == modal) {
	            closeModal();
	        }
	    }
	</script>
</body>
</html>