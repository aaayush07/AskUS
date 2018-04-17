package Askus;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String username =request.getParameter("email");
	      String password = request.getParameter("pwd");
	      try {
	    	  int flag = new Logic().newUser(username,password);
	    	  if(flag > 0) {
	    		  	HttpSession session = request.getSession();
					session= request.getSession();  
					session.setAttribute("userid", flag);
			        session.setAttribute("username",username); 
			        RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
			        rd.include(request,response);
	    	  }
	    	  else {
	    		  	PrintWriter out = response.getWriter();
					out.println("Error Plz Try Again");
				    RequestDispatcher rd = request.getRequestDispatcher("SignUp.html");
				    rd.include(request, response);
	    	  }
	      }
	      catch(Exception e) {
	    	  e.printStackTrace();
	      }
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
