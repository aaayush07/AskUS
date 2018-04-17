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
 * Servlet implementation class QuestionSave
 */
@WebServlet("/QuestionSave")
public class QuestionSave extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionSave() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
		int id  = (int)session.getAttribute("userid");
		String question = request.getParameter("question");
		try {
			int flag = new Logic().addQuestion(question , id);
			if(flag > 0) {
				RequestDispatcher rd = request.getRequestDispatcher("QuestionWall.jsp");
		        rd.include(request,response);
			}
			else {
				PrintWriter out = response.getWriter();
				out.println("Try Again");
			    RequestDispatcher rd = request.getRequestDispatcher("AddQuestion.jsp");
			    rd.include(request, response);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
