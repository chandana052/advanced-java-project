<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Update Employee | EmpSMS</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp">Add</a>
  <a href="UpdateEmployeeServlet" class="active">Update</a>
  <a href="DeleteEmployeeServlet">Delete</a>
  <a href="DisplayEmployeeServlet">Display</a>
  <a href="report_form.jsp">Reports</a>
</nav>

<div class="page-wrapper">
  <div class="page-header">
    <h1>Update <span>Employee</span></h1>
    <p>Enter the Employee ID to load the record, then make your changes.</p>
  </div>

  <%
    String msg     = (String) request.getAttribute("message");
    String msgType = (String) request.getAttribute("msgType");
    if (msg != null) {
  %>
  <div class="alert alert-<%= msgType %>"><%= msg %></div>
  <% } %>

  <div class="card">
    <form action="UpdateEmployeeServlet" method="get">
      <div class="search-row">
        <input type="number" name="empNo"
               placeholder="Enter Employee ID to search..." min="1" required/>
        <button type="submit" class="btn btn-primary">Load Record</button>
      </div>
    </form>
  </div>

  <%
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp != null) {
  %>
  <div class="card">
    <form action="UpdateEmployeeServlet" method="post">

      <div class="form-grid">

        <div class="form-group">
          <label>Employee ID (Read-Only)</label>
          <input type="text" value="<%= emp.getEmpNo() %>" readonly
                 style="background:#1a1e2b; color:#f5a623; font-family:monospace; font-weight:600;"/>
          <input type="hidden" name="empNo" value="<%= emp.getEmpNo() %>"/>
        </div>

        <div class="form-group">
          <label for="empName">Employee Name *</label>
          <input type="text" id="empName" name="empName"
                 value="<%= emp.getEmpName() %>" required maxlength="100"/>
        </div>

        <div class="form-group">
          <label for="doj">Date of Joining *</label>
          <input type="date" id="doj" name="doj"
                 value="<%= emp.getDoJ() %>" required/>
        </div>

        <div class="form-group">
          <label for="gender">Gender *</label>
          <select id="gender" name="gender" required>
            <option value="Male"   <%= "Male".equals(emp.getGender())   ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(emp.getGender()) ? "selected" : "" %>>Female</option>
            <option value="Other"  <%= "Other".equals(emp.getGender())  ? "selected" : "" %>>Other</option>
          </select>
        </div>

        <div class="form-group">
          <label for="bSalary">Basic Salary (Rs.) *</label>
          <input type="number" id="bSalary" name="bSalary"
                 value="<%= emp.getBSalary() %>" min="0" step="0.01" required/>
        </div>

      </div>

      <div class="btn-row">
        <button type="submit" class="btn btn-primary">Update Employee</button>
        <a href="UpdateEmployeeServlet" class="btn btn-outline">Search Again</a>
        <a href="index.jsp" class="btn btn-outline">Home</a>
      </div>
    </form>
  </div>
  <% } %>

</div>
</body>
</html>
