<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="package1.dao.ProductDao"%>
<%@page import="package1.model.*"%>
<%@page import="package1.connection.Dbconnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("auth", auth);
    }
    ProductDao pd = new ProductDao(Dbconnection.getConnection());
    List<Product> products = pd.getAllProducts();
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <%@ include file="./includes/head.jsp" %>
    <title>Book Store  | Home</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        /* Custom styles go here */
        .product-card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body style="background-color: lightblue;">

    <%@ include file="./includes/navbar.jsp" %>

    <div class="container">
        <div class="card-header my-3">All Products</div>
        
        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" class="form-control" id="searchInput" placeholder="Search for products...">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button" onclick="searchProducts()">Search</button>
            </div>
        </div>

        <!-- Product Cards -->
        <div class="row" id="productContainer">
            <% 
                if (!products.isEmpty()) {
                    for (Product p : products) {
            %>
                        <div class="col-md-3 my-3 product-card">
                            <div class="card w-100">
                                <img class="card-img-top" src="products-images/<%= p.getImage() %>"
                                    alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title"><%= p.getName() %></h5>
                                    <h6 class="price">Price: $<%= p.getPrice() %></h6>
                                    <h6 class="category">Category: <%= p.getCategory() %></h6>
                                    <div class="mt-3 d-flex justify-content-between">
                                        <a class="btn btn-dark" href="AddToCart?id=<%= p.getId() %>">Add to Cart</a>
                                        <a class="btn btn-primary" href="order-now?quantity=1&id=<%= p.getId() %>">Buy Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
                    out.println("There are no products available.");
                }
            %>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                </li>
                <!-- Add dynamic pagination links here based on the total number of pages -->
                <!-- Example: <li class="page-item"><a class="page-link" href="?page=1">1</a></li> -->
                <li class="page-item disabled">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
    </div>

    <%@ include file="./includes/footer.jsp" %>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <script>
        // Function to perform product search
        function searchProducts() {
            var searchInput = document.getElementById("searchInput").value.toLowerCase();
            var productContainer = document.getElementById("productContainer");
            var productCards = productContainer.getElementsByClassName("product-card");

            for (var i = 0; i < productCards.length; i++) {
                var productName = productCards[i].getElementsByClassName("card-title")[0].innerText.toLowerCase();
                if (productName.includes(searchInput)) {
                    productCards[i].style.display = "";
                } else {
                    productCards[i].style.display = "none";
                }
            }
        }
    </script>
</body>
</html>