package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/index.html")
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.sendRedirect("errorpage.html");
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("------------------------- INDEX -------------------------");
		
		String userSession = "";
		
		Cookie[] cookies = request.getCookies();
		int i = 0;
		if(cookies != null){
			for (Cookie cookie : cookies ) {
				userSession = cookies[i].getName();
				System.out.println("INDEX COOKIE NAME: " + cookies[i].getName());
				System.out.println("INDEX COOKIE VALUE: " + cookies[i].getValue());
				i++;
			}
			
			if(!userSession.equals("userSession")){
				System.out.println("NO SESSION");
				response.sendRedirect("login.html");
			
			}else{
				response.sendRedirect("costworksheetlist.jsp");
			}
		
		}else{
			response.sendRedirect("login.html");
		}
		
		
		System.out.println("------------------------- INDEX -------------------------");
	}

}
