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
 * Servlet implementation class AnswerSave
 */
@WebServlet("/AnswerSave")
public class AnswerSave extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnswerSave() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false); 
		int id  = (int)session.getAttribute("userid");
		String answer = request.getParameter("answer");
		String qid1  = request.getParameter("qid1");
		int qid = Integer.parseInt(qid1);
		try {
			int flag = new Logic().addAnswer(answer , id , qid );
			if(flag > 0) {
				RequestDispatcher rd = request.getRequestDispatcher("QuestionWall.jsp");
		        rd.include(request,response);
			}
			else {
				PrintWriter out = response.getWriter();
				out.println("Try Again");
			    RequestDispatcher rd = request.getRequestDispatcher("QuestionAnswerSave.jsp");
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
