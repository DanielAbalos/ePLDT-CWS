package Utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ProfitAndLossComputations {
	
	public void displayPNL(String worksheetTitle){
		System.out.println("REVENUES: " + computeRevenues(worksheetTitle));
		System.out.println("TCV Recurring: " + TCVRecurring(worksheetTitle));
		System.out.println("TCV Non-Recurring: " + computeNonRecurring(worksheetTitle));
		System.out.println("Recurring: " + computeRecurring(worksheetTitle));
		System.out.println("Non-recurring: " + computeNonRecurring(worksheetTitle));
	}
	
	public double computeRevenues(String worksheetTitle){
		return TCVRecurring(worksheetTitle) + computeNonRecurring(worksheetTitle);
	}
	
	public double computeRecurring(String worksheetTitle){
		
		double recurringSum = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ "WHERE Clients_payment_options != 'Outright' AND Clients_payment_options != 'OPEX OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			recurringSum = rs.getDouble("SUM(Total_selling_price)");
			System.out.println("RECURRING SUM: " + rs.getDouble("SUM(Total_selling_price)"));

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfinAndLossComputations - computeRecurring()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return recurringSum;
	}
	
	public double computeNonRecurring(String worksheetTitle){
		double nonRecurringSum = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ "WHERE Clients_payment_options = 'Outright' AND Clients_payment_options = 'OPEX OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			nonRecurringSum = rs.getDouble("SUM(Total_selling_price)");
			System.out.println("RECURRING SUM: " + rs.getDouble("SUM(Total_selling_price)"));

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfinAndLossComputations - computeNonRecurring()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return nonRecurringSum;
	}
	
	public double TCVRecurring(String worksheetTitle){
		double recurringTCV = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ "WHERE Clients_payment_options = 'Outright' AND Clients_payment_options = 'OPEX OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			recurringTCV = rs.getDouble("SUM(recurring_tcv)");
			System.out.println("RECURRING SUM: " + rs.getDouble("SUM(Total_selling_price)"));

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfinAndLossComputations - computeNonRecurring()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return recurringTCV;
		
	}
	
	public double qtyPercentage(String worksheetTitle){
		return TCVRecurring(worksheetTitle) / computeRecurring(worksheetTitle);
	}

}
