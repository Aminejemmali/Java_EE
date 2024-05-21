<%@page import="package1.dao.AdminDao"%>
<%@page import="java.util.List"%>
<%@page import="package1.dao.ReclamationDao"%>
<%@page import="package1.model.Reclamation"%>
<%@page import="package1.connection.Dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body { padding: 20px; }
    </style>
</head>
<body>

    <div class="container">
        <h1>Reclamation Management</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AdminDao reclamationadmin = new AdminDao(Dbconnection.getConnection());
                        List<Reclamation> reclamations = reclamationadmin.getAllReclamations();
                        for (Reclamation reclamation : reclamations) {
                    %>
                    <tr>
                        <td><%= reclamation.getId() %></td>
                        <td><%= reclamation.getUserId() %></td>
                        <td><%= reclamation.getDescription() %></td>
                        <td><%= reclamation.getStatus() %></td>
                        <td>
                            <form action="UpdateReclamationStatusServlet" method="post">
                                <input type="hidden" name="id" value="<%= reclamation.getId() %>" />
                                <select name="status" class="form-control">
                                    <option value="Pending" <%= reclamation.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option value="Resolved" <%= reclamation.getStatus().equals("Resolved") ? "selected" : "" %>>Resolved</option>
                                    <option value="Dismissed" <%= reclamation.getStatus().equals("Dismissed") ? "selected" : "" %>>Dismissed</option>
                                </select>
                                <button type="submit" class="btn btn-primary mt-2">Update</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
