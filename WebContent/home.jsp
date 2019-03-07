<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%@ page import = "java.text.SimpleDateFormat,
		java.util.Date"
	%>

	<%
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
	%>
	
	<h1 align = "center"><%= request.getAttribute("session") %></h1>
	
	<center><iframe src="https://giphy.com/embed/13k4VSc3ngLPUY" width="480" height="298" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></center>
	
	<hr width = "40%">

	<form action="newworksheetservlet.html">
		<table align = "center">
			<tr>
				<td colspan = "2"><h1>New Project</h1></td>
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
				<td align = "right">Date: </td>
				<td><input type="text" name="customerName" disabled value=<%= format.format(date) %>></td>
			</tr>
			
			<tr>
				<td colspan = "2" align = "center"><input type = "submit" value = "Create New Worksheet"> &nbsp; <input type = "reset" value = "Clear"></td>
			</tr>
		
		</table>
	</form>
	
	<hr width = "90%">
	
</body>
</html>
