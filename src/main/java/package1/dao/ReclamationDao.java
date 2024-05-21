package package1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import package1.model.Reclamation;

public class ReclamationDao {
    private Connection con;

    public ReclamationDao(Connection con) {
        this.con = con;
    }

    public boolean addReclamation(Reclamation reclamation) {
        boolean result = false;
        try {
            String query = "INSERT INTO reclamations(user_id, description, status) VALUES (?, ?, ?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, reclamation.getUserId());
            pst.setString(2, reclamation.getDescription());
            pst.setString(3, reclamation.getStatus());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Reclamation> getReclamationsByUserId(int userId) {
        List<Reclamation> reclamations = new ArrayList<>();
        try {
            String query = "SELECT * FROM reclamations WHERE user_id = ?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
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
}
