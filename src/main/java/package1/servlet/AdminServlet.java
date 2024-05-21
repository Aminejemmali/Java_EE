package package1.servlet;

import package1.dao.AdminDao;
import package1.model.Admin;
import package1.connection.Dbconnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            AdminDao adminDao = null;
			try {
				adminDao = new AdminDao(Dbconnection.getConnection());
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            Admin admin = adminDao.login(username, password);

            if (admin != null) {
                request.getSession().setAttribute("admin", admin);
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("admin-login.jsp?error=Invalid Username or Password");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
