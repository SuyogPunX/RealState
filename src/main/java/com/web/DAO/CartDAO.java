package com.web.DAO;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public static void saveCartToDB(String userId, List<Integer> propertyIds) {
        String deleteSql = "DELETE FROM user_cart WHERE user_id = ?";
        String insertSql = "INSERT INTO user_cart (user_id, property_id) VALUES (?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmtDelete = conn.prepareStatement(deleteSql);
             PreparedStatement pstmtInsert = conn.prepareStatement(insertSql)) {

            conn.setAutoCommit(false);

            pstmtDelete.setString(1, userId);
            pstmtDelete.executeUpdate();

            for (int id : propertyIds) {
                pstmtInsert.setString(1, userId);
                pstmtInsert.setInt(2, id);
                pstmtInsert.addBatch();
            }

            pstmtInsert.executeBatch();
            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Integer> getCartFromDB(String userId) {
        List<Integer> propertyIds = new ArrayList<>();
        String sql = "SELECT property_id FROM user_cart WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                propertyIds.add(rs.getInt("property_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return propertyIds;
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/your_db", "root", "password");
    }
}