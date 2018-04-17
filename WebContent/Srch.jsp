<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Search Bar || Example</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<% 
	request.getSession(false);
	if((int)session.getAttribute("userid") > 0){
		int id = (int)session.getAttribute("userid"); 
	}
	else{
		response.sendRedirect("LoginPage");
	}
%>
<%  
String s=request.getParameter("val");  
if(s==null || s.trim().equals("")){  
}else{   
try{  
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/AskUS","root","Aayush07@");  
PreparedStatement ps=con.prepareStatement("select email from UserInfo where email like '" + s + "%'");   
ResultSet rs=ps.executeQuery();  
if(!rs.isBeforeFirst()){
	out.print(" <li role='presentation' class='divider'></li>");
	out.print("<li role='presentation'><a role='menuitem' tabindex='-1' >No Results Found</a></li>");
}else{
while(rs.next()){  
	out.print("<li role = 'presentation'>");
	out.print("<a role='menuitem' tabindex='-1' href= 'SearchResult.jsp?search="+ rs.getString(1) + " '>");
	out.println(rs.getString(1));
	out.print("</a>");
	out.print("</li>");
}  }
con.close();  
}catch(Exception e){e.printStackTrace();}  
}  
%>  

</body>
</html>