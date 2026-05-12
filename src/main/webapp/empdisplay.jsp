<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee, java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Display Employee | EmpSMS</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp">Add</a>
  <a href="UpdateEmployeeServlet">Update</a>
  <a href="DeleteEmployeeServlet">Delete</a>
  <a href="DisplayEmployeeServlet" class="active">Display</a>
  <a href="report_form.jsp">Reports</a>
</nav>

<div class="page-wrapper">
  <div class="page-header">
    <h1>Display <span>Employee</span></h1>
    <p>Search by Employee ID for a single record, or view all employees.</p>
  </div>

  <%
    String msg     = (String) request.getAttribute("message");
    String msgType = (String) request.getAttribute("msgType");
    if (msg != null) {
  %>
  <div class="alert alert-<%= msgType %>"><%= msg %></div>
  <% } %>

  <div class="card">
    <form action="DisplayEmployeeServlet" method="get">
      <div class="search-row">
        <input type="number" name="empNo"
               placeholder="Enter Employee ID (leave blank to show all)..." min="1"/>
        <button type="submit" class="btn btn-primary">Search</button>
        <a href="DisplayEmployeeServlet" class="btn btn-outline">Show All</a>
      </div>
    </form>
  </div>

  <%
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp != null) {
  %>
  <div class="card">
    <div class="detail-grid">
      <div class="detail-item">
        <span class="detail-label">Employee ID</span>
        <span class="detail-value mono"><%= emp.getEmpNo() %></span>
      </div>
      <div class="detail-item">
        <span class="detail-label">Name</span>
        <span class="detail-value"><%= emp.getEmpName() %></span>
      </div>
      <div class="detail-item">
        <span class="detail-label">Date of Joining</span>
        <span class="detail-value"><%= emp.getDoJ() %></span>
      </div>
      <div class="detail-item">
        <span class="detail-label">Gender</span>
        <span class="detail-value"><%= emp.getGender() %></span>
      </div>
      <div class="detail-item">
        <span class="detail-label">Basic Salary</span>
        <span class="detail-value salary">Rs.<%= String.format("%.2f", emp.getBSalary()) %></span>
      </div>
    </div>
    <div class="btn-row">
      <a href="UpdateEmployeeServlet?empNo=<%= emp.getEmpNo() %>" class="btn btn-primary btn-sm">Edit</a>
      <a href="DeleteEmployeeServlet?empNo=<%= emp.getEmpNo() %>" class="btn btn-danger btn-sm">Delete</a>
    </div>
  </div>
  <% } %>

  <%
    @SuppressWarnings("unchecked")
    List<Employee> list = (List<Employee>) request.getAttribute("employeeList");
    if (list != null) {
  %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Empno</th>
          <th>Name</th>
          <th>Date of Joining</th>
          <th>Gender</th>
          <th>Basic Salary (Rs.)</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% if (list.isEmpty()) { %>
        <tr><td colspan="6" class="empty-state">No employee records found.</td></tr>
        <% } else {
             for (Employee e : list) { %>
        <tr>
          <td class="mono"><%= e.getEmpNo() %></td>
          <td><%= e.getEmpName() %></td>
          <td><%= e.getDoJ() %></td>
          <td><%= e.getGender() %></td>
          <td>Rs.<%= String.format("%,.2f", e.getBSalary()) %></td>
          <td>
            <a href="UpdateEmployeeServlet?empNo=<%= e.getEmpNo() %>"
               class="btn btn-outline btn-sm">Edit</a>
            <a href="DeleteEmployeeServlet?empNo=<%= e.getEmpNo() %>"
               class="btn btn-danger btn-sm" style="margin-left:.4rem;">Delete</a>
          </td>
        </tr>
        <%   }
           } %>
      </tbody>
    </table>
  </div>
  <% } %>

  <div style="margin-top:1.5rem;">
    <a href="index.jsp" class="btn btn-outline">Home</a>
  </div>
</div>

</body>
</html>
