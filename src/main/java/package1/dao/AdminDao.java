package package1.dao;

import package1.connection.Dbconnection;
import package1.model.Admin;
import package1.model.Reclamation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDao {
    private Connection conn;

    public AdminDao(Connection conn) {
        this.conn = conn;
    }

    public Admin login(String username, String password) {
        Admin admin = null;
        String query = "SELECT * FROM admins WHERE username=? AND password=?";

        try {
            PreparedStatement pstmt = this.conn.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return admin;
    }
    public List<Reclamation> getAllReclamations() {
        List<Reclamation> reclamations = new ArrayList<>();
        String query = "SELECT id, user_id, description, status FROM reclamations";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reclamation reclamation = new Reclamation(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("description"),
                    rs.getString("status")
                );
                reclamations.add(reclamation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reclamations;
    }
    public void updateReclamationStatus(int reclamationId, String newStatus) throws SQLException {
        String query = "UPDATE reclamations SET status = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, reclamationId);
            pstmt.executeUpdate();
        }
    }

    // Add other admin-related methods as needed
}
