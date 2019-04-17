package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/logout.html")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("------------------------- LOGOUT -------------------------");
		
		Cookie userSessionCookie = new Cookie("userSession", "");
		userSessionCookie.setMaxAge(0);
		response.addCookie(userSessionCookie);
		
		Cookie[] cookies = request.getCookies();
		int i = 0;
		for (Cookie cookie : cookies ) {
			System.out.println("INDEX COOKIE NAME: " + cookies[i].getName());
			System.out.println("INDEX COOKIE VALUE: " + cookies[i].getValue());
			i++;
		}
		
		response.sendRedirect("index.html");
		
		System.out.println("------------------------- LOGOUT -------------------------");
	}

}
