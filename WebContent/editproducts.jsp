<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	<meta charset="utf-8">
    <link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>Product Catalogue</title>
</head>

<body style="background-color:whitesmoke;">
	<%@ page import = "java.sql.Connection,
		java.sql.DriverManager,
	    java.sql.ResultSet,
	    java.sql.SQLException,
	    java.sql.Statement"
	%>

	<br>

	<!--Navigation Bar-->
  <nav id = "nav">
		<ul>
			<li style="margin-left:-25px;"> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font></a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
       		<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>
			<li style="float:right;"><form action = "logout.html" method = "POST">
		<input type = "submit" value = "Logout">
	</form></li>      	
      	</ul>
	</nav>
    <!--Button for CreateNewWorksheet-->
<br></br>


    <a href="#popup1" style="margin-left:50px;" class="pop button">Add Product</a>

    <!--Button for PopUp page-->
    <div id="popup1" class="overlay">
    	<div class="popup">
			<form action="additems.html" method="POST">
    			<h2>New Project</h2>
    			<a class="close" href="#">&times;</a>

    			<p>
    				    <label style="margin-left:20px; width:120px;">Plan Name:</label>
          			<input style="width:150px;" type="text" name="planName" required>
    			</p>

        		<p>
          			<label style="margin-left:20px; width:120px;">Product Name:</label>
          			<input style="width:150px;" type="text" name="productName" required>&nbsp;&nbsp; &nbsp;

         			  <label style="margin-left:120px; width:120px;">Product Category:</label>
          			<input style="width:150px;" type="text" name="productCategory" required>
        		</p>

        		<p>
         			  <label style="margin-left:20px; width:120px;">Vendor:</label>
         			  <input style="width:150px;" type="text" name="vendor" value = "ePLDT" readonly>&nbsp;&nbsp; &nbsp;

          			<label style="margin-left:120px; width:120px;">SRP:</label>
          			<input style="width:150px;" type="number" name="srp" min = "1">
        		</p>

        		<!--Save and Clear Button (Popup)-->
        		<br></br>

        		<div style="text-align: right;">
          			<input type = "reset" value = "Clear" class="clear">
          			<input type = "submit" value = "Save" class="save">
        		</div>
        	</form>
		</div>
	</div>

    <hr>

	<section>
		<table cellpadding="0" cellspacing="0" border="0">
    		<thead class="tbl-header">
        		<tr>
            		<th style="color: black;">Edit</th>
            		<th style="color: black;">Product ID</th>
            		<th style="color: black;">Plan Name</th>
            		<th style="color: black;">Product Name</th>
            		<th style="color: black;">Product Catgory</th>
           		 	<th style="color: black;">Vendor</th>
           		 	<th style="color: black;">SRP</th>
            	</tr>
			</thead>
			<%
				try{
					Class.forName("com.mysql.jdbc.Driver");
			    	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			    	Statement stmt = conn.createStatement();
			    	ResultSet rs = stmt.executeQuery("SELECT * FROM `products`");

			    	while(rs.next()){
			%>

    		<tbody class="tbl-content">
      			<tr>
					<td align = "center"><i class="fa fa-edit"style="font-size:25px"></i></td>
					<td align = "center"><%= rs.getString("ID") %></td>
					<td><%= rs.getString("plan_name") %></td>
					<td><%= rs.getString("product_name") %></td>
					<td><%= rs.getString("product_category") %></td>
					<td><%= rs.getString("vendor") %></td>
					<td><%= rs.getString("srp") %></td>
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
