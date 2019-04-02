<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proposal Summary List</title>
</head>
<body>

	<%@ page import = "java.text.SimpleDateFormat,
		java.util.Date,
		java.sql.Connection,
		java.sql.DriverManager,
		java.sql.ResultSet,
		java.sql.SQLException,
		java.sql.Statement"
	%>
	
	<form action = "proposalsummary.jsp" method = "POST">
	
		<table align = "center" border = "1" width = "100%">
			<tr>
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
			
			<%
	
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM `worksheets`");
			
					while(rs.next()){
			%>
			
			<tr>
				<td><input type = "button" value = <%= rs.getString("worksheet_title") %>	>Edit</td>
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
			
		</table>
	</form>
		
	<script>
		function getProjectName(projectName){
			alert(projectName);
		};
	</script>

</body>
</html>