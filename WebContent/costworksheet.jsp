<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <link rel = "stylesheet" href = "css/cws.css"/>
    <title>Cost Worksheet JSP</title>
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
		<br></br>
    	<h1 align = "center">Project <%= request.getAttribute("worksheetTitle") %></h1>

    	<hr >


    <!--Navigation Bar-->
    <nav id = "nav">
      <ul>
        <li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>
        &nbsp;&nbsp; &nbsp;&nbsp;
        <li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>
        &nbsp;&nbsp; &nbsp;&nbsp;
        <li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>
      </ul>
    </nav>
    <form action="costworksheet.html" method = "POST" autocomplete = "off">

    		<table width = "60%" align = "center">
    			<tr>
    				<td>Plan Name</td>
    				<td><select name = "planName">
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

    				</select></td>
    			</tr>

    			<tr>
    				<td>Quantity</td>
    				<td><input type = "number" name = "qty" min = "1"></td>
    			</tr>

    			<tr>
    				<td>Client's Payment Options</td>
    				<td><select name = "paymentOptions">
    					<option value = "OPEX Annual">OPEX - Annual</option>
    					<option value = "OPEX Semi-annual">OPEX - Semi-annual</option>
    					<option value = "OPEX QRC">OPEX - QRC</option>
    					<option value = "OPEX MRC">OPEX - MRC</option>
    					<option value = "OPEX OTC">OPEX - OTC</option>
    					<option value = "CAPEX Annual">CAPEX - Annual</option>
    					<option value = "CAPEX Semi-annual">CAPEX - Semi-annual</option>
    					<option value = "CAPEX QRC">CAPEX - QRC</option>
    					<option value = "CAPEX MRC">CAPEX - MRC</option>
    				</select></td>
    			</tr>

    			<tr>
    				<td>Contract Period In Months</td>
    				<td><input type = "number" name = "contractPeriod" min = "1"></td>
    			</tr>

    			<tr>
    				<td><input type = "hidden" name = "worksheetTitle" value = <%= request.getAttribute("worksheetTitle") %>></td>
    			</tr>

    			<tr>
    		      <td colspan = "2" align = "center"><input type = "submit" value = "Save" class="save"> &nbsp; <input type = "reset" value = "Clear" class="clear"></td>
    			</tr>

    		</table>

    	</form>

      <table class="layout display responsive-table">
        <thead>
        <tr >
          <th>Plan Name</th>
  			<th>Product Description</th>
  			<th>Product Category</th>
  			<th>Vendor / Service</th>
  			<th>Quantity</th>
  			<th> Unit Buying / Monthly / Quarterly / Semi-Annual / Annual Costs</th>
  			<th>Total Buying Price</th>
  			<th>Client's Payment Options</th>
  			<th>Contract Period In</th>
  			<th>No.	Of Period Amortized</th>
  			<th>Cost Of Money</th>
  			<th>Amortized Value</th>
  			<th>Applied Margin</th>
  			<th>Unit Selling Price</th>
  			<th>Total Selling Price</th>
            </tr>

		<%

				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM " + request.getAttribute("worksheetTitle"));

					while(rs.next()){
			%>

    </thead>
    <tbody>

    			<tr>
    			<td></td>
    			<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
    			</tr>



    </tbody>
    <%
					}

				}catch(SQLException sqle){
					System.out.println("SQLException in home.jsp");
					sqle.printStackTrace();

				}

			%>


</table>


  </body>
</html>
