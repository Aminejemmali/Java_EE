<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="package1.connection.Dbconnection" %>
<%@ page import="package1.dao.ProductDao" %>
<%@ page import="package1.model.Cart" %>
<%@ page import="package1.model.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    
    User auth = (User) request.getSession().getAttribute("auth");
    request.setAttribute("auth", auth);

    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = new ArrayList<>();
    
    if (cartList != null && !cartList.isEmpty()) {
        ProductDao pDao = new ProductDao(Dbconnection.getConnection());
        cartProduct = pDao.getCartProducts(cartList);
        double total = pDao.getTotalCartPrice(cartList);
        request.setAttribute("total", total);
        request.setAttribute("cart_list", cartList);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="./includes/head.jsp" %>
    <title>Book Store  | Cart </title>
</head>
<body style="background-color: lightblue;">
    <%@ include file="./includes/navbar.jsp" %>

    <div class="container my-3">
        <div class="d-flex py-3">
        <div class="d-flex py-3"><h3>Total Price: $ ${(total>0)?dcf.format(total):0} </h3> <a class="mx-3 btn btn-primary" href="checkout">Check Out</a></div>
        </div>
        
        <table class="table table-light">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price</th>
                    <th scope="col">Buy Now</th>
                    <th scope="col">Cancel</th>
                </tr>
            </thead>
            <tbody>
                <% if (!cartProduct.isEmpty()) {
                    for (Cart c : cartProduct) { %>
                        <tr>
                            <td><%= c.getName() %></td>
                            <td><%= c.getCategory() %></td>
                            <td><%= dcf.format(c.getPrice()) %></td>
                            <td>
                                <form action="OrderNow" method="post" class="form-inline">
                                 <input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
           							<div class="form-group d-flex justify-content-between w-50">
       									 <input type="text" name="quantity" class="form-control mr-4" value="<%= c.getQuantity() %>">
       									 <button type="submit" class="btn btn-primary btn-sm">Buy</button>
    								</div>
								</form>
                                
                            </td>
                            <td>
                                <a href="RemoveItem?id=<%= c.getId() %>" class="btn btn-sm btn-danger">Remove</a>
                            </td>
                        </tr>
                    <% }
                } else { %>
                    <tr>
                        <td colspan="5">Your cart is empty</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@ include file="./includes/footer.jsp" %>
</body>
</html>
