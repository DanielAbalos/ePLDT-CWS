package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
		System.out.println("------------------------- LOGIN PROCESS SERVLET -------------------------");
		
		UserBean ub = new UserBean();
		
		ub.setUsername(request.getParameter("username"));
		ub.setPassword(request.getParameter("password"));
		ub.setAuthLevel(getAuthLevel(ub.getUsername()));
		
		System.out.println(ub.getUsername());
		System.out.println(ub.getPassword());
		System.out.println(ub.getAuthLevel());

		if(validateUser(ub.getUsername(), ub.getPassword())){
			
			Cookie userSessionCookie = new Cookie("userSession", ub.getUsername() + "," + ub.getAuthLevel());
			userSessionCookie.setMaxAge(60 * 60 * 8);
			response.addCookie(userSessionCookie);
			
			/*Cookie[] cookies = request.getCookies();
			int i = 0;
			for (Cookie cookie : cookies ) {
				System.out.println("INDEX COOKIE NAME: " + cookies[i].getName());
				System.out.println("INDEX COOKIE VALUE: " + cookies[i].getValue());
				i++;
			}*/
			
			System.out.println("------------------------- LOGIN PROCESS SERVLET -------------------------");

			response.sendRedirect("costworksheetlist.jsp");
		
		}else{
			response.sendRedirect("loginerror.html");
		}

	}
	
	private static boolean validateUser(String username, String password){
		
		String status = "false";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT PASSWORD FROM users WHERE username = '" + username + "'");
			ResultSet rs = pstmt.executeQuery();
			
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
	
	public String getAuthLevel(String username){
		String authLevel = "";
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT authorization_level FROM users WHERE username = '" + username + "'");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				authLevel = rs.getString("authorization_level");
			}
			
		
		}catch(SQLException sqle){
			System.out.println("SQL Error in getAuthLevel - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return authLevel;
	}
}
