<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee, java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Report Results | EmpSMS</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp">Add</a>
  <a href="UpdateEmployeeServlet">Update</a>
  <a href="DeleteEmployeeServlet">Delete</a>
  <a href="DisplayEmployeeServlet">Display</a>
  <a href="report_form.jsp" class="active">Reports</a>
</nav>

<div class="page-wrapper">

  <%
    String msg     = (String) request.getAttribute("message");
    String msgType = (String) request.getAttribute("msgType");
    if (msg != null) {
  %>
  <div class="alert alert-<%= msgType %>"><%= msg %></div>
  <% } %>

  <%
    @SuppressWarnings("unchecked")
    List<Employee> reportList = (List<Employee>) request.getAttribute("reportList");
    String reportTitle        = (String) request.getAttribute("reportTitle");

    if (reportList != null) {
  %>
  <div class="page-header">
    <h1>Report <span>Results</span></h1>
    <p><%= reportTitle %></p>
  </div>

  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Empno</th>
          <th>Name</th>
          <th>Date of Joining</th>
          <th>Years of Service</th>
          <th>Gender</th>
          <th>Basic Salary (Rs.)</th>
        </tr>
      </thead>
      <tbody>
        <% if (reportList.isEmpty()) { %>
        <tr><td colspan="6" class="empty-state">No records match the selected criteria.</td></tr>
        <% } else {
             for (Employee e : reportList) {
               java.time.LocalDate today = java.time.LocalDate.now();
               java.time.LocalDate doj   = e.getDoJ().toLocalDate();
               long years = java.time.temporal.ChronoUnit.YEARS.between(doj, today);
        %>
        <tr>
          <td class="mono"><%= e.getEmpNo() %></td>
          <td><%= e.getEmpName() %></td>
          <td><%= e.getDoJ() %></td>
          <td><%= years %> yr<%= years != 1 ? "s" : "" %></td>
          <td><%= e.getGender() %></td>
          <td>Rs.<%= String.format("%,.2f", e.getBSalary()) %></td>
        </tr>
        <%   }
           } %>
      </tbody>
    </table>
  </div>

  <% if (!reportList.isEmpty()) { %>
  <p style="color:var(--text-muted); font-size:.82rem; margin-top:.75rem;">
    Total records: <strong style="color:#f5a623;"><%= reportList.size() %></strong>
  </p>
  <% } %>
  <% } %>

  <div class="btn-row" style="margin-top:1.5rem;">
    <a href="report_form.jsp" class="btn btn-primary">New Report</a>
    <a href="index.jsp"       class="btn btn-outline">Home</a>
  </div>
</div>

</body>
</html>
