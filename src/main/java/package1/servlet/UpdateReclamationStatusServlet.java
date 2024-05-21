package package1.servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import package1.connection.Dbconnection;
import package1.dao.AdminDao;

@WebServlet("/UpdateReclamationStatusServlet")
public class UpdateReclamationStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int reclamationId = Integer.parseInt(request.getParameter("reclamationId"));
            String newStatus = request.getParameter("status");

            AdminDao adminDao = new AdminDao(Dbconnection.getConnection());
            adminDao.updateReclamationStatus(reclamationId, newStatus);

            // Redirect back to admin.jsp after updating
            response.sendRedirect("admin.jsp");
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions as needed
            response.getWriter().println("An error occurred while updating reclamation status.");
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
