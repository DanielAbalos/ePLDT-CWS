package controller;

import java.io.IOException;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.ProfitAndLossComputations;

import java.sql.PreparedStatement;
import java.text.DecimalFormat;

import model.CostWorksheetBean;
import model.ProfitAndLossSummaryBean;

@WebServlet("/costworksheet.html")
public class CostWorksheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("------------------------- COSTWORKSHEET SERVLET -------------------------");
		
		String userSession = "";
		
		Cookie[] cookies = request.getCookies();
		int i = 0;
		if(cookies != null){
			for (Cookie cookie : cookies ) {
				userSession = cookies[i].getName();
				System.out.println("INDEX COOKIE NAME: " + cookies[i].getName());
				System.out.println("INDEX COOKIE VALUE: " + cookies[i].getValue());
				i++;
			}
			
			if(!userSession.equals("userSession")){
				System.out.println("NO SESSION");
				response.sendRedirect("index.html");
			
			}else{
				response.sendRedirect("index.html");
			}
		
		}else{
			response.sendRedirect("index.html");
		}
		
		System.out.println("------------------------- COSTWORKSHEET SERVLET -------------------------");
		
		DecimalFormat df = new DecimalFormat("#.##");
		df.setRoundingMode(RoundingMode.CEILING);
		
		CostWorksheetBean cwb = new CostWorksheetBean();
		ProfitAndLossSummaryBean pnlb = new ProfitAndLossSummaryBean();
		
		String worksheetTitle = request.getParameter("worksheetTitle");
		//worksheetTitle = worksheetTitle.replace(" ", "");
		String customerType = request.getParameter("customerType");
		
		cwb.setPlanName(fetchPlanName(request.getParameter("planName")));
		cwb.setProductCategory(fetchProductCategory(cwb.getPlanName()));
		cwb.setProvider(fetchVendor(cwb.getPlanName()));
		cwb.setQty(Integer.parseInt(request.getParameter("qty")));
		cwb.setUnitBuyingCosts(Double.parseDouble(df.format(Double.parseDouble(request.getParameter("price")))));
		cwb.setPaymentOptions(request.getParameter("paymentOptions"));
		cwb.setContractPeriod(Integer.parseInt(request.getParameter("contractPeriod")));
		cwb.setAppliedMargin(Double.parseDouble(request.getParameter("appliedMargin")));
		
		cwb.setTotalBuyingPrice(Double.parseDouble(df.format(computeTotalBuyingPrice(cwb.getQty(), cwb.getUnitBuyingCosts()))));
		cwb.setPeriodAmortized(Double.parseDouble(df.format(computeNoOfPeriodAmortized(cwb.getPaymentOptions(), cwb.getContractPeriod()))));
		cwb.setCostOfMoney(Double.parseDouble(df.format(computeCostOfMoney(cwb.getPaymentOptions()))));
		cwb.setAmortizedValue(Double.parseDouble(df.format(computeAmortizedValue(cwb.getPaymentOptions(), cwb.getTotalBuyingPrice()))));
		cwb.setUnitSellingPrice(Double.parseDouble(df.format(computeUnitSellingPrice(cwb.getAmortizedValue(), cwb.getQty()))));
		cwb.setTotalSellingPrice(Double.parseDouble(df.format(computeTotalSellingPrice(cwb.getUnitSellingPrice(), cwb.getQty()))));
		cwb.setTCV_recurring(Double.parseDouble(df.format(recurring_TCV(cwb.getPaymentOptions(), cwb.getTotalSellingPrice(), cwb.getContractPeriod(), cwb.getPeriodAmortized()))));
		cwb.setAddedBy(request.getParameter("addedBy"));

		insertToDB(worksheetTitle, cwb.getPlanName(), cwb.getProductCategory(), cwb.getProvider(), cwb.getQty(), cwb.getUnitBuyingCosts(),
				cwb.getPaymentOptions(), cwb.getContractPeriod(), cwb.getAppliedMargin(), cwb.getTotalBuyingPrice(),
				cwb.getPeriodAmortized(), cwb.getCostOfMoney(), cwb.getAmortizedValue(), cwb.getUnitSellingPrice(),
				cwb.getTotalSellingPrice(), cwb.getTCV_recurring(), cwb.getAddedBy());
		
		//-------------------- COMPUTE TOTAL CONTRACT VALUES --------------------
		ProfitAndLossComputations pnl = new ProfitAndLossComputations();
		pnl.displayPNL(worksheetTitle);
		
		pnlb.setRevenues(Double.parseDouble(df.format(pnl.computeRevenues(worksheetTitle))));
		pnlb.setRecurring(Double.parseDouble(df.format(pnl.computeRecurring(worksheetTitle))));
		pnlb.setNonRecurring(Double.parseDouble(df.format(pnl.computeNonRecurring(worksheetTitle))));
		pnlb.setTCVrecurring(Double.parseDouble(df.format(pnl.TCVRecurring(worksheetTitle))));
		pnlb.setTCVnonRecurring(Double.parseDouble(df.format(pnl.computeNonRecurring(worksheetTitle))));
		pnlb.setCostOfManagedITservices(Double.parseDouble(df.format(pnl.computeManagedITServicesCost(worksheetTitle))));
		pnlb.setCostOfDataCenter(Double.parseDouble(df.format(pnl.computeDataCenterCost(worksheetTitle))));
		pnlb.setCostOfCloud(Double.parseDouble(df.format(pnl.computeCloudCost(worksheetTitle))));
		pnlb.setCostOfCyberSecurity(Double.parseDouble(df.format(pnl.computeCyberSecCost(worksheetTitle))));
		
		/*System.out.println("PLAN NAME: " + cwb.getPlanName());
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
		System.out.println("TOTAL SELLING PRICE: " + cwb.getTotalSellingPrice());*/
		
		request.setAttribute("worksheetTitle", worksheetTitle);
		request.setAttribute("pnlComp", pnlb);
		request.getRequestDispatcher("costworksheet.jsp").forward(request, response);
		
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
			System.out.println("SQL Error in fetchPlanName - CostWorksheetServlet.java");
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
			System.out.println("SQL Error in fetchProductCategory - CostWorksheetServlet.java");
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
			System.out.println("SQL Error in fetchVendor - CostWorksheetServlet.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return vendor;
	}
	
	/*private static double fetchUnitBuyingCosts(String planName){
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
			System.out.println("SQL Error in fetchUnitBuyingCosts - CostworksheetServlet.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
		return cost;
	}*/
	
	private static double computeTotalBuyingPrice(int qty, double totalBuyingCosts){
		return qty * totalBuyingCosts;
	}
	
	private static double computeNoOfPeriodAmortized(String paymentOptions, int contractedPeriod){
		
		switch(paymentOptions){
			case "Outright" :
				return 1;
				
			case "OPEX-Annual" :
				return contractedPeriod / 1;
				
			case "OPEX-Semi-annual" :
				return contractedPeriod / 6;
				
			case "OPEX-QRC" : 
				return contractedPeriod / 3;
				
			case "OPEX-MRC" :
				return contractedPeriod;
				
			case "OPEX-OTC" : 
				return 1;
				
			case "CAPEX-Annual" : 
				return contractedPeriod / 12;
				
			case "CAPEX-Semi-annual" : 
				return contractedPeriod / 6;
				
			case "CAPEX-QRC" : 
				return contractedPeriod / 3;
				
			case "CAPEX-MRC" :
				return contractedPeriod;
				
			default:
				return 0;
		}

	}
	
	private static double computeCostOfMoney(String paymentOptions){
		switch(paymentOptions){
			case "CAPEX-Annual" : 
				return 0.08 / 1 * 100;
			
			case "CAPEX-Semi-annual" : 
				return 0.08 / 2 * 100;
			
			case "CAPEX-QRC" : 
				return 0.08 / 4 * 100;
			
			case "CAPEX-MRC" :
				return 0.08 / 12 * 100;
			
			default:
				return 0;
		}
	}
	
	private static double computeAmortizedValue(String paymentOptions, double totalBuyingPrice){
		switch(paymentOptions){
			case "Outright" :
				return totalBuyingPrice;
				
			case "OPEX-Annual" :
				return totalBuyingPrice;
			
			case "OPEX-Semi-annual" :
				return totalBuyingPrice * 6;
			
			case "OPEX-QRC" : 
				return totalBuyingPrice * 3;
			
			case "OPEX-MRC" :
				return totalBuyingPrice;
			
			case "OPEX-OTC" : 
				return totalBuyingPrice;
			
			case "CAPEX-Annual" : 
				return totalBuyingPrice;
			
			case "CAPEX-Semi-annual" : 
				return totalBuyingPrice * 6;
			
			case "CAPEX-QRC" : 
				return totalBuyingPrice * 3;
			
			case "CAPEX-MRC" :
				return totalBuyingPrice;
			
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
			double unitSellingPrice, double totalSellingPrice, double TCVrecurring, String addedBy){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO " + worksheetTitle
					+ "(plan_name, product_category, vendor, qty, unit_buying_costs, total_buying_price, clients_payment_options, "
					+ "contract_period, period_amortized, cost_of_money, amortized_value, applied_margin,"
					+ "unit_selling_price, total_selling_price, TCVRecurring)"
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1, planName);
			pstmt.setString(2, productCategory);
			pstmt.setString(3, provider);
			pstmt.setInt(4, qty);
			pstmt.setDouble(5, unitBuyingCosts);
			pstmt.setDouble(6, totalBuyingPrice);
			pstmt.setString(7, paymentOptions);
			pstmt.setInt(8, contractedPeriod);
			pstmt.setDouble(9, periodAmortized);
			pstmt.setDouble(10, costOfMoney);
			pstmt.setDouble(11, amortizedValue);
			pstmt.setDouble(12, 0.15);
			pstmt.setDouble(13, unitSellingPrice);
			pstmt.setDouble(14, totalSellingPrice);
			pstmt.setDouble(15, TCVrecurring);
			pstmt.setString(16, addedBy);
			
			pstmt.execute();
			
			conn.close();

		}catch(SQLException sqle){
			System.out.println("SQL Error in insertToDB - CostWorksheetServlet.java");
			sqle.printStackTrace();
		
		}catch(ClassNotFoundException cnfe){
			cnfe.printStackTrace();
		}
		
	}
	
	public double recurring_TCV(String paymentOptions, double totalSellingPrice, int contractPeriod, double periodAmortized){
		switch(paymentOptions){
			case "OPEX-Semi-annual" :
				return totalSellingPrice * (contractPeriod / 6);
			
			case "OPEX-QRC" :
				return totalSellingPrice * (contractPeriod / 3);
			
			case "OPEX-Annual" :
				return totalSellingPrice * (contractPeriod / 12);
			
			default :
				return totalSellingPrice * periodAmortized;
		}
	}
}
