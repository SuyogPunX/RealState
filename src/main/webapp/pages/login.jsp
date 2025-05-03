<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Shangri-La Estates</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
	    <!-- Include Header -->
    <jsp:include page="/pages/header.jsp" />
    <!-- Login Form Section -->
    <div class="login-container">
        <div class="form-header">
            <h2>Sign In to Your Account</h2>
        </div>
        <div class="form-body">
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
                    out.println("<div class='error-message'>" + errorMessage + "</div>");
                }
            %>
        
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <div class="password-header">
                        <label for="password">Password</label>
                    </div>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="submit-btn">Sign In</button>
                
                <div class="register-link">
                    <p>Don't have an account? <a href="registration.jsp">Register Now</a></p>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
  	    <!-- Include Header -->
    <jsp:include page="/pages/footer.jsp" />

</body>
</html>
