<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.web.model.User"%>

<style>
/* Admin Header Styles */
.admin-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 30px;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.admin-logo-container {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 20px;
    font-weight: bold;
    color: #007BFF;
}

.admin-logo-icon {
    width: 32px;
    height: auto;
}

.header-actions {
    display: flex;
    align-items: center;
    gap: 15px;
}

/* Profile popup styles */
.profile-dropdown {
    position: relative;
    display: inline-block;
}

.profile-icon {
    cursor: pointer;
    font-size: 24px;
    border-radius: 50%;
    background-color: #f0f0f0;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.profile-dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: #fff;
    min-width: 250px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1000;
    border-radius: 5px;
    padding: 15px;
}

.profile-dropdown-content.show {
    display: block;
}

.profile-header {
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
    margin-bottom: 10px;
    font-weight: bold;
}

.profile-detail {
    margin: 8px 0;
    display: flex;
    align-items: center;
}

.detail-icon {
    margin-right: 10px;
    color: #666;
    width: 16px;
    text-align: center;
}

.signout-btn {
    margin-top: 15px;
    width: 100%;
    padding: 8px;
    background-color: #f44336;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.signout-btn:hover {
    background-color: #d32f2f;
}
</style>

<header class="admin-header">
    <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="logo">
        <div class="admin-logo-container">
            <img src="https://res.cloudinary.com/dxb3ogrhz/image/upload/v1744336330/sang_iefgzk.png " alt="Sangri-La Estates" class="admin-logo-icon" />
            <span>Sangri-La Estates</span>
        </div>
    </a>

    <div class="header-actions">
        <div class="profile-dropdown">
            <div class="profile-icon" onclick="toggleProfileDropdown()">👤</div>
            <div class="profile-dropdown-content" id="profileDropdown">
                <c:choose>
                    <c:when test="${not empty user}">
                        <div class="profile-header">Admin Profile</div>
                        <div class="profile-detail">
                            <div class="detail-icon">👤</div>
                            <div>${user.fullName}</div>
                        </div>
                        <div class="profile-detail">
                            <div class="detail-icon">✉️</div>
                            <div>${user.email}</div>
                        </div>
                        <div class="profile-detail">
                            <div class="detail-icon">📞</div>
                            <div>${user.phone}</div>
                        </div>
                        <div class="profile-detail">
                            <div class="detail-icon">🏠</div>
                            <div>${user.address}</div>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin?action=signout">
                            <button class="signout-btn">Sign Out</button>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <p>No user logged in.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<script>
function toggleProfileDropdown() {
    document.getElementById("profileDropdown").classList.toggle("show");
}

// Close dropdown if clicked outside
window.onclick = function(event) {
    if (!event.target.matches('.profile-icon')) {
        var dropdowns = document.getElementsByClassName("profile-dropdown-content");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}
</script>