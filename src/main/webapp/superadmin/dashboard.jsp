<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"superadmin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>
<h1>Welcome Superadmin, <%= session.getAttribute("user") %></h1>
<ul>
    <li><a href="manage-admins.jsp">Manage Admins</a></li>
    <li><a href="manage-students.jsp">Manage Students</a></li>
    <li><a href="../logout.jsp">Logout</a></li>
</ul>
