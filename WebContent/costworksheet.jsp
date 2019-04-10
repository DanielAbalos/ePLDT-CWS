<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
  	
  	<title>Cost Worksheet</title>
</head>

<body style="background-color:whitesmoke;">
	<%@ page import = "java.text.SimpleDateFormat,
	    java.util.Date,
	    java.sql.Connection,
	    java.sql.DriverManager,
	    java.sql.ResultSet,
	    java.sql.SQLException,
	    java.sql.Statement"
	 %>
	
	<h1 align = "center">Project <%= request.getAttribute("worksheetTitle") %></h1>
	
	<nav id = "nav">
		<ul>
      		<li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>
      	</ul>
    </nav>
    
	<form action="costworksheet.html" method = "POST" autocomplete = "off">
 	<!--Button for CreateNewWorksheet-->
 	<br></br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   	
   	<a href="#popup1" class="pop button">Create New Product</a>
   	
	<!--Button for PopUp page-->
 	<div id="popup1" class="overlay">
    	<div class="popup">
			
			<form action="additems.html" method="POST">
				<h2>New Project</h2>
    			<a class="close" href="#">&times;</a>
    		
    			<p>
			   		<label style="width:120px;">Plan Name:</label>
			        <select name = "planName">
					<%
						try{
					    	Class.forName("com.mysql.jdbc.Driver");
					        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					        Statement stmt = conn.createStatement();
					        ResultSet rs = stmt.executeQuery("SELECT * FROM `products` ORDER BY plan_name");
					        
					        while(rs.next()){
					%>
					       <option value =<%=rs.getInt("ID")%>><%=rs.getString("plan_name") %></option>
					<%
					     }
					    }catch(SQLException sqle){
					     System.out.println("SQLException in costworksheet.jsp");
					     sqle.printStackTrace();
					    }
					%>
       				</select>
       			</p>
       
       			<p>
          			<label style="width:120px;">Quantity:</label>
          			<input style="width:150px;" type="number" name="qty" min="1" required>&nbsp;&nbsp; &nbsp;
          			
          			<label style="width:120px;">Client's Payment Options:</label>
          			<select name = "paymentOptions">
            			<option value = "OPEX Annual">OPEX - Annual</option>
	    				<option value = "OPEX Semi-annual">OPEX - Semi-annual</option>
	    				<option value = "OPEX QRC">OPEX - QRC</option>
	    				<option value = "OPEX MRC">OPEX - MRC</option>
	    				<option value = "OPEX OTC">OPEX - OTC</option>
	    				<option value = "CAPEX Annual">CAPEX - Annual</option>
	    				<option value = "CAPEX Semi-annual">CAPEX - Semi-annual</option>
	    				<option value = "CAPEX QRC">CAPEX - QRC</option>
	    				<option value = "CAPEX MRC">CAPEX - MRC</option>
    				</select>
       			</p>
       			
       			<p>
       				<label style="width:120px;">Vendor:</label>
        			<input style="width:150px;" type="number" name="contractPeriod" min="1" required>&nbsp;&nbsp; &nbsp;
        			<input type = "hidden" name = "worksheetTitle" value = <%= request.getAttribute("worksheetTitle") %>>
       			</p>
    			
    			<!--Save and Clear Button (Popup)-->
       			<br></br>
          		
          		<div style="text-align: right;">
            		<input type = "reset" value = "Clear" class="clear">
            		<input type = "submit" value = "Save" class="save">
          		</div>
        	</div>
		</div>
	</form>
	
	<hr>

  	<section>
        <table cellpadding="0" cellspacing="0" border="0">
        	<thead class="tbl-header">
          		<tr>
		            <th>Plan Name</th>
		            <th>Product Description</th>
		            <th>Product Category</th>
		            <th>Vendor / Service</th>
		            <th>Quantity</th>
		            <th>Unit Costs</th>
		            <th>Total Buying Price</th>
		            <th>Client's Payment Options</th>
		            <th>Contract Period In</th>
		            <th>Amortized Period</th>
		            <th>Cost Of Money</th>
		            <th>Amortized Value</th>
		            <th>Applied Margin</th>
		            <th>Unit Selling Price</th>
		            <th>Total Selling Price</th>
          		</tr>
        	</thead>
     
	       <tbody class="tbl-content">
				<%
					try{
				    	Class.forName("com.mysql.jdbc.Driver");
				        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
				        Statement stmt = conn.createStatement();
				        ResultSet rs = stmt.executeQuery("SELECT * FROM " + request.getAttribute("worksheetTitle"));
				    
				        while(rs.next()){
				%>
		       	 <tr>
		        	<td align = "center"><%= rs.getString("ID") %></td>
		    		<td><%= rs.getString("plan_name") %></td>
		    		<td><%= rs.getString("product_category") %></td>
		    		<td><%= rs.getString("vendor") %></td>
		    		<td><%= rs.getString("qty") %></td>
		    		<td><%= rs.getString("unit_buying_costs") %></td>
		    		<td><%= rs.getString("total_buying_price") %></td>
		    		<td><%= rs.getString("clients_payment_options") %></td>
		    		<td><%= rs.getString("contract_period") %></td>
		    		<td><%= rs.getString("period_amortized") %></td>
		    		<td><%= rs.getString("cost_of_money") %></td>
		    		<td><%= rs.getString("amortized_value") %></td>
		    		<td><%= rs.getString("applied_margin") %></td>
		    		<td><%= rs.getString("unit_selling_price") %></td>
		    		<td><%= rs.getString("total_selling_price") %></td>
		        </tr>
        
				<%
				  		}
				    }catch(SQLException sqle){
				    	System.out.println("SQLException in home.jsp");
				        sqle.printStackTrace();
				   	}
				%>
			
			</tbody>
		</table>
	</section>
</body>

<script src="cwstable.js"></script>
</html>
