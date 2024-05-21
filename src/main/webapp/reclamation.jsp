<%@page import="package1.model.User"%>
<%@page import="java.util.List"%>
<%@page import="package1.dao.ReclamationDao"%>
<%@page import="package1.model.Reclamation"%>
<%@page import="package1.connection.Dbconnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ReclamationDao reclamationDao = new ReclamationDao(Dbconnection.getConnection());
    List<Reclamation> reclamations = reclamationDao.getReclamationsByUserId(auth.getId());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <%@ include file="./includes/head.jsp" %>
    <title>Book Store | My Reclamations</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .reclamation-card {
            margin-bottom: 20px;
        }
    </style>
</head>
<body style="background-color: lightblue;">
    <%@ include file="./includes/navbar.jsp" %>

    <div class="container">
        <div class="card-header my-3">My Reclamations</div>

        <!-- Button to Add New Reclamation -->
        <div class="mb-3">
            <a class="btn btn-primary" href="add-reclamation.jsp">Add New Reclamation</a>
        </div>

        <!-- Reclamation Cards -->
        <div class="row" id="reclamationContainer">
            <% 
                if (reclamations != null && !reclamations.isEmpty()) {
                    for (Reclamation r : reclamations) {
            %>
                        <div class="col-md-3 my-3 reclamation-card">
                            <div class="card w-100">
                                <div class="card-body">
                                    <h5 class="card-title"><%= r.getDescription() %></h5>
                                    <h6 class="status">Status: <%= r.getStatus() %></h6>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
                    out.println("You have no reclamations.");
                }
            %>
        </div>
    </div>

    <%@ include file="./includes/footer.jsp" %>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
