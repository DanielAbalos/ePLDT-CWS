package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/editcostworksheet.html" )
public class EditWorksheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		System.out.println("SESSION-EDITCOSTWORKSHEET: " + session);
		
		if(session == null){
			response.sendRedirect("index.html");
		
		}else{
			String finalWorksheetTitle = request.getParameter("finalProjectName");
			
			request.setAttribute("worksheetTitle", finalWorksheetTitle);
			request.getRequestDispatcher("costworksheet.jsp").forward(request, response);
		}
	}

}
