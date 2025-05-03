<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Sangri-La Estates</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/registration.css">

</head>
<body>
    <!-- Header -->
 	    <!-- Include Header -->
    <jsp:include page="/pages/header.jsp" />

    <!-- Registration Form Section -->
    <div class="registration-container">
        <div class="form-header">
            <h2>Create an Account</h2>
            <p>Join Sangri-La Estates to find your dream property</p>
        </div>
        <div class="form-body">
        	  	<% 
					String errorMessage = (String) request.getAttribute("errorMessage");
					if (errorMessage != null) {
					    out.println("<div class='error-message'>" + errorMessage + "</div>");
					}
				%>
			<form action="${pageContext.request.contextPath}/RegistrationServlet" method="post">

                <div class="form-group form-row">
                    <div class="form-col">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" >
                    </div>
                    <div class="form-col">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" >
                    </div>
                </div>
                
                <div class="form-group form-row">
                	<div class="form-col">
                		<label for="phone">Phone Number</label>
                    	<input type="tel" id="phone" name="phone">
                	</div>
                
                	<div class="form-col">
                		<label for="dob">Date Of Birth</label>
                    	<input type="text" id="dob" name="dob" >
                	</div>
                </div>
                
                <div class="form-group form-row">
                    <div class="form-col">
                    	<label for="email">Email Address</label>
                    	<input type="email" id="email" name="email" >
                   </div>
                   	<div class="form-col">
                    	<label for="address">Address</label>
                    	<input type="text" id="address" name="address">
                   </div>
 
                   
                </div>
                             
                <div class="form-group form-row">
                    <div class="form-col">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" >
                    </div>
                    <div class="form-col">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" >
                    </div>
                </div>
                
                <div class="form-group form-row">
                    <div class="form-col">
                         <label><input type="radio" name="role" value="CUSTOMER" > Customer</label>
                    </div>
                    <div class="form-col">
                        <label><input type="radio" name="role" value="BROKER" > Broker</label>
                    </div>
                </div>                
                <button type="submit" class="submit-btn">Create Account</button>
            </form>
        </div>
    </div>
    
 	  <!-- Footer -->
 	<jsp:include page="/pages/footer.jsp" />
   		
</body>
</html>