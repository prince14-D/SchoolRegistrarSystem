<%@ page import="com.school.model.Student" %>
<%
  Student s = (Student) request.getAttribute("student");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Student</title>
</head>
<body>
<h2>Edit Student</h2>

<form action="updateStudent" method="post">
  <input type="hidden" name="id" value="<%= s.getId() %>" />
  Name: <input type="text" name="name" value="<%= s.getName() %>" /><br/>
  Email: <input type="text" name="email" value="<%= s.getEmail() %>" /><br/>
  Contact: <input type="text" name="contact" value="<%= s.getContact() %>" /><br/>
  Class: <input type="text" name="className" value="<%= s.getClassName() %>" /><br/>
  <input type="submit" value="Update"/>
</form>

</body>
</html>
