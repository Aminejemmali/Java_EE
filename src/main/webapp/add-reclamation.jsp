<%@page import="package1.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="./includes/head.jsp" %>
    <title>Add Reclamation</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body style="background-color: lightblue;">
    <%@ include file="./includes/navbar.jsp" %>

    <div class="container">
        <div class="card my-5">
            <div class="card-header">Add Reclamation</div>
            <div class="card-body">
                <form action="AddReclamationServlet" method="post">
                    <div class="form-group">
                        <label for="reclamation-description">Description</label>
                        <textarea class="form-control" id="reclamation-description" name="reclamation-description" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="./includes/footer.jsp" %>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
