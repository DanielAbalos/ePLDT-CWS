<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
	<meta charset="utf-8">
    <link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <title>Customer List</title>
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
        	<li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        	<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<li> <a href = "customers.jsp"><font size = "3"> Customer List</font></a>
      		<li style="float:right;"><form action = "logout.html" method = "POST">
					<input type = "submit" value = "Logout">
				</form>
			</li> 
		</ul>
    </nav>
    
    <!--Button for CreateNewWorksheet-->
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
    <br><br>
    
    <a href="#popup1" class="pop button">Add Customer</a>
    
    <!--Button for PopUp page-->
    <div id="popup1" class="overlay">
    	<div class="popup">
			<form action="addCustomer.html" method="POST">
    			<h2>New Project</h2>
    			<a class="close" href="#">&times;</a>
    			
    			<p>
    				<label style="width:120px;">Account Name:</label>
          			<input style="width:150px;" type="text" name="accountName" required>
    			</p>
        
        		<p>
          			<label style="width:120px;">Category:</label>
          			<input style="width:150px;" type="text" name="category" required>&nbsp;&nbsp;&nbsp;
        		</p>
        
        		<p>
         			<label style="width:120px;">Account Status:</label>
         			<select name = "accountStatus">
         				<option value = "ACTIVE">Active</option>
         			</select>
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
            		<th style="color: black;">Account Name</th>
            		<th style="color: black;">Category</th>
            		<th style="color: black;">Status</th>
            	</tr>
			</thead>   
			<%
				try{
					Class.forName("com.mysql.jdbc.Driver");
			    	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
			    	Statement stmt = conn.createStatement();
			    	ResultSet rs = stmt.executeQuery("SELECT * FROM `customers`");
				
			    	while(rs.next()){
			%>
    		
    		<tbody class="tbl-content">
      			<tr>
					<td><%= rs.getString("account_name") %></td>
					<td><%= rs.getString("customer_category") %></td>
					<td><%= rs.getString("account_status") %></td>
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
