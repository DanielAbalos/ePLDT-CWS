package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserBean;

@WebServlet("/loginprocess.html")
public class LoginProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.sendRedirect("errorpage.html");
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserBean ub = new UserBean();
		
		ub.setUsername(request.getParameter("username"));
		ub.setPassword(request.getParameter("password"));

		if(validateUser(ub.getUsername(), ub.getPassword())){
			
			Cookie userSessionCookie = new Cookie("userSession", ub.getUsername());
			userSessionCookie.setMaxAge(60 * 60 * 8);
			response.addCookie(userSessionCookie);
			
			System.out.println("LOGIN SESSION: " + request.getCookies());
			
			request.setAttribute("session", request.getCookies());
			request.getRequestDispatcher("costworksheetlist.jsp").forward(request, response);
		
		}else{
			response.sendRedirect("loginerror.html");
		}
		
	}
	
	private static boolean validateUser(String username, String password){
		
		String status = "false";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT PASSWORD FROM users WHERE username = '" + username + "'");
			
			if(rs.next()){
				if(rs.getString("password").equals(password)){
					status = "true";
				
				}else{
					status = "false";
				}
			}
			
			conn.close();

		}catch(SQLException sqle){
			System.out.println("SQL Error in connectToUserDB - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		if(status.equals("true")){
			return true;
		}else{
			return false;
		}

	}
}
