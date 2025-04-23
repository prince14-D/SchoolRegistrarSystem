<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String id = (String) request.getAttribute("id");
    String username = (String) request.getAttribute("username");
%>
<h1>Edit Admin</h1>

<form action="UpdateAdminServlet" method="POST">
    <input type="hidden" name="id" value="<%= id %>">
    <label>Username:</label>
    <input type="text" name="username" value="<%= username %>" required>
    <label>Password:</label>
    <input type="password" name="password" required>
    <input type="submit" value="Update Admin">
</form>
