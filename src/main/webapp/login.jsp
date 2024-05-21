
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="package1.connection.Dbconnection"%>
<%@page import="package1.dao.ProductDao"%>
<%@page import="package1.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
        <%
User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
    	response.sendRedirect("index.jsp");
    }
    
 
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
   if (cart_list != null) {
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="./includes/head.jsp" %>
<title>Book Store  | Login </title>
</head>
<body style="background-color: lightblue;">
<%@ include file="./includes/navbar.jsp" %>
<div class="container">

		<div class="card w-50 mx-auto my-5">
		
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="User_Login" method="post">
					<div class="form-group">
						<label>Email address</label> 
						<input type="email" name="login-email" class="form-control" placeholder="Enter email">
					</div>
					<div class="form-group">
						<label>Password</label> 
						<input type="password" name="login-password" class="form-control" placeholder="Password">
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>


<%@ include file="./includes/footer.jsp" %>
</body>
</html>