package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;
import model.NewWorksheetBean;

@WebServlet("/newworksheetservlet.html")
public class NewWorksheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("errorpage.html");
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		
		NewWorksheetBean nwb = new NewWorksheetBean();
		
		nwb.setCustomerName(request.getParameter("customerName"));
		nwb.setProjectDescription(request.getParameter("projectDescription"));
		nwb.setCustomerType(request.getParameter("customerType"));
		nwb.setOpportunityID(request.getParameter("opportunityID"));
		nwb.setDate(format.format(date));
		
		saveNewWorksheetData(nwb.getCustomerName(), nwb.getProjectDescription(), 
				nwb.getCustomerType(), nwb.getOpportunityID(), nwb.getDate());
		
		response.sendRedirect("home.jsp");
		
	}
	
	private static void saveNewWorksheetData(String customerName, String projectDescription,
			String customerType, String opportunityID, String date){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("INSERT INTO worksheets (customer_name, project_description, customer_type, opportunityID, date)"
					+ "VALUES (?,?,?,?,?)");
			pstmt.setString(1, customerName);
			pstmt.setString(2, projectDescription);
			pstmt.setString(3, customerType);
			pstmt.setString(4, opportunityID);
			pstmt.setString(5, date);
			
			pstmt.execute();

		}catch(SQLException sqle){
			System.out.println("SQL Error in saveNewWorksheetData - NewWorksheetServlet.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
	}

}
