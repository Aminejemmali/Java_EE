package package1.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import package1.connection.Dbconnection;
import package1.dao.ReclamationDao;
import package1.model.Reclamation;
import package1.model.User;

@WebServlet("/AddReclamationServlet")
public class AddReclamationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("add-reclamation.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String description = request.getParameter("reclamation-description");
            User auth = (User) request.getSession().getAttribute("auth");

            // Validate input
            if (description == null || description.isEmpty()) {
                out.println("Please fill in the description.");
                return;
            }

            // Create reclamation object
            Reclamation reclamation = new Reclamation(0, auth.getId(), description, "Pending");

            // Add reclamation
            ReclamationDao reclamationDao = new ReclamationDao(Dbconnection.getConnection());
            if (reclamationDao.addReclamation(reclamation)) {
                response.sendRedirect("reclamation.jsp");
            } else {
                out.println("Reclamation submission failed");
            }

        } catch (ClassNotFoundException | SQLException e) {
            // Handle exception
            e.printStackTrace();
        }
    }
}
