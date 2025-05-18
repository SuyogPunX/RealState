<%@ page import="java.util.List" %>
<%@ page import="com.web.model.Property" %>
<jsp:useBean id="cartProperties" type="java.util.List<com.web.model.Property>" scope="request"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
</head>
<body>
<h2>Your Property Cart</h2>

<% if (cartProperties.isEmpty()) { %>
<p>Your cart is empty.</p>
<% } else { %>
<ul>
    <% for (Property p : cartProperties) { %>
    <li>
        <%= p.getTitle() %> - $<%= p.getFormattedPrice() %>
        <a href="removeFromCart?propertyId=<%= p.getPropertyId() %>">[Remove]</a>
    </li>
    <% } %>
</ul>
<% } %>

<a href="index.jsp">Continue Shopping</a>
</body>
</html>