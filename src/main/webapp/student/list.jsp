<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.school.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <style>
        body { font-family: Arial; }
        h2 { text-align: center; }
        table { border-collapse: collapse; width: 80%; margin: auto; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f4f4f4; }
        .actions a { margin: 0 5px; }
        .search-container, .pagination { text-align: center; margin: 20px 0; }
        .add-btn {
            display: block;
            width: fit-content;
            margin: 10px auto;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .add-btn:hover {
            background-color: #45a049;
        }
        .pagination a {
            padding: 8px 12px;
            margin: 0 5px;
            text-decoration: none;
            border: 1px solid #ccc;
            color: #333;
        }
        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>

<h2>Student List</h2>

<div class="search-container">
    <form action="listStudent" method="get">
        <input type="text" name="search" placeholder="Search by name..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <input type="submit" value="Search">
    </form>
</div>

<a href="addStudent.jsp" class="add-btn">Add New Student</a>

<table>
    <tr>
        <th>ID</th><th>Name</th><th>Email</th><th>Contact</th><th>Class</th><th>Action</th>
    </tr>

    <%
        List<Student> list = (List<Student>) request.getAttribute("list");
        if (list != null && !list.isEmpty()) {
            for (Student s : list) {
    %>
    <tr>
        <td><%= s.getId() %></td>
        <td><%= s.getName() %></td>
        <td><%= s.getEmail() %></td>
        <td><%= s.getContact() %></td>
        <td><%= s.getClassName() %></td>
        <td class="actions">
            <a href="editStudent?id=<%= s.getId() %>">Edit</a> |
            <a href="deleteStudent?id=<%= s.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">No students found.</td>
    </tr>
    <%
        }
    %>
</table>

<%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    String search = request.getParameter("search") != null ? request.getParameter("search") : "";
%>

<div class="pagination">
    <%
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
    %>
    <a href="listStudent?page=<%= i %>&search=<%= search %>" class="active"><%= i %></a>
    <%
    } else {
    %>
    <a href="listStudent?page=<%= i %>&search=<%= search %>"><%= i %></a>
    <%
            }
        }
    %>
</div>

</body>
</html>
