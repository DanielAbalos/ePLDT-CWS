package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

import model.AddItemsBean;

@WebServlet("/additems.html")
public class AddItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
System.out.println("------------------------- ADD ITEMS SERVLET -------------------------");
		
		String userSession = "";
		
		Cookie[] cookies = request.getCookies();
		int i = 0;
		if(cookies != null){
			for (Cookie cookie : cookies ) {
				userSession = cookies[i].getName();
				System.out.println("ADD ITEMS SERVLET COOKIE NAME: " + cookies[i].getName());
				System.out.println("ADD ITEMS SERVLET VALUE: " + cookies[i].getValue());
				i++;
			}
			
			if(!userSession.equals("userSession")){
				System.out.println("NO SESSION");
				response.sendRedirect("index.html");
			
			}else{
				response.sendRedirect("editproducts.jsp");
			}
		
		}else{
			response.sendRedirect("login.html");
		}
		
		
		System.out.println("------------------------- ADD ITEMS SERVLET -------------------------");
		
		AddItemsBean ai = new AddItemsBean();
		
		ai.setPlanName(request.getParameter("planName"));
		ai.setProductName(request.getParameter("productName"));
		ai.setProductCategory(request.getParameter("productCategory"));
		ai.setSrp(Double.parseDouble(request.getParameter("srp")));
		
		if(insertItemsToDB(ai.getPlanName(), ai.getProductName(), ai.getProductCategory(), ai.getSrp())){
			response.sendRedirect("editproducts.jsp");
			System.out.println(request.getAttribute("session"));
		
		}else{
			response.sendRedirect("editproducts.jsp");
		}
	}
	
	private static boolean insertItemsToDB(String planName, String productName, String productCategory,
			double srp){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("INSERT INTO products "
					+ "(plan_name, product_name, product_category, srp)"
					+ "VALUES (?,?,?,?)");
			pstmt.setString(1, planName);
			pstmt.setString(2, productName);
			pstmt.setString(3, productCategory);
			pstmt.setDouble(4, srp);
			
			pstmt.execute();
			
			conn.close();
			
			return true;

		}catch(SQLException sqle){
			System.out.println("SQLException in insertItemsToDB - AddItemsServlet");
			sqle.printStackTrace();
			
			return false;
		
		}catch (ClassNotFoundException cfne) {
			cfne.printStackTrace();
			return false;
		}

	}

}
