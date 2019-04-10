<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
	
	<title>Proposal Summary</title>
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

	<section>
		<table cellpadding="0" cellspacing="0" border="0">
			<thead class="tbl-header">
		 		<tr>
					<th>Plan Name</th>
					<th>Quantity</th>
					<th>Unit Price</th>
					<th>Amount</th>
				</tr>
			</thead>
			
			<tbody class="tbl-content">
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
					<td align = "center"><%= rs.getInt("Qty") %>
					<td align = "center"><%= rs.getDouble("Unit_selling_price") %></td>
					<td align = "center"><%= rs.getDouble("Total_selling_price") %></td>
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