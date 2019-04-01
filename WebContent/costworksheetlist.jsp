<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
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

	<%
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
	%>
	
	<h1 align = "center"> WELCOME BACK, <%= request.getAttribute("session") %></h1>
	
	<form action = "logout.html" method = "POST">
		<input type = "submit" value = "Logout">
	</form>
	
	<center><iframe src="https://giphy.com/embed/13k4VSc3ngLPUY" width="480" height="298" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></center>
	
	<hr width = "40%">

	<form action="worksheets.html" autocomplete = "off" method = "POST">
		<table align = "center">
			<tr>
				<td colspan = "2"><h1>New Project</h1></td>
			</tr>
			
			<tr>
				<td align = "right">Worksheet Title: </td>
				<td><input type="text" name="worksheetTitle" required></td>
			</tr>
			
			<tr>
				<td align = "right">Customer Name: </td>
				<td><input type="text" name="customerName" required></td>
			</tr>
			
			<tr>
				<td align = "right">Project Description: </td>
				<td><input type="text" name="projectDescription" required></td>
			</tr>
			
			<tr>
				<td align = "right">Customer Type: </td>
				<td><input type="text" name="customerType" required></td>
			</tr>
			
			<tr>
				<td align = "right">Opportunity ID: </td>
				<td><input type="text" name="opportunityID" required></td>
			</tr>
			
			<tr>
				<td align = "right">Created By: </td>
				<td><input type="text" name="createdBy" value = <%= request.getAttribute("session") %> readonly></td>
			</tr>
			
			<tr>
				<td align = "right">Date: </td>
				<td><input type="text" name="customerName" readonly value=<%= format.format(date) %>></td>
			</tr>
			
			<tr>
				<td colspan = "2" align = "center"><input type = "submit" value = "Create New Worksheet"> &nbsp; <input type = "reset" value = "Clear"></td>
			</tr>
		
		</table>
	</form>
	
	<hr width = "90%">
	
	<form action = "costworksheet.jsp" method = "POST">
		<table align = "center" width = "100%">
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
				<td><%= rs.getString("ID") %></td>
				<td><%= rs.getString("worksheet_title") %>
				<td><%= rs.getString("customer_name") %></td>
				<td><%= rs.getString("project_description") %></td>
				<td><%= rs.getString("customer_type") %></td>
				<td><%= rs.getString("opportunityID") %></td>
				<td><%= rs.getString("created_by") %>
				<td><%= rs.getString("date") %></td>
				<td><%= rs.getString("status") %>
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
		
</body>
</html>
