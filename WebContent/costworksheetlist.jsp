<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
    
    <title>ePLDT CWS</title>
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
    	
	<h1 align = "center"> WELCOME BACK, <%= request.getAttribute("session") %></h1>

    <!--Navigation Bar-->
    <br>
    <nav id = "nav">
      	<ul>
			<li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font></a></li>&nbsp;&nbsp;&nbsp;&nbsp;
        	<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;
       		<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>
      	</ul>
	</nav>
		
	<!--Button for CreateNewWorksheet-->
	<br>
	<a href="#popup1" class="button">Create New Worksheet</a>
    
    <!--Button for PopUp page-->
    <div id="popup1" class="overlay">
    	<div class="popup">
			<form action="worksheets.html" method="POST">
				
				<h2>New Project</h2>
    			<a class="close" href="#">&times;</a>
    			
    			<p>
    				<label style="width:120px;">Worksheet Title:</label>
          			<input style="width:150px;" type="text" name="worksheetTitle" required>
    		
				</p>
        		
        		<p>
          			<label style="width:120px;">Customer Name:</label>
          			<input style="width:150px;" type="text" name="customerName" required>&nbsp;&nbsp; &nbsp;
          			<label style="width:120px;">Customer Type:</label>
          			<input style="width:150px;" type="text" name="customerType" required>
        		</p>
        
        		<p>
          			<label style="width:120px;">Project Description:</label>
          			<input style="width:150px;" type="text" name="projectDescription" required>&nbsp;&nbsp; &nbsp;
          			<label style="width:120px;">Created By:</label>
          			<input style="width:150px;" type="text" name="createdBy" value = "<%= request.getAttribute("session") %>" readonly>
          		</p>
        
        		<p>
          			<label style="width:120px;">Opportunity ID:</label>
          			<input style="width:150px;" type="text" name="opportunityID" required>&nbsp;&nbsp; &nbsp;
          			<label style="width:120px;">Date:</label>
          			<input style="width:150px;" type="text" name="date" readonly value=<%= format.format(date) %>>
        		</p>
        
        		<!--Save and Clear Button (Popup)-->
        		
        		<br>
        		<div style="text-align: right;">
          			<input type = "reset" value = "Clear" class="clear">
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
            			<th>Project Description</th>
            			<th>Customer Type</th>
            			<th>Opportunity ID</th>
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
    						ResultSet rs = stmt.executeQuery("SELECT * FROM `worksheets`");

    						while(rs.next()){
    				%>

    				<tr>
    					<td><input type = "button" onclick = "getProjectName('<%= rs.getString("worksheet_title") %>')" value = "edit"></td>
    					<td><%= rs.getString("ID") %></td>
    					<td><%= rs.getString("worksheet_title") %></td>
						<td><%= rs.getString("customer_name") %></td>
						<td><%= rs.getString("project_description") %></td>
						<td><%= rs.getString("customer_type") %></td>
						<td><%= rs.getString("opportunityID") %></td>
						<td><%= rs.getString("created_by") %>
						<td><%= rs.getString("date") %></td>
						<td><%= rs.getString("status") %></td>
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
