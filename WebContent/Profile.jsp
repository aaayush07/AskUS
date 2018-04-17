<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="Askus.Logic"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.profile-image{
	height : 150px;
	width : 150px;
	border : solid 2px red; 
}
.live-window{
	height : 600px;
	width : 300px;
	border : solid 2px black;
	margin-top : 100px;
	margin-bottom : 100px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book My Show || Welcome Page</title>
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
%>
<body onload = "live()">
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
     <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="QuestionWall.jsp">Ask US</a>
      <a class="navbar-brand" href="QuestionWall.jsp">Question Wall</a>
    </div>
              <div class="collapse navbar-collapse" id="myNavbar">
   <form class="navbar-form navbar-left" name = "vinform">
    <div class = "dropdown">
      <div class="input-group">
        <input type="text" class="form-control dropdown-toggle" id = "srch" placeholder="Search" name="t1" data-toggle = "dropdown" onKeyup = "sendInfo()" onclick = "size()">
         <ul class="dropdown-menu" role="menu" aria-labelledby="menu1" id = "amit" >
    	</ul>
      </div>
      </div>
    </form>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="#"><span class="glyphicon glyphicon-user"></span><% String name = nameParse( (String)session.getAttribute("username"));  %> <%= name %></a></li>
      <li><a href="Info.jsp"><span class="glyphicon glyphicon-log-in"></span>Edit Info</a></li>
      <li><a href="LogOut.jsp"><span class="glyphicon glyphicon-log-in"></span>Log Out</a></li>
    </ul>
  </div>
  </div>
  </nav>
 <div class = "container-fluid">
    <div class="row" >
        <div class ="col-sm-2">
        <div class = "profile-image"></div>
        <hr>
        <h2><%= name %></h2>
        </div>
        <div class ="col-sm-6">
        <hr>
        <h2>Top Questions By You </h2>
        <% 
 	Logic obj = new Logic();
 	Connection con = obj.getConnection();
 	PreparedStatement ps = con.prepareStatement("Select * from Question where id = ? order by date desc LIMIT 5");
 	ps.setInt(1 , (int)session.getAttribute("userid") );
 	ResultSet rs = ps.executeQuery();
 	int a[] = new int[100];
 	int i = 0;
 	while(rs.next()){
 		%>
 		  <% 
 		out.print("<h2> Q - " + rs.getString(2) + "</h2><br>");
 		a[ i ] = rs.getInt(1);

 		PreparedStatement ps1 = con.prepareStatement("Select * from Answer where qid = " + a[i] + " Order by likes desc limit 1");
 		int flag = 0;
 		ResultSet rs1 = ps1.executeQuery();
 		while(rs1.next()){ 
 			flag = 1;%>
 			<h3> Ans - <%= rs1.getString( 2 ) %> </h3><br>
 			<% 
 			out.println("<a role='menuitem' tabindex='-1' href= 'SearchResult.jsp?search= "+ rs1.getInt(5) + " '>");%>
 			 Answer By :- <%= nameParse(obj.getAnswerWriterName(rs1.getInt(5))) %></a>
 			<hr>
 			<button type='button' class='btn btn-primary' >Like</button>
 			<button type='button' class='btn btn-primary' >Comment</button>
 			<form action = "QuestionAnswerSave.jsp">
 			<button type = "submit" class = "btn btn-primary">Answer Question</button>
 			<input type = "hidden" value ="<%= a[i] %>" name = "qid">
 			</form>
 			<br><br> <% 
 		}
 		if(flag == 0){%>
 			<hr>
 			<form action = "QuestionAnswerSave.jsp">
 			<button type = "submit" class = "btn btn-primary">Answer Question</button>
 			<input type = "hidden" value ="<%= a[i] %>" name = "qid">
 			</form><% 
 		}
 		rs1.close();
 		ps1.close();
 		%><% 
 		i++;
 	}
 	rs.close();
 	ps.close();
 	con.close();
 %>
 
 <h2> Top Answers By You </h2>
 
 

        </div>
        <div class ="col-sm-4" >
        <h4>Live Window</h4>
        <div class = "live-window" >
        <ul class = "list-group" id = "livewindow">
        </ul>
        </div>
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
  
var request;  
function live(){
	var xyz = setInterval(sendInfo2 , 2000);
}

function sendInfo2()  
{    
var url="LiveWindow.jsp";  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}    
try{  
request.onreadystatechange=getInfow;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  


function getInfow(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('livewindow').innerHTML=val;  
}  
}
function size(){
	var srch = document.getElementById("srch");
	srch.style.width = "300px";
}
</script>
</html>