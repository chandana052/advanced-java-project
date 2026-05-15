<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<html>
<head>
<title>Report Criteria</title>

<style>

body{
    font-family: Arial;
    background:#f2f2f2;
    text-align:center;
}

.box{
    width:400px;
    background:white;
    margin:auto;
    margin-top:50px;
    padding:20px;
    border-radius:10px;
}

input{
    padding:8px;
    margin:5px;
    width:200px;
}

button{
    padding:8px 15px;
    background:green;
    color:white;
    border:none;
    cursor:pointer;
}

button:hover{
    background:darkgreen;
}

</style>

</head>

<body>

<div class="box">

<h2>Employee Reports</h2>

<form action="ReportCriteriaServlet" method="post">

    <h3>Name Starts With</h3>

    <input type="text" name="letter" placeholder="Enter Letter">

    <button type="submit" name="reportType" value="name">
        Generate
    </button>

    <br><br>

    <h3>Experience Greater Than</h3>

    <input type="number" name="years" placeholder="Enter Years">

    <button type="submit" name="reportType" value="experience">
        Generate
    </button>

    <br><br>

    <h3>Salary Greater Than</h3>

    <input type="number" name="salary" placeholder="Enter Salary">

    <button type="submit" name="reportType" value="salary">
        Generate
    </button>

</form>

<br>

<a href="index.jsp">Back</a>

</div>

</body>
</html>