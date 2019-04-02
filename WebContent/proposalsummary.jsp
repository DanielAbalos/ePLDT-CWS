<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proposal Summary</title>
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
	
	<form>
		
		<table align = "center" width = "70%" border = "1">
			
			<tr>
				<th>Plan Name</th>
				<th>Quantity</th>
				<th>Unit Price</th>
				<th>Amount</th>
			</tr>
			
			<%
				String projectName = request.getParameter("finalProjectName");
				System.out.println("PROPOSAL SUMMARY: " + projectName);
	
				try{
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("SELECT Plan_name, Qty, Unit_selling_price, Total_selling_price "
							+ "FROM " + projectName);
			
					while(rs.next()){
			%>
			
			<tr>
				<td><%= rs.getString("Plan_name") %></td>
				<td align = "right"><%= rs.getInt("Qty") %>
				<td align = "right"><%= rs.getDouble("Unit_selling_price") %></td>
				<td align = "right"><%= rs.getDouble("Total_selling_price") %></td>
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