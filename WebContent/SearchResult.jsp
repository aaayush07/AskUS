<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Askus.Logic"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.profile-image{
	height : 50px;
	width : 50px;
	border : solid 2px red; 
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AskUS || Search Results</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<% 
	request.getSession(false);
	if((int)session.getAttribute("userid") > 0){
		int id = (int)session.getAttribute("userid"); 
	}
	else{
		response.sendRedirect("LoginPage");
	}
	String user_name = (String)request.getParameter("search");
%>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
     <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">AskUS</a>
    </div>
              <div class="collapse navbar-collapse" id="myNavbar">
   <form class="navbar-form navbar-left" name = "vinform">
    <div class = "dropdown">
      <div class="input-group">
        <input type="text" class="form-control dropdown-toggle" placeholder="Search" name="t1" data-toggle = "dropdown" onKeyup = "sendInfo()">
         <ul class="dropdown-menu" role="menu" aria-labelledby="menu1" id = "amit" >
    	</ul>
      </div>
      </div>
    </form>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="Profile.jsp"><span class="glyphicon glyphicon-user"></span><% String name = nameParse( (String)session.getAttribute("username"));  %> <%= name %></a></li>
      <li><a href="LogOut.jsp"><span class="glyphicon glyphicon-log-in"></span>Log Out</a></li>
    </ul>
  </div>
  </div>
  </nav>
 <div class = "container-fluid">
    <div class="row" >
        <div class ="col-sm-3" style="border : solid 2px black;">
        <div class = "profile-image"></div>
        </div>
        <div class ="col-sm-6" style="border : solid 2px black;">
        <h2><%= user_name %></h2>
        </div>
        <div class ="col-sm-3" style="border : solid 2px black;">
        <h4>Live Window</h4>
        </div>
    </div>
    </div>
<%!
 		public String nameParse(String id){
		int endIndex = id.indexOf('@');
		return id.substring(0, endIndex);
	}
 %>
</body>
<script> 
var request;  
function sendInfo()  
{  
var v=document.vinform.t1.value;  
var url="Srch.jsp?val="+v;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function getInfo(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('amit').innerHTML=val;  
}  
}  
  
</script>
</html>