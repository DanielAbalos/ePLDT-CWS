<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Products</title>
</head>
<body>

	<%@ page import = "java.sql.Connection,
		java.sql.DriverManager,
		java.sql.ResultSet,
		java.sql.SQLException,
		java.sql.Statement"
	%>
	
	<center><iframe src="https://giphy.com/embed/TPl5N4Ci49ZQY" width="480" height="360" frameBorder="0" class="giphy-embed" allowFullScreen></iframe></center>
	
	<form action = "additems.html" method = "POST">
		<table width = "60%" align = "center">
		
			<tr>
				<td>Plan Name </td>
				<td><input type = "text" name = "planName" required></td>
			
				<td>Vendor </td>
				<td><input type = "text" name = "vendor" value = "ePLDT" disabled required></td>
			</tr>
		
			<tr>
				<td>Product Name </td>
				<td><input type = "text" name = "productName" required></td>
			
				<td>SRP </td>
				<td><input type = "text" name = "srp" required></td>
			</tr>
		
			<tr>
				<td>Product Category </td>
				<td><input type = "text" name = "productCategory" required></td>
			</tr>
		
			<tr>
				<td colspan = "4" align = "center"><input type = "submit" value = "Save"> &nbsp; <input type = "reset" value = "Clear"></td>
			</tr>
		
		</table>
	</form>

	<hr width = "70%">
	
	<table width = "60%" align = "center">
	
		<tr>
			<th>Edit</th>
			<th>Product ID </th>
			<th>Plan Name </th>
			<th>Product Name </th>
			<th>Product Category </th>
			<th>Vendor </th>
			<th>SRP </th>
		</tr>
		
			<%
	
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT * FROM `products`");
			
					while(rs.next()){
			%>
			
			<tr>
				<td align = "center"><img src="https://img.icons8.com/material-outlined/24/000000/multi-edit.png"></td>
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

	</table>

</body>
</html>