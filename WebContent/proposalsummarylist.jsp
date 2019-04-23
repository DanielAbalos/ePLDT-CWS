<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="icon" href="images/e.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel = "stylesheet" href = "css/cws.css"/>
	
	<title>Proposal Summary List</title>
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

	<nav id = "nav">
    	<ul>
      		<li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      		<li> <a href = "customers.jsp"><font size = "3"> Customer List</font></a>
      	</ul>
	</nav>

	<br>
	
	<form action = "proposalsummary.jsp" method = "POST" id = "sendEditForm">
		<section>
			<table cellpadding="0" cellspacing="0" border="0">
				<thead class="tbl-header">
					<tr>
	        			<th>Edit</th>
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
				
				
				<tbody class="tbl-content">
					<%
						try{
							Class.forName("com.mysql.jdbc.Driver");
						    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
						    Statement stmt = conn.createStatement();
						    ResultSet rs = stmt.executeQuery("SELECT * FROM `worksheets`");
						
						    while(rs.next()){
						    	String projectName = rs.getString("worksheet_title");
					%>
				
					<tr>
						<td align = "center"><i class="fa fa-edit"style="font-size:25px" onclick = "getProjectName('<%= projectName.toString() %>')"></i></td>
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
		</section>
			
			<input type = "hidden" id = "finalProjectName" name = "finalProjectName">
	</form>
	
</body>

<script>
	function getProjectName(projectName){
   		var finalProjectName = document.getElementById("finalProjectName");
    	finalProjectName.value = projectName;

    	var form = document.getElementById("sendEditForm");
    	form.submit();
  	};
</script>
<script src="cwstable.js"></script>

</html>
