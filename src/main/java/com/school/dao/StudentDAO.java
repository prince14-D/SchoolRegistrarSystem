package com.school.dao;

import com.school.model.Student;
import java.sql.*;
import java.util.*;

public class StudentDAO {

    private Connection getConnection() throws SQLException {
        // Adjust to your DB settings
        String url = "jdbc:mysql://localhost:3306/school_db";
        String username = "Admin";
        String password = "Password@123";
        return DriverManager.getConnection(url, username, password);
    }

    public List<Student> getStudents(int start, int total, String search) {
        List<Student> list = new ArrayList<>();
        try (Connection con = getConnection()) {
            PreparedStatement ps;
            if (search != null && !search.trim().isEmpty()) {
                ps = con.prepareStatement("SELECT * FROM students WHERE name LIKE ? LIMIT ?, ?");
                ps.setString(1, "%" + search + "%");
                ps.setInt(2, start);
                ps.setInt(3, total);
            } else {
                ps = con.prepareStatement("SELECT * FROM students LIMIT ?, ?");
                ps.setInt(1, start);
                ps.setInt(2, total);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setContact(rs.getString("contact"));
                s.setClassName(rs.getString("class"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalRecords(String search) {
        int count = 0;
        try (Connection con = getConnection()) {
            PreparedStatement ps;
            if (search != null && !search.trim().isEmpty()) {
                ps = con.prepareStatement("SELECT COUNT(*) FROM students WHERE name LIKE ?");
                ps.setString(1, "%" + search + "%");
            } else {
                ps = con.prepareStatement("SELECT COUNT(*) FROM students");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
