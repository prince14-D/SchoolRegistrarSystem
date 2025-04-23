<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<h1>Welcome Admin, <%= session.getAttribute("user") %></h1>
<ul>
    <li><a href="manage-students.jsp">Manage Students</a></li>
    <li><a href="../logout.jsp">Logout</a></li>
</ul>
