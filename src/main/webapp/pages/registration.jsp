<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - DreamHome Realty Nepal</title>
    <link rel="stylesheet" href="../css/registration.css">
</head>
<body>
    <!-- Header -->
    <header>
        <a href="home.html" class="logo">
            <div class="logo-icon">📊</div>
            DreamHome Realty Nepal
        </a>
        <nav>
            <ul>
                <li><a href="home.html">Home</a></li>
                <li><a href="buypage.html">Buy</a></li>
                <li><a href="sell.html">Sell</a></li>
                <li><a href="aboutus.html">About Us</a></li>
                <li><a href="contactus.html">Contact</a></li>
            </ul>
        </nav>
        <div class="header-actions">
            <div class="header-icon">📍</div>
            <div class="header-icon">🛒</div>
            <a href="login.jsp"><button class="btn btn-outline">Sign In</button></a>
            <a href="registration.jsp"><button class="btn btn-primary">Register</button></a>
        </div>
    </header>

    <!-- Registration Form Section -->
    <div class="registration-container">
        <div class="form-header">
            <h2>Create an Account</h2>
            <p>Join DreamHome Realty Nepal to find your dream property</p>
        </div>
        <div class="form-body">
            <form id="registrationForm">
                <div class="form-group form-row">
                    <div class="form-col">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-col">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                
                <div class="form-group form-row">
                    <div class="form-col">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-col">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>I am interested in</label>
                    <div class="interest-options">
                        <div class="checkbox-group">
                            <input type="checkbox" id="buying" name="interest" value="buying">
                            <label for="buying">Buying</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" id="renting" name="interest" value="renting">
                            <label for="renting">Renting</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" id="selling" name="interest" value="selling">
                            <label for="selling">Selling</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" id="investing" name="interest" value="investing">
                            <label for="investing">Investing</label>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="submit-btn">Create Account</button>
            </form>
        </div>
    </div>

    <script src="../css/registration.css"></script>
</body>
</html>