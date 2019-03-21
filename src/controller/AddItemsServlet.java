package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;

import model.AddItemsBean;

@WebServlet("/additems.html")
public class AddItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		System.out.println("SESSION-PRODUCTS: " + session);
		if(session == null){
			response.sendRedirect("index.html");
		
		}else{
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
