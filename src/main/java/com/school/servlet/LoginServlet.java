package com.school.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_db", "root", "password");
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=?")) {

                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String hashedPassword = rs.getString("password"); // hashed in DB
                    String role = rs.getString("role");

                    // Use BCrypt for secure password comparison
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", username);
                        session.setAttribute("role", role);

                        if ("superadmin".equals(role)) {
                            response.sendRedirect("superadmin/dashboard.jsp");
                        } else {
                            response.sendRedirect("admin/dashboard.jsp");
                        }
                    } else {
                        response.sendRedirect("index.jsp?error=1");
                    }
                } else {
                    response.sendRedirect("index.jsp?error=1");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=2");
        }
    }
}
