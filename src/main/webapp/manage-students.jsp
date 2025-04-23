<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
  HttpSession session = request.getSession(false);
  if (session == null || !"admin".equals(session.getAttribute("role")) && !"superadmin".equals(session.getAttribute("role"))) {
    response.sendRedirect("../index.jsp");
    return;
  }

  Connection con = null;
  Statement stmt = null;
  ResultSet rs = null;
  String error = request.getParameter("error");

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_db", "Admin", "Password@123");

    // Fetch existing students
    stmt = con.createStatement();
    rs = stmt.executeQuery("SELECT * FROM students");

  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Students</title>
</head>
<body>

<h1>Manage Students</h1>

<% if ("1".equals(error)) { %>
<p style="color: red;">An error occurred. Please try again.</p>
<% } %>

<h2>Add New Student</h2>
<form action="AddStudentServlet" method="POST">
  <label>Student Name:</label>
  <input type="text" name="name" required>
  <label>Email:</label>
  <input type="email" name="email" required>
  <label>Contact:</label>
  <input type="text" name="contact" required>
  <label>Class:</label>
  <input type="text" name="className" required>
  <input type="submit" value="Add Student">
</form>

<h2>Existing Students</h2>
<table border="1">
  <thead>
  <tr>
    <th>Name</th>
    <th>Email</th>
    <th>Contact</th>
    <th>Class</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <% while (rs.next()) { %>
  <tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("contact") %></td>
    <td><%= rs.getString("class") %></td>
    <td>
      <a href="EditStudentServlet?id=<%= rs.getInt("id") %>">Edit</a> |
      <a href="DeleteStudentServlet?id=<%= rs.getInt("id") %>">Delete</a>
    </td>
  </tr>
  <% } %>
  </tbody>
</table>

</body>
</html>
