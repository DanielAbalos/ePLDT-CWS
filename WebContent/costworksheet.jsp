<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.apache.catalina.connector.Request"%>
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

	 <%!
		String userSessionValue = "";
		String userSession = "";
		String[] authLevel;
	%>

	<%
		System.out.println("------------------------- COST WORKSHEET LIST --------------------");

		Cookie userSessionCookies[] = request.getCookies();
		int i = 0;
		for (Cookie cookie : userSessionCookies ) {
			userSession = userSessionCookies[i].getName();
			userSessionValue = userSessionCookies[i].getValue();
			System.out.println("COST WORKSHEET LIST: " + userSessionCookies[i].getName());
			System.out.println("COST WORKSHEET LIST: " + userSessionCookies[i].getValue());
			i++;
		}
		
		if(!userSession.equals("userSession")){
			System.out.println("NO SESSION");
			response.sendRedirect("login.html");
		}

		System.out.println(userSessionValue);
		authLevel = userSessionValue.split(",");

		System.out.println("------------------------- COST WORKSHEET LIST --------------------");

	%>

	<nav id = "nav">
		<ul>
      		<li style="margin-left:-25px;"> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<li> <a href = "customers.jsp"><font size = "3"> Customer List</font></a>
      		<li style="float:right;"><form action = "logout.html" method = "POST">
					<input type = "submit" value = "Logout">
				</form>
			</li> 
      	</ul>
    </nav>

	<form action="costworksheet.html" method = "POST" autocomplete = "off">
 	<!--Button for CreateNewWorksheet-->
 	<br></br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

   	<h2 align = "center">Project <%= request.getAttribute("worksheetTitle") %></h2>

   	<section>
   		<table>
   		<%
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM `worksheets` WHERE worksheet_title = '" + request.getAttribute("worksheetTitle") + "'");

				while(rs.next()){
		%>
   			<tr>
   				<td>Customer Name</td>
   				<td><%= rs.getString("customer_name") %></td>
   			</tr>

   			<tr>
   				<td>Customer Type</td>
   				<td><%= rs.getString("customer_type") %><input type = "hidden" name = "customerType" value = "<%= rs.getString("customer_type") %>"></td>
   			</tr>

   			<tr>
   				<td>Project Description</td>
   				<td><%= rs.getString("project_description") %></td>
   			</tr>

   			<tr>
   				<td>Opportunity ID</td>
   				<td><%= rs.getString("opportunityID") %></td>
   			</tr>

   		<%
				}
			}catch(SQLException sqle){
				System.out.println("SQLException in costworksheet.jsp");
				sqle.printStackTrace();
			}
		%>

   		</table>
   	</section>

   	<hr>
   	<br>

   	<h3 align = "center">Profit And Loss Summary</h3>

   	<section>
   		<table>
   			<tr>
   				<th></th>
   				<th>AMOUNT (VAT-EX)</th>
   				<th>QTY / PERCENTAGE</th>
   				<th>TOTAL CONTRACT VALUE(VAT-EX)</th>
   			</tr>

   			<tr>
   				<th>REVENUES</th>
   				<td></td>
   				<td></td>
   				<td>${ pnlComp.revenues }</td>
   			</tr>

   			<tr>
   				<th>Recurring</th>
   				<td>${pnlComp.recurring }</td>
   				<td>...</td>
   				<td>${pnlComp.TCVrecurring }</td>
   			</tr>

   			<tr>
   				<th>Non-recurring</th>
   				<td>${pnlComp.nonRecurring }</td>
   				<td>...</td>
   				<td>${pnlComp.TCVnonRecurring }</td>
   			</tr>

   			<tr>
   				<th>Cost of Sale</th>
   				<td>...</td>
   				<td>...</td>
   				<td>...</td>
   			</tr>

   			<tr>
   				<th>Managed IT Services</th>
   				<td>${pnlComp.costOfManagedITservices }</td>
   				<td>...</td>
   				<td>...</td>
   			</tr>

   			<tr>
   				<th>Data Center</th>
   				<td>${pnlComp.costOfDataCenter }</td>
   				<td>...</td>
   				<td>...</td>
   			</tr>

   			<tr>
   				<th>Cloud</th>
   				<td>${pnlComp.costOfCloud }</td>
   				<td>...</td>
   				<td>...</td>
   			</tr>

   			<tr>
   				<th>Cyber Security</th>
   				<td>${pnlComp.costOfCyberSecurity }</td>
   				<td>...</td>
   				<td>...</td>
   			</tr>

   		</table>
   	</section>

   	<hr>

   	<br><br>

   	<a href="#popup1" style="margin-left:50px;"class="pop button">Add New Item</a>

	<!--Button for PopUp page-->
 	<div id="popup1" class="overlay">
    	<div class="popup">
			<h2>New Project</h2>
    		<a class="close" href="#">&times;</a>

    		<!-- <p>
    			<label>Product Category: </label>
    			<select name = "productCategory"  id = "productCategory" onchange = "filterPlanName()">
    				<option value = "Managed IT Services">Managed IT Services</option>
    				<option value = "Data Center">Data Center</option>
    				<option value = "Cloud">Cloud</option>
    				<option value = "Cyber Security">Cyber Security</option>
    			</select>
    		</p> -->

    		<p>
			   	<label style="margin-left:20px; width:120px;">Plan Name:</label>
				<select style="margin-left:50px;"name = "planName">
				<%
					try{
				    	Class.forName("com.mysql.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					    Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery("SELECT * FROM `products` WHERE product_category = '" + authLevel[1] + "' ORDER BY plan_name");

						while(rs.next()){
				%>
					<option value =<%=rs.getInt("ID")%>><%=rs.getString("plan_name") %> - <%= rs.getDouble("srp") %></option>
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
       			<label style="margin-left:20px; width:120px;">Price: </label>
       			<input style="margin-left:50px;" type = "number" id = "price" name = "price" min = 1 value = "100.00">
       		</p>
       		
       		<p> 
       			<label style="margin-left:20px; width:120px;">Discount Level </label>
				
				<input style="margin-left:-60px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 1>
				<label style="margin-left:-110px; width:120px;">None</label>
				
				<input style="margin-left:-60px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 0.05>
				<label style="margin-left:-110px; width:120px;">RM Level (5%) </label>
			</p>
			
			<p>
				<input style="margin-left:-60px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 0.075>
				<label style="margin-left:-110px; width:120px;">BH Level (7.5%) </label>
			
				<input style="margin-left:85px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 0.10> 
				<label style="margin-left:-110px; width:120px;">CRM Head Level (10%) </label>
			</p>
			
			<p>
				<input style="margin-left:-60px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 0.125>
				<label style="margin-left:-120px; width:120px;">VYT/ All Level (12.5%) </label>
				
				<input style="margin-left:85px;" type="radio" id="dscLevel" name="dscLevel" onchange = "applyDiscount(this)" value = 0.15>
				<label style="margin-left:-110px; width:120px;"> JIH Level (15%) </label>
			</p>
			
			<p>
				<label style="margin-left:20px; width:120px;">Discounted price: </label>
				<input style="margin-left:50px; width:150px;" type="text" name="discountedPrice" id = "discountedPrice" min="1" value = 0.0 required readonly>&nbsp;&nbsp; &nbsp;
			</p>
       		
       		<p>
          		<label style="margin-left:20px; width:120px;">Quantity:</label>
          		<input style="margin-left:50px; width:150px;" type="number" name="qty" min="1" required>&nbsp;&nbsp; &nbsp;
         	</p>
          	<p>
          		<label style="margin-left:20px;">Client's Payment Options:</label>
          		<select style="margin-left:-80px;"name = "paymentOptions">
          			<option value = "Outright">Outright</option>
            		<option value = "OPEX-Annual">OPEX - Annual</option>
	    			<option value = "OPEX-Semi-annual">OPEX - Semi-annual</option>
	    			<option value = "OPEX-QRC">OPEX - QRC</option>
	    			<option value = "OPEX-MRC">OPEX - MRC</option>
	    			<option value = "OPEX-OTC">OPEX - OTC</option>
	    			<option value = "CAPEX-Annual">CAPEX - Annual</option>
	    			<option value = "CAPEX-Semi-annual">CAPEX - Semi-annual</option>
	    			<option value = "CAPEX-QRC">CAPEX - QRC</option>
	    			<option value = "CAPEX-MRC">CAPEX - MRC</option>
    			</select>
       		</p>

       		<p>
       			<label style="margin-left:20px;">Contract Period(Months)</label>
        		<input style="margin-left:-80px; width:150px;" type="number" name="contractPeriod" min="1" required>&nbsp;&nbsp; &nbsp;
       		</p>

       		<p>
       			<label style="margin-left:20px; width:120px;">Applied Margin</label>
        		<input style="margin-left:50px; width:150px;" type="number" name="appliedMargin" min="1" required>&nbsp;&nbsp; &nbsp;
       		</p>

       		<p>
       			<label style="margin-left:20px; width:120px;">Added by: </label>
        		<input style="margin-left:50px; width:150px;" type="text" name="addedBy" value = "<%= authLevel[0]  %>" readonly>&nbsp;&nbsp; &nbsp;
       		</p>

    		<!--Save and Clear Button (Popup)-->
       		<br></br>

       		<input type = "hidden" name = "worksheetTitle" value = "<%= request.getAttribute("worksheetTitle") %>">

          	<div style="text-align: right;">
            	<input type = "reset" value = "Clear" class="clear">
            	<input type = "submit" value = "Save" class="save">
          	</div>
        </div>
	</div>
	</form>

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
				        PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM " + request.getAttribute("worksheetTitle"));
				        ResultSet rs = pstmt.executeQuery();

				        while(rs.next()){
				%>
		       	 <tr>
		    		<td><%= rs.getString("plan_name") %></td>
		    		<td><!-- PRODUCT DESCRIPTION --></td>
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

<script>
	document.getElementById("dataCenter").style.display = "none";
	document.getElementById("cloud").style.display = "none";
	document.getElementById("cyberSec").style.display = "none";

	function filterPlanName(){
		if(document.getElementById("productCategory").value == "Managed IT Services"){
			document.getElementById("managedITservices").style.display = "block";

			document.getElementById("dataCenter").style.display = "none";
			document.getElementById("cloud").style.display = "none";
			document.getElementById("cyberSec").style.display = "none";

		}else if(document.getElementById("productCategory").value == "Data Center"){
			document.getElementById("dataCenter").style.display = "block";

			document.getElementById("managedITservices").style.display = "none";
			document.getElementById("cloud").style.display = "none";
			document.getElementById("cyberSec").style.display = "none";

		}else if(document.getElementById("productCategory").value == "Cloud"){
			document.getElementById("cloud").style.display = "block";

			document.getElementById("managedITservices").style.display = "none";
			document.getElementById("dataCenter").style.display = "none";
			document.getElementById("cyberSec").style.display = "none";

		}else if(document.getElementById("productCategory").value == "Cyber Security"){
			document.getElementById("cyberSec").style.display = "block";

			document.getElementById("managedITservices").style.display = "none";
			document.getElementById("dataCenter").style.display = "none";
			document.getElementById("cloud").style.display = "none";
		}
	}


</script>

<script src="cwstable.js"></script>

<script>
	
	function applyDiscount(dscLevel){
		document.getElementById("discountedPrice").value = document.getElementById("price").value - (document.getElementById("price").value * dscLevel.value);
	}

</script>
</html>
