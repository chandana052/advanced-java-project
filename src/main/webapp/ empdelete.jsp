<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Employee"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Delete Employee | EmpSMS</title>
<link rel="stylesheet" href="css/style.css"/>
</head>
<body>

<nav>
  <a href="index.jsp" class="brand">EmpSMS</a>
  <a href="empadd.jsp">Add</a>
  <a href="UpdateEmployeeServlet">Update</a>
  <a href="empdelete.jsp" class="active">Delete</a>
  <a href="DisplayEmployeeServlet">Display</a>
  <a href="report_form.jsp">Reports</a>
</nav>

<%
    /* Read from session (set by DeleteEmployeeServlet) then clear immediately */
    String   msg     = (String)   session.getAttribute("deleteMsg");
    String   msgType = (String)   session.getAttribute("deleteMsgType");
    Employee emp     = (Employee) session.getAttribute("deleteEmp");

    session.removeAttribute("deleteMsg");
    session.removeAttribute("deleteMsgType");
    session.removeAttribute("deleteEmp");
%>

<div class="page-wrapper">
  <div class="page-header">
    <h1>Delete <span>Employee</span></h1>
    <p>Search by Employee ID to confirm before permanent deletion.</p>
  </div>

  <%-- Alert message --%>
  <% if (msg != null) { %>
  <div class="alert alert-<%= msgType %>"><%= msg %></div>
  <% } %>

  <%-- Step 1: Search form --%>
  <div class="card">
    <form action="DeleteEmployeeServlet" method="get">
      <div class="search-row">
        <input type="number" name="empNo"
               placeholder="Enter Employee ID..."
               min="1" required/>
        <button type="submit" class="btn btn-primary">Find Employee</button>
      </div>
    </form>
  </div>

  <%-- Step 2: Confirm delete (only shown when employee found) --%>
  <% if (emp != null) { %>
  <div class="card">
    <div class="detail-grid" style="margin-bottom:1.5rem;">
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

    <div class="confirm-box">
      <p>This action is <strong>permanent</strong>. Are you sure you want to delete
         <strong><%= emp.getEmpName() %></strong> (ID: <%= emp.getEmpNo() %>)?</p>
      <form action="DeleteEmployeeServlet" method="post">
        <input type="hidden" name="empNo" value="<%= emp.getEmpNo() %>"/>
        <div class="btn-row" style="margin-top:0;">
          <button type="submit" class="btn btn-danger">Yes, Delete</button>
          <a href="empdelete.jsp" class="btn btn-outline">Cancel</a>
        </div>
      </form>
    </div>
  </div>
  <% } %>

  <a href="index.jsp" class="btn btn-outline" style="margin-top:1rem;">Home</a>
</div>

</body>
</html>
