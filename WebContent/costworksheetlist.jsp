<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
	<meta charset="utf-8">
  	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<link rel ="icon" href="images/e.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link rel = "stylesheet" href = "css/cws.css"/>

	<title>ePLDT CWS</title>

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

	<%
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
	    Date date = new Date();
	%>

	<h1 align = "center"> WELCOME BACK, <%= authLevel[0] %></h1>

    <!--Navigation Bar-->
    <br>

    <nav id = "nav">
		<ul>
			<li style="margin-left:-25px;"> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font></a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
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
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

	<a href="#popup1" style="margin-left:15px;"class="button">Create New Worksheet</a>


    <!--Button for PopUp page-->
    <div id="popup1" class="overlay">
	    <div class="popup">

			<form action="worksheets.html" method="POST">
				<h2>New Project</h2>
				<a class="close" href="#">&times;</a>

		    	<p>
		        	<label style="margin-left:20px; width:120px;">Worksheet Title:</label>
		        	<input style="width:160px;" type="text" name="worksheetTitle" required>
				</p>

		      	<p>
		        	<label style="margin-left:20px; width:120px;">Customer Name:</label>
		        	<input style="width:160px;" type="text" name="customerName" required>&nbsp;&nbsp; &nbsp;

		        	<label style="margin-left:100px; width:120px;">Customer Type:</label>
		        	<select name = "customerType">
		        		<option>Third Party - Enterprise</option>
		        		<option>Third Party - Government</option>
		        		<option>Subsidiary and Affiliates</option>
		        	</select>
		     	</p>

		     	<p>
		        	<label style="margin-left:20px; width:120px;">Project Description:<textarea style="margin-left:125px;" rows = 5 cols = 50 name = "projectDescription"></textarea></label>

		     	</p>

          <p>
              <label style="margin-left:20px; width:120px;">Created By:</label>
              <input style="width:150px;" type="text" name="createdBy" value = "<%= authLevel[0] %>" readonly>

		        	<label style="margin-left:135px; width:120px;">Type:</label>
		        	<input style="width:150px;" type="text" name="type" value = "<%= authLevel[1] %>" readonly>
		     	</p>

		     	<p>
		        	<label style="margin-left:20px; width:120px;">Opportunity ID:</label>
		        	<input style="width:150px;" type="text" name="opportunityID" required>&nbsp;&nbsp; &nbsp;

		        	<label style="margin-left:120px; width:120px;">Date:</label>
		        	<input style="width:150px;" type="text" name="date" readonly value=<%= format.format(date) %>">
		    	</p>

		  		<!--Save and Clear Button (Popup)-->

		    	<br>
		      	<div style="text-align: right;">
		        	<input style ="margin-top: 25px;"type = "reset" value = "Clear" class="clear">
		        	<input type = "submit" value = "Save" class="save">
		      	</div>
			</form>
		</div>
	</div>

    <hr>

    <div class="page" style="overflow-x:auto;">
    	<form action = "editcostworksheet.html" id = "sendEditForm" method = "POST">
    		<table class="layout display responsive-table">
        		<thead>
        			<tr>
        				<th></th>
            			<th>ID</th>
            			<th>Worksheet Title</th>
            			<th>Customer Name</th>
            			<th>Customer Type</th>
            			<th>Opportunity ID</th>
            			<th>Type</th>
            			<th>Created By</th>
            			<th>Date Created</th>
            			<th>Current Status</th>
            		</tr>
    			</thead>

    			<tbody>

    				<%
    					try{
    						Class.forName("com.mysql.jdbc.Driver");
    						Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
    						Statement stmt = conn.createStatement();
    						ResultSet rs = stmt.executeQuery("SELECT * FROM `worksheets` WHERE type = '" + authLevel[1] + "'");

    						while(rs.next()){
    				%>

    				<tr>
    					<td align = "center"><i class="fa fa-edit"style="font-size:25px" onclick = "getProjectName('<%= rs.getString("worksheet_title") %>')"></i></td>
    					<td><%= rs.getString("ID") %></td>
    					<td><%= rs.getString("worksheet_title") %></td>
						<td><%= rs.getString("customer_name") %></td>
						<td><%= rs.getString("customer_type") %></td>
						<td><%= rs.getString("opportunityID") %></td>
						<td><%= rs.getString("type") %></td>
						<td><%= rs.getString("created_by") %>
						<td><%= rs.getString("date") %></td>
						<td><%= rs.getString("status") %></td>
    				</tr>

    				<%
    						}

    					}catch(SQLException sqle){
    						System.out.println("SQLException in costworksheetlist.jsp");
    						sqle.printStackTrace();

    					}

    				%>

				</tbody>
			</table>

			<input type = "hidden" id = "finalProjectName" name = "finalProjectName">

    	</form>
	</div>

</body>

	<script>
  		function getProjectName(projectName){
    		var finalProjectName = document.getElementById("finalProjectName");
    		finalProjectName.value = projectName;

    		var form = document.getElementById("sendEditForm");
    		form.submit();
  		};
	</script>

</html>
