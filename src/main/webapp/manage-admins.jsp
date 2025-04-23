<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"superadmin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../index.jsp");
        return;
    }

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String error = request.getParameter("error");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_db", "root", "password");

        // Fetch existing admin users
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM users WHERE role='admin'");

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Admins</title>
</head>
<body>

<h1>Manage Admin Users</h1>

<% if ("1".equals(error)) { %>
<p style="color: red;">An error occurred. Please try again.</p>
<% } %>

<h2>Add New Admin</h2>
<form action="AddAdminServlet" method="POST">
    <label>Username:</label>
    <input type="text" name="username" required>
    <label>Password:</label>
    <input type="password" name="password" required>
    <input type="submit" value="Add Admin">
</form>

<h2>Existing Admins</h2>
<table border="1">
    <thead>
    <tr>
        <th>Username</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% while (rs.next()) { %>
    <tr>
        <td><%= rs.getString("username") %></td>
        <td>
            <a href="EditAdminServlet?id=<%= rs.getInt("id") %>">Edit</a> |
            <a href="DeleteAdminServlet?id=<%= rs.getInt("id") %>">Delete</a>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
