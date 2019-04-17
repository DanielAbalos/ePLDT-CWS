package utility;

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
		System.out.println("--------------------------------------------------");
		System.out.println("Cost Of Managed IT Services: " + computeManagedITServicesCost(worksheetTitle));
		System.out.println("Cost Of Data Center: " + computeDataCenterCost(worksheetTitle));
		System.out.println("Cost Of Cloud: " + computeCloudCost(worksheetTitle));
		System.out.println("Cost Of Cyber Security: " + computeCyberSecCost(worksheetTitle));
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
					+ " WHERE Clients_payment_options != 'Outright' AND Clients_payment_options != 'OPEX-OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				recurringSum = rs.getDouble("SUM(Total_selling_price)");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeRecurring()");
		
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
					+ " WHERE Clients_payment_options = 'Outright' OR Clients_payment_options = 'OPEX-OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				nonRecurringSum = rs.getDouble("SUM(Total_selling_price)");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeNonRecurring()");
		
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
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(TCVRecurring) FROM " + worksheetTitle 
					+ " WHERE Clients_payment_options != 'Outright' AND Clients_payment_options != 'OPEX-OTC'");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				recurringTCV= rs.getDouble("SUM(TCVRecurring)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeTCVRecurring()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return recurringTCV;
		
	}
	
	public double recurringQtyPercentage(String worksheetTitle){
		return TCVRecurring(worksheetTitle) / computeRecurring(worksheetTitle);
	}
	
	public double computeManagedITServicesCost(String worksheetTitle){
		double managedITservices = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ " WHERE Product_category = 'Managed IT Services'");
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				managedITservices = rs.getDouble("SUM(Total_selling_price)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeManagedITservices()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return managedITservices;
	}
	
	public double computeDataCenterCost(String worksheetTitle){
		double dataCenter = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ " WHERE Product_category = 'Data Center'");
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				dataCenter = rs.getDouble("SUM(Total_selling_price)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeManagedITservices()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return dataCenter;
	}
	
	public double computeCloudCost(String worksheetTitle){
		double cloud = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ " WHERE Product_category = 'Cloud'");
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				cloud = rs.getDouble("SUM(Total_selling_price)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeManagedITservices()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return cloud;
	}
	
	public double computeCyberSecCost(String worksheetTitle){
		double cyberSec = 0.0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("SELECT SUM(total_selling_price) FROM " + worksheetTitle 
					+ " WHERE Product_category = 'Cyber Security'");
			ResultSet rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				cyberSec = rs.getDouble("SUM(Total_selling_price)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQLException in ProfitORLossComputations - computeManagedITservices()");
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return cyberSec;
	}

}
