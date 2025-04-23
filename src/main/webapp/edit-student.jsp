<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
  String id = (String) request.getAttribute("id");
  String name = (String) request.getAttribute("name");
  String email = (String) request.getAttribute("email");
  String contact = (String) request.getAttribute("contact");
  String className = (String) request.getAttribute("class");
%>

<h1>Edit Student</h1>

<form action="UpdateStudentServlet" method="POST">
  <input type="hidden" name="id" value="<%= id %>">
  <label>Name:</label>
  <input type="text" name="name" value="<%= name %>" required>
  <label>Email:</label>
  <input type="email" name="email" value="<%= email %>" required>
  <label>Contact:</label>
  <input type="text" name="contact" value="<%= contact %>" required>
  <label>Class:</label>
  <input type="text" name="className" value="<%= className %>" required>
  <input type="submit" value="Update Student">
</form>
