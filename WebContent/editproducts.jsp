<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<<<<<<< HEAD
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" href="images/e.png">
    <link rel = "stylesheet" href = "css/cws.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title></title>
  </head>
  <body style="background-color:whitesmoke;">
=======

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Products</title>
</head>
<body>
>>>>>>> ea9809504d05ed3ef77f038a8b6655de0392fffc

    	<%@ page import = "java.sql.Connection,
    		java.sql.DriverManager,
    		java.sql.ResultSet,
    		java.sql.SQLException,
    		java.sql.Statement"
    	%>

    <br></br>
    	<h1 align = "center"> WELCOME BACK, <%= request.getAttribute("session") %></h1>

      <!--Navigation Bar-->
    <nav id = "nav">
      <ul>
        <li> <a href ="costworksheetlist.jsp"><font size="3"> ePLDT CWS </font> </a></li>
        &nbsp;&nbsp; &nbsp;&nbsp;
        <li> <a href ="proposalsummarylist.jsp"><font size="3"> Proposal Summary</font> </a></li>
        &nbsp;&nbsp; &nbsp;&nbsp;
        <li> <a href ="editproducts.jsp"><font size="3"> Product Catalog</font> </a></li>
      </ul>
    </nav>
    <!--Button for CreateNewWorksheet-->

    <br></br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="#popup1" class="pop button">Create New Product</a>
    <!--Button for PopUp page-->
    <div id="popup1" class="overlay">
    	<div class="popup">

<form action="additems.html" method="POST">
    		<h2>New Project</h2>
    		<a class="close" href="#">&times;</a>
    	<p>
    		<label style="width:120px;">Plan Name:</label>
          <input style="width:150px;" type="text" name="planName" required>

    	</p>
        <p>
          <label style="width:120px;">Product Name:</label>
          <input style="width:150px;" type="text" name="productName" required>
		  &nbsp;&nbsp; &nbsp;
          <label style="width:120px;">Product Category:</label>
          <input style="width:150px;" type="text" name="productCategory" required>
        </p>
        <p>
          <label style="width:120px;">Vendor:</label>
          <input style="width:150px;" type="text" name="vendor" required>
		 &nbsp;&nbsp; &nbsp;
          <label style="width:120px;">SRP:</label>
          <input style="width:150px;" type="text" name="srp" value = "<%= request.getAttribute("srp") %>" readonly>
        </p>
        <!--Save and Clear Button (Popup)-->
        <br></br>
        <div style="text-align: right;">
          <input type = "reset" value = "Clear" class="clear">
          <input type = "submit" value = "Save" class="save">
        </div>
    	</div>
    </div>
    <hr>

    <section>
          <div class="tbl-header">
          <table cellpadding="0" cellspacing="0" border="0">

        <tr>
            <th style="color: white;">Edit</th>
            <th style="color: white;">Product ID</th>
            <th style="color: white;">Plan Name</th>
            <th style="color: white;">Product Name</th>
            <th style="color: white;">Product Catgory</th>
            <th style="color: white;">Vendor</th>
            <th style="color: white;">SRP</th>
            </tr>
          </thead>
        </table>
      </div>

        <%
          try{
          Class.forName("com.mysql.jdbc.Driver");
          Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cws_db","root","");
          Statement stmt = conn.createStatement();
          ResultSet rs = stmt.executeQuery("SELECT * FROM `products`");

          while(rs.next()){
      %>
    <div class="tbl-content">
    <table cellpadding="0" cellspacing="0" border="0">
      <tbody>
      <tr>
				<td align = "center"><i class="fa fa-edit"style="font-size:25px"></i></td>
				<td align = "center"><%= rs.getString("ID") %></td>
				<td><%= rs.getString("plan_name") %></td>
				<td><%= rs.getString("product_name") %></td>
				<td><%= rs.getString("product_category") %></td>
				<td><%= rs.getString("vendor") %></td>
				<td><%= rs.getString("srp") %></td>
			</tr>
    </tbody>
  </table>
</div>
</section>
      <%
          }

        }catch(SQLException sqle){
          System.out.println("SQLException in home.jsp");
          sqle.printStackTrace();

        }

      %>
      </table>
  </body>
  <script src="cwstable.js"></script>
</html>
