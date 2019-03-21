package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/index.html")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.sendRedirect("errorpage.html");
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		System.out.println("SESSION-INDEX: " + session);
		//response.sendRedirect("login.html");
		
		if(session == null){
			response.sendRedirect("login.html");
		
		}else{
			session.invalidate();
			//logging out
			response.sendRedirect("login.html");
		}
		
	}

}
