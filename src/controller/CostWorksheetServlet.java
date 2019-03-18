package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

import model.CostWorksheetBean;

@WebServlet("/costworksheet.html")
public class CostWorksheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CostWorksheetBean cwb = new CostWorksheetBean();
		
		String worksheetTitle = request.getParameter("worksheetTitle");
		
		cwb.setPlanName(fetchPlanName(request.getParameter("planName")));
		cwb.setProductCategory(fetchProductCategory(cwb.getPlanName()));
		cwb.setProvider(fetchVendor(cwb.getPlanName()));
		cwb.setQty(Integer.parseInt(request.getParameter("qty")));
		cwb.setUnitBuyingCosts(fetchUnitBuyingCosts(cwb.getPlanName()));
		cwb.setPaymentOptions(request.getParameter("paymentOptions"));
		cwb.setContractPeriod(Integer.parseInt(request.getParameter("contractPeriod")));
		cwb.setAppliedMargin(15);
		
		cwb.setTotalBuyingPrice(computeTotalBuyingPrice(cwb.getQty(), cwb.getUnitBuyingCosts()));
		cwb.setPeriodAmortized(computeNoOfPeriodAmortized(cwb.getPaymentOptions(), cwb.getContractPeriod()));
		cwb.setCostOfMoney(computeCostOfMoney(cwb.getPaymentOptions()));
		cwb.setAmortizedValue(computeAmortizedValue(cwb.getPaymentOptions(), cwb.getTotalBuyingPrice()));
		cwb.setUnitSellingPrice(computeUnitSellingPrice(cwb.getAmortizedValue(), cwb.getQty()));
		cwb.setTotalSellingPrice(computeTotalSellingPrice(cwb.getUnitSellingPrice(), cwb.getQty()));
		
		/*insertToDB(worksheetTitle, cwb.getPlanName(), cwb.getProductCategory(), cwb.getProvider(), cwb.getQty(), cwb.getUnitBuyingCosts(),
				cwb.getPaymentOptions(), cwb.getContractPeriod(), cwb.getAppliedMargin(), cwb.getTotalBuyingPrice(),
				cwb.getPeriodAmortized(), cwb.getCostOfMoney(), cwb.getAmortizedValue(), cwb.getUnitSellingPrice(),
				cwb.getTotalSellingPrice());*/
		
		System.out.println(request.getParameter("tableName"));
		
		System.out.println("PLAN NAME: " + cwb.getPlanName());
		System.out.println("PRODUCT CATEGORY: " + cwb.getProductCategory());
		System.out.println("PROVIDER: " + cwb.getProvider());
		System.out.println("QUANTITY: " + cwb.getQty());
		System.out.println("UNIT BUYING COST: " + cwb.getUnitBuyingCosts());
		System.out.println("PAYMENT OPTIONS: " + cwb.getPaymentOptions());
		System.out.println("CONTRACTED PERIOD: " + cwb.getContractPeriod());
		System.out.println("TOTAL BUYING PRICE: " + cwb.getTotalBuyingPrice());
		System.out.println("PERIOD AMORTIZED: " + cwb.getPeriodAmortized());
		System.out.println("COST OF MONEY: " + cwb.getCostOfMoney());
		System.out.println("AMORTIZED VALUE: " + cwb.getAmortizedValue());
		System.out.println("UNIT SELLING PRICE: " + cwb.getUnitSellingPrice());
		System.out.println("TOTAL SELLING PRICE: " + cwb.getTotalSellingPrice());
		
	}
	
	private static String fetchPlanName(String id){
		String planName = "";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("SELECT plan_name FROM products WHERE ID= '" + id + "';");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				planName = rs.getString("plan_name");
			}
			
			return planName;

		}catch(SQLException sqle){
			System.out.println("SQL Error in connectToUserDB - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return planName;
	}
	
	private static String fetchProductCategory(String planName){
		String productCategory = "";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("SELECT product_category FROM products WHERE plan_name= '" + planName + "';");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				productCategory = rs.getString("product_category");
			}
			
			return productCategory;

		}catch(SQLException sqle){
			System.out.println("SQL Error in connectToUserDB - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return productCategory;
	}
	
	private static String fetchVendor(String planName){
		String vendor = "";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("SELECT vendor FROM products WHERE plan_name= '" + planName + "';");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				vendor = rs.getString("vendor");
			}
			
			return vendor;

		}catch(SQLException sqle){
			System.out.println("SQL Error in connectToUserDB - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return vendor;
	}
	
	private static double fetchUnitBuyingCosts(String planName){
		double cost = 0.0;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("SELECT srp FROM products WHERE plan_name= '" + planName + "';");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				cost = rs.getDouble("srp");
			}
			
			return cost;

		}catch(SQLException sqle){
			System.out.println("SQL Error in connectToUserDB - Login.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return cost;
	}
	
	private static double computeTotalBuyingPrice(int qty, double totalBuyingCosts){
		return qty * totalBuyingCosts;
	}
	
	private static double computeNoOfPeriodAmortized(String paymentOptions, int contractedPeriod){
		
		switch(paymentOptions){
			case "OPEX Annual" :
				return contractedPeriod / 1;
				
			case "OPEX Semi-annual" :
				return contractedPeriod / 6;
				
			case "OPEX QRC" : 
				return contractedPeriod / 3;
				
			case "OPEX MRC" :
				return contractedPeriod;
				
			case "OPEX OTC" : 
				return 1;
				
			case "CAPEX Annual" : 
				return contractedPeriod / 12;
				
			case "CAPEX Semi-annual" : 
				return contractedPeriod / 6;
				
			case "CAPEX QRC" : 
				return contractedPeriod / 3;
				
			case "CAPEX MRC" :
				return contractedPeriod;
				
			default:
				return 0;
		}

	}
	
	private static double computeCostOfMoney(String paymentOptions){
		switch(paymentOptions){
			case "CAPEX Annual" : 
				return 0.08 / 1 * 100;
			
			case "CAPEX Semi-annual" : 
				return 0.08 / 2 * 100;
			
			case "CAPEX QRC" : 
				return 0.08 / 4 * 100;
			
			case "CAPEX MRC" :
				return 0.08 / 12 * 100;
			
			default:
				return 0;
		}
	}
	
	private static double computeAmortizedValue(String paymentOptions, double totalBuyingPrice){
		switch(paymentOptions){
			case "OPEX Annual" :
				return totalBuyingPrice;
			
			case "OPEX Semi-annual" :
				return totalBuyingPrice * 6;
			
			case "OPEX QRC" : 
				return totalBuyingPrice * 3;
			
			case "OPEX MRC" :
				return totalBuyingPrice;
			
			case "OPEX OTC" : 
				return totalBuyingPrice;
			
			/*case "CAPEX Annual" : 
				return contractedPeriod / 12;
			
			case "CAPEX Semi-annual" : 
				return contractedPeriod / 6;
			
			case "CAPEX QRC" : 
				return contractedPeriod / 3;
			
			case "CAPEX MRC" :
				return contractedPeriod * 1;*/
			
			default:
				return 0;
		}

	}
	
	private static double computeUnitSellingPrice(double amortizedValue, int qty){
		return amortizedValue / 0.85 / qty;
	}
	
	private static double computeTotalSellingPrice(double unitSellingPrice, int qty){
		return unitSellingPrice * qty;
	}
	
	private static void insertToDB(String worksheetTitle, String planName, String productCategory, String provider, int qty, 
			double unitBuyingCosts, String paymentOptions, int contractedPeriod, double appliedMargin,
			double totalBuyingPrice, double periodAmortized, double costOfMoney, double amortizedValue,
			double unitSellingPrice, double totalSellingPrice){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("INSERT INTO '" + worksheetTitle +"' "
					+ "(plan_name, product_category, provider, qty, unit_buying_costs, payment_options, contracted_period, "
					+ "applied_margin, total_buying_price, period_amortized, cost_of_money, amortized_value, "
					+ "unit_selling_price, total_selling_price)"
					+ "VALUES (?,?,?,?,?,?)");
			
			pstmt.setString(1, planName);
			pstmt.setString(2, productCategory);
			pstmt.setString(3, provider);
			pstmt.setInt(4, qty);
			pstmt.setDouble(5, unitBuyingCosts);
			pstmt.setString(6, paymentOptions);
			pstmt.setInt(7, contractedPeriod);
			pstmt.setDouble(8, appliedMargin);
			pstmt.setDouble(9, totalBuyingPrice);
			pstmt.setDouble(10, periodAmortized);
			pstmt.setDouble(11, costOfMoney);
			pstmt.setDouble(12, amortizedValue);
			pstmt.setDouble(13, unitSellingPrice);
			pstmt.setDouble(14, totalSellingPrice);
			
			pstmt.execute();

		}catch(SQLException sqle){
			System.out.println("SQL Error in saveNewWorksheetData - NewWorksheetServlet.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
	}
}
