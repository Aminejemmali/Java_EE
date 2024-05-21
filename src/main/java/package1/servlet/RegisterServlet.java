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
import package1.dao.UserDao;
import package1.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("register-name");
            String email = request.getParameter("register-email");
            String password = request.getParameter("register-password");

            // Validate input
            if (name == null || name.isEmpty() || email == null || email.isEmpty() || password == null || password.isEmpty()) {
                out.println("Please fill in all fields.");
                return;
            }

            // Create user object
            User user = new User(name, email, password);

            // Register user
            UserDao udao = new UserDao(Dbconnection.getConnection());
            if (udao.registerUser(user)) {
                response.sendRedirect("login.jsp");
            } else {
                out.println("User registration failed");
            }

        } catch (ClassNotFoundException | SQLException e) {
            // Handle exception
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
