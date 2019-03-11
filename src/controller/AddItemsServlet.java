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

import com.mysql.jdbc.PreparedStatement;

import model.AddItems;

@WebServlet("/additems.html")
public class AddItemsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AddItems ai = new AddItems();
		
		ai.setPlanName(request.getParameter("planName"));
		ai.setProductName(request.getParameter("productName"));
		ai.setProductCategory(request.getParameter("productCategory"));
		ai.setSrp(Double.parseDouble(request.getParameter("srp")));
		
		if(insertItemsToDB(ai.getPlanName(), ai.getProductName(), ai.getProductCategory(), ai.getSrp())){
			request.setAttribute("status", "true");
			request.getRequestDispatcher("editproducts.jsp").forward(request, response);
			System.out.println(request.getAttribute("session"));
		
		}else{
			request.setAttribute("status", "false");
			request.getRequestDispatcher("editproducts.jsp").forward(request, response);
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
